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


//Memory Controller
  module vlb_dut#(parameter DWIDTH=32,AWIDTH=8)
                (input       clk,             
		input       rst_n,
		input  [DWIDTH-1:0]data_in,
		input       wr_rd,
		input       wr_rd_valid,
		input [AWIDTH-1:0]addr,
	
		output reg [DWIDTH-1:0]data_out);  

  //Internal Signal Declarations	
  reg [DWIDTH-1:0]memory[2**AWIDTH-1:0]; //MEM Declarations for  MEMORY

  import vlb_regs_pkg::*;

  logic [DWIDTH-1:0] vl_data;
  logic [DWIDTH-1:0] vl_ctrl;
  logic [DWIDTH-1:0] vl_volatile_counter;

 //READ-WRITE ACCESS OF MEMORY
  always @ (posedge clk or negedge rst_n)
  begin:MEMORY_ACCESS
    if(!rst_n)
    begin : RESET
      data_out <= 8'd0;
      vl_data <= 0;
      `ifdef BUG_FIX_1
        vl_ctrl <= 0;
      `else // BUG_FIX_1
        vl_ctrl <= 10;
      `endif // BUG_FIX_1
      vl_volatile_counter <= VLB_VOL_RST_VAL;
    end : RESET
    else if(wr_rd_valid)
    begin :WRITE_READ
      vl_volatile_counter <= vl_volatile_counter + 1;
      if(wr_rd) begin : wr
        `g2u_display ($sformatf("RTL Write: addr: 0x%0h data: 0x%0h",
             addr, data_in))
        memory[addr] <= data_in;
        if (addr == VLB_DATA_REG_ADDR)
          vl_data <= data_in;
        if (addr == VLB_CTRL_REG_ADDR)
          vl_ctrl <= data_in;
      end : wr
      else begin : rd
        `g2u_display ("RTL RD")
        if (addr == VLB_VOLATILE_REG_ADDR)
        begin : vol_rd
          data_out <= vl_volatile_counter;
        end : vol_rd
        else begin : normal_rd
          `g2u_display ($sformatf("RTL read: addr: 0x%0h data: 0x%0h",
             addr, memory[addr]))
          data_out <= memory[addr];
          if (addr == VLB_DATA_REG_ADDR)
            data_out <= vl_data;
          if (addr == VLB_CTRL_REG_ADDR)
            data_out <= vl_ctrl;
        end : normal_rd
      end : rd

    end : WRITE_READ
  end : MEMORY_ACCESS

endmodule
