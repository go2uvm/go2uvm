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


module i2c_g2u_tb_dut_top();

`include "i2c_g2u_testlist.svi"

//  parameter CLOCK_PERIOD = 10; // Assign clock Period 

  parameter SADR    = 7'b0010_000;
  logic clk;
	wire scl, scl0_o, scl0_oen, scl1_o, scl1_oen;
	wire sda, sda0_o, sda0_oen, sda1_o, sda1_oen;


  g2u_reg_if i2c_g2u_if_0(.clk (clk) ); //instantiate uvc interface
	// hookup wishbone_i2c_master core
	i2c_master_top i2c_top (

		// wishbone interface
		.wb_clk_i(i2c_g2u_if_0.clk),
		.wb_rst_i(1'b0),
		.arst_i(i2c_g2u_if_0.rst_n),
		.wb_adr_i(i2c_g2u_if_0.adr[2:0]),
		.wb_dat_i(i2c_g2u_if_0.dout),
		.wb_dat_o(i2c_g2u_if_0.din),
		.wb_we_i(i2c_g2u_if_0.we),
		.wb_stb_i(i2c_g2u_if_0.stb),
		.wb_cyc_i(i2c_g2u_if_0.cyc),
		.wb_ack_o(i2c_g2u_if_0.ack),

		// i2c signals
		.scl_pad_i(scl),
		.scl_pad_o(scl0_o),
		.scl_padoen_o(scl0_oen),
		.sda_pad_i(sda),
		.sda_pad_o(sda0_o),
		.sda_padoen_o(sda0_oen)
	);

	// hookup i2c slave model
	i2c_slave_model #(SADR) i2c_slave (
		.scl(scl),
		.sda(sda)
	);

        // create i2c lines
	delay m0_scl (scl0_oen ? 1'bz : scl0_o, scl),
	      m1_scl (scl1_oen ? 1'bz : scl1_o, scl),
	      m0_sda (sda0_oen ? 1'bz : sda0_o, sda),
	      m1_sda (sda1_oen ? 1'bz : sda1_o, sda);

	pullup p1(scl); // pullup scl line
	pullup p2(sda); // pullup sda line



 initial
  begin : cgen
    clk = 0;
    forever #10 clk <= ~clk; 
  end : cgen

  //instantiate and connect dut to interface(s) here
  
  initial
    begin
      uvm_config_db#(virtual g2u_reg_if)::set(.cntxt(null),
                                          .inst_name("uvm_test_top.g2u_reg_env_0.g2u_reg_agent_0"),
                                          .field_name("vif"),
                                          .value(i2c_g2u_if_0));
    
      run_test();
    end
endmodule

module delay (in, out);
  input  in;
  output out;

  assign out = in;

  specify
    (in => out) = (600,600);
  endspecify
endmodule


