/* 
* Copyright (c) 2004-2017 VerifWorks, Bangalore, India
* http://www.verifworks.com 
* Contact: support@verifworks.com 
* 
* This program is part of Go2UVM at www.go2uvm.org
* Some portions of Go2UVM are free software.
* You can redistribute it and/or modify  
* it under the terms of the GNU Lesser General Public License as   
* published by the Free Software Foundation, version 3.
*
* VerifWorks reserves the right to obfuscate part or full of the code
* at any point in time. 
* We also support a comemrical licensing option for an enhanced version
* of Go2UVM, please contact us via support@verifworks.com

* This program is distributed in the hope that it will be useful, but 
* WITHOUT ANY WARRANTY; without even the implied warranty of 
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU 
* Lesser General Lesser Public License for more details.
*
* You should have received a copy of the GNU Lesser General Public License
* along with this program. If not, see <http://www.gnu.org/licenses/>.
*/


// synopsys translate_off
`include "timescale.v"
// synopsys translate_on

`include "i2c_master_defines.v"

module i2c_master_bit_ctrl (
    input             clk,      // system clock
    input             rst,      // synchronous active high reset
    input             nReset,   // asynchronous active low reset
    input             ena,      // core enable signal

    input      [15:0] clk_cnt,  // clock prescale value

    input      [ 3:0] cmd,      // command (from byte controller)
    output reg        cmd_ack,  // command complete acknowledge
    output reg        busy,     // i2c bus busy
    output reg        al,       // i2c bus arbitration lost

    input             din,
    output reg        dout,

    input             scl_i,    // i2c clock line input
    output            scl_o,    // i2c clock line output
    output reg        scl_oen,  // i2c clock line output enable (active low)
    input             sda_i,    // i2c data line input
    output            sda_o,    // i2c data line output
    output reg        sda_oen   // i2c data line output enable (active low)
);


    //
    // variable declarations
    //

    reg [ 1:0] cSCL, cSDA;      // capture SCL and SDA
    reg [ 2:0] fSCL, fSDA;      // SCL and SDA filter inputs
    reg        sSCL, sSDA;      // filtered and synchronized SCL and SDA inputs
    reg        dSCL, dSDA;      // delayed versions of sSCL and sSDA
    reg        dscl_oen;        // delayed scl_oen
    reg        sda_chk;         // check SDA output (Multi-master arbitration)
    reg        clk_en;          // clock generation signals
    reg        slave_wait;      // slave inserts wait states
    reg [15:0] cnt;             // clock divider counter (synthesis)
    reg [13:0] filter_cnt;      // clock divider for filter


    // state machine variable
    reg [17:0] c_state; // synopsys enum_state

    //
    // module body
    //

    // whenever the slave is not ready it can delay the cycle by pulling SCL low
    // delay scl_oen
    always @(posedge clk)
      dscl_oen <= #1 scl_oen;

    // slave_wait is asserted when master wants to drive SCL high, but the slave pulls it low
    // slave_wait remains asserted until the slave releases SCL
    always @(posedge clk or negedge nReset)
      if (!nReset) slave_wait <= 1'b0;
      else         slave_wait <= (scl_oen & ~dscl_oen & ~sSCL) | (slave_wait & ~sSCL);

    // master drives SCL high, but another master pulls it low
    // master start counting down its low cycle now (clock synchronization)
    wire scl_sync   = dSCL & ~sSCL & scl_oen;


    // generate clk enable signal
    always @(posedge clk or negedge nReset)
      if (~nReset)
      begin
          cnt    <= #1 16'h0;
          clk_en <= #1 1'b1;
      end
      else if (rst || ~|cnt || !ena || scl_sync)
      begin
          cnt    <= #1 clk_cnt;
          clk_en <= #1 1'b1;
      end
      else if (slave_wait)
      begin
          cnt    <= #1 cnt;
          clk_en <= #1 1'b0;    
      end
      else
      begin
          cnt    <= #1 cnt - 16'h1;
          clk_en <= #1 1'b0;
      end


    // generate bus status controller

    // capture SDA and SCL
    // reduce metastability risk
    always @(posedge clk or negedge nReset)
      if (!nReset)
      begin
          cSCL <= #1 2'b00;
          cSDA <= #1 2'b00;
      end
      else if (rst)
      begin
          cSCL <= #1 2'b00;
          cSDA <= #1 2'b00;
      end
      else
      begin
          cSCL <= {cSCL[0],scl_i};
          cSDA <= {cSDA[0],sda_i};
      end


    // filter SCL and SDA signals; (attempt to) remove glitches
    always @(posedge clk or negedge nReset)
      if      (!nReset     ) filter_cnt <= 14'h0;
      else if (rst || !ena ) filter_cnt <= 14'h0;
      else if (~|filter_cnt) filter_cnt <= clk_cnt >> 2; //16x I2C bus frequency
      else                   filter_cnt <= filter_cnt -1;


    always @(posedge clk or negedge nReset)
      if (!nReset)
      begin
          fSCL <= 3'b111;
          fSDA <= 3'b111;
      end
      else if (rst)
      begin
          fSCL <= 3'b111;
          fSDA <= 3'b111;
      end
      else if (~|filter_cnt)
      begin
          fSCL <= {fSCL[1:0],cSCL[1]};
          fSDA <= {fSDA[1:0],cSDA[1]};
      end


    // generate filtered SCL and SDA signals
    always @(posedge clk or negedge nReset)
      if (~nReset)
      begin
          sSCL <= #1 1'b1;
          sSDA <= #1 1'b1;

          dSCL <= #1 1'b1;
          dSDA <= #1 1'b1;
      end
      else if (rst)
      begin
          sSCL <= #1 1'b1;
          sSDA <= #1 1'b1;

          dSCL <= #1 1'b1;
          dSDA <= #1 1'b1;
      end
      else
      begin
          sSCL <= #1 &fSCL[2:1] | &fSCL[1:0] | (fSCL[2] & fSCL[0]);
          sSDA <= #1 &fSDA[2:1] | &fSDA[1:0] | (fSDA[2] & fSDA[0]);

          dSCL <= #1 sSCL;
          dSDA <= #1 sSDA;
      end

    // detect start condition => detect falling edge on SDA while SCL is high
    // detect stop condition => detect rising edge on SDA while SCL is high
    reg sta_condition;
    reg sto_condition;
    always @(posedge clk or negedge nReset)
      if (~nReset)
      begin
          sta_condition <= #1 1'b0;
          sto_condition <= #1 1'b0;
      end
      else if (rst)
      begin
          sta_condition <= #1 1'b0;
          sto_condition <= #1 1'b0;
      end
      else
      begin
          sta_condition <= #1 ~sSDA &  dSDA & sSCL;
          sto_condition <= #1  sSDA & ~dSDA & sSCL;
      end


    // generate i2c bus busy signal
    always @(posedge clk or negedge nReset)
      if      (!nReset) busy <= #1 1'b0;
      else if (rst    ) busy <= #1 1'b0;
      else              busy <= #1 (sta_condition | busy) & ~sto_condition;


    // generate arbitration lost signal
    // aribitration lost when:
    // 1) master drives SDA high, but the i2c bus is low
    // 2) stop detected while not requested
    reg cmd_stop;
    always @(posedge clk or negedge nReset)
      if (~nReset)
          cmd_stop <= #1 1'b0;
      else if (rst)
          cmd_stop <= #1 1'b0;
      else if (clk_en)
          cmd_stop <= #1 cmd == `I2C_CMD_STOP;

    always @(posedge clk or negedge nReset)
      if (~nReset)
          al <= #1 1'b0;
      else if (rst)
          al <= #1 1'b0;
      else
          al <= #1 (sda_chk & ~sSDA & sda_oen) | (|c_state & sto_condition & ~cmd_stop);


    // generate dout signal (store SDA on rising edge of SCL)
    always @(posedge clk)
      if (sSCL & ~dSCL) dout <= #1 sSDA;


    // generate statemachine

    // nxt_state decoder
    parameter [17:0] idle    = 18'b0_0000_0000_0000_0000;
    parameter [17:0] start_a = 18'b0_0000_0000_0000_0001;
    parameter [17:0] start_b = 18'b0_0000_0000_0000_0010;
    parameter [17:0] start_c = 18'b0_0000_0000_0000_0100;
    parameter [17:0] start_d = 18'b0_0000_0000_0000_1000;
    parameter [17:0] start_e = 18'b0_0000_0000_0001_0000;
    parameter [17:0] stop_a  = 18'b0_0000_0000_0010_0000;
    parameter [17:0] stop_b  = 18'b0_0000_0000_0100_0000;
    parameter [17:0] stop_c  = 18'b0_0000_0000_1000_0000;
    parameter [17:0] stop_d  = 18'b0_0000_0001_0000_0000;
    parameter [17:0] rd_a    = 18'b0_0000_0010_0000_0000;
    parameter [17:0] rd_b    = 18'b0_0000_0100_0000_0000;
    parameter [17:0] rd_c    = 18'b0_0000_1000_0000_0000;
    parameter [17:0] rd_d    = 18'b0_0001_0000_0000_0000;
    parameter [17:0] wr_a    = 18'b0_0010_0000_0000_0000;
    parameter [17:0] wr_b    = 18'b0_0100_0000_0000_0000;
    parameter [17:0] wr_c    = 18'b0_1000_0000_0000_0000;
    parameter [17:0] wr_d    = 18'b1_0000_0000_0000_0000;

    always @(posedge clk or negedge nReset)
      if (!nReset)
      begin
          c_state <= #1 idle;
          cmd_ack <= #1 1'b0;
          scl_oen <= #1 1'b1;
          sda_oen <= #1 1'b1;
          sda_chk <= #1 1'b0;
      end
      else if (rst | al)
      begin
          c_state <= #1 idle;
          cmd_ack <= #1 1'b0;
          scl_oen <= #1 1'b1;
          sda_oen <= #1 1'b1;
          sda_chk <= #1 1'b0;
      end
      else
      begin
          cmd_ack   <= #1 1'b0; // default no command acknowledge + assert cmd_ack only 1clk cycle

          if (clk_en)
              case (c_state) // synopsys full_case parallel_case
                    // idle state
                    idle:
                    begin
                        case (cmd) // synopsys full_case parallel_case
                             `I2C_CMD_START: c_state <= #1 start_a;
                             `I2C_CMD_STOP:  c_state <= #1 stop_a;
                             `I2C_CMD_WRITE: c_state <= #1 wr_a;
                             `I2C_CMD_READ:  c_state <= #1 rd_a;
                             default:        c_state <= #1 idle;
                        endcase

                        scl_oen <= #1 scl_oen; // keep SCL in same state
                        sda_oen <= #1 sda_oen; // keep SDA in same state
                        sda_chk <= #1 1'b0;    // don't check SDA output
                    end

                    // start
                    start_a:
                    begin
                        c_state <= #1 start_b;
                        scl_oen <= #1 scl_oen; // keep SCL in same state
                        sda_oen <= #1 1'b1;    // set SDA high
                        sda_chk <= #1 1'b0;    // don't check SDA output
                    end

                    start_b:
                    begin
                        c_state <= #1 start_c;
                        scl_oen <= #1 1'b1; // set SCL high
                        sda_oen <= #1 1'b1; // keep SDA high
                        sda_chk <= #1 1'b0; // don't check SDA output
                    end

                    start_c:
                    begin
                        c_state <= #1 start_d;
                        scl_oen <= #1 1'b1; // keep SCL high
                        sda_oen <= #1 1'b0; // set SDA low
                        sda_chk <= #1 1'b0; // don't check SDA output
                    end

                    start_d:
                    begin
                        c_state <= #1 start_e;
                        scl_oen <= #1 1'b1; // keep SCL high
                        sda_oen <= #1 1'b0; // keep SDA low
                        sda_chk <= #1 1'b0; // don't check SDA output
                    end

                    start_e:
                    begin
                        c_state <= #1 idle;
                        cmd_ack <= #1 1'b1;
                        scl_oen <= #1 1'b0; // set SCL low
                        sda_oen <= #1 1'b0; // keep SDA low
                        sda_chk <= #1 1'b0; // don't check SDA output
                    end

                    // stop
                    stop_a:
                    begin
                        c_state <= #1 stop_b;
                        scl_oen <= #1 1'b0; // keep SCL low
                        sda_oen <= #1 1'b0; // set SDA low
                        sda_chk <= #1 1'b0; // don't check SDA output
                    end

                    stop_b:
                    begin
                        c_state <= #1 stop_c;
                        scl_oen <= #1 1'b1; // set SCL high
                        sda_oen <= #1 1'b0; // keep SDA low
                        sda_chk <= #1 1'b0; // don't check SDA output
                    end

                    stop_c:
                    begin
                        c_state <= #1 stop_d;
                        scl_oen <= #1 1'b1; // keep SCL high
                        sda_oen <= #1 1'b0; // keep SDA low
                        sda_chk <= #1 1'b0; // don't check SDA output
                    end

                    stop_d:
                    begin
                        c_state <= #1 idle;
                        cmd_ack <= #1 1'b1;
                        scl_oen <= #1 1'b1; // keep SCL high
                        sda_oen <= #1 1'b1; // set SDA high
                        sda_chk <= #1 1'b0; // don't check SDA output
                    end

                    // read
                    rd_a:
                    begin
                        c_state <= #1 rd_b;
                        scl_oen <= #1 1'b0; // keep SCL low
                        sda_oen <= #1 1'b1; // tri-state SDA
                        sda_chk <= #1 1'b0; // don't check SDA output
                    end

                    rd_b:
                    begin
                        c_state <= #1 rd_c;
                        scl_oen <= #1 1'b1; // set SCL high
                        sda_oen <= #1 1'b1; // keep SDA tri-stated
                        sda_chk <= #1 1'b0; // don't check SDA output
                    end

                    rd_c:
                    begin
                        c_state <= #1 rd_d;
                        scl_oen <= #1 1'b1; // keep SCL high
                        sda_oen <= #1 1'b1; // keep SDA tri-stated
                        sda_chk <= #1 1'b0; // don't check SDA output
                    end

                    rd_d:
                    begin
                        c_state <= #1 idle;
                        cmd_ack <= #1 1'b1;
                        scl_oen <= #1 1'b0; // set SCL low
                        sda_oen <= #1 1'b1; // keep SDA tri-stated
                        sda_chk <= #1 1'b0; // don't check SDA output
                    end

                    // write
                    wr_a:
                    begin
                        c_state <= #1 wr_b;
                        scl_oen <= #1 1'b0; // keep SCL low
                        sda_oen <= #1 din;  // set SDA
                        sda_chk <= #1 1'b0; // don't check SDA output (SCL low)
                    end

                    wr_b:
                    begin
                        c_state <= #1 wr_c;
                        scl_oen <= #1 1'b1; // set SCL high
                        sda_oen <= #1 din;  // keep SDA
                        sda_chk <= #1 1'b0; // don't check SDA output yet
                                            // allow some time for SDA and SCL to settle
                    end

                    wr_c:
                    begin
                        c_state <= #1 wr_d;
                        scl_oen <= #1 1'b1; // keep SCL high
                        sda_oen <= #1 din;
                        sda_chk <= #1 1'b1; // check SDA output
                    end

                    wr_d:
                    begin
                        c_state <= #1 idle;
                        cmd_ack <= #1 1'b1;
                        scl_oen <= #1 1'b0; // set SCL low
                        sda_oen <= #1 din;
                        sda_chk <= #1 1'b0; // don't check SDA output (SCL low)
                    end

              endcase
      end


    // assign scl and sda output (always gnd)
    assign scl_o = 1'b0;
    assign sda_o = 1'b0;

endmodule
