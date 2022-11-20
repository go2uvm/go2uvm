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


module vlb_g2u_tb_dut_top();

`include "vlb_g2u_testlist.svi"

//  parameter CLOCK_PERIOD = 10; // Assign clock Period 

  logic clk;

  g2u_reg_if vlb_g2u_if_0(.clk (clk) ); //instantiate uvc interface

 initial
  begin : cgen
    clk = 0;
    forever #10 clk <= ~clk; 
  end : cgen

  //instantiate and connect dut to interface(s) here
  vlb_dut dut (.clk(vlb_g2u_if_0.clk),
		    .rst_n(vlb_g2u_if_0.rst_n),
		    .data_in(vlb_g2u_if_0.data_in),
		    .wr_rd(vlb_g2u_if_0.wr_rd),
		    .wr_rd_valid(vlb_g2u_if_0.wr_rd_valid),
		    .addr(vlb_g2u_if_0.addr),
		    .data_out(vlb_g2u_if_0.data_out));


  initial
    begin
      uvm_config_db#(virtual g2u_reg_if)::set(.cntxt(null),
                                          .inst_name("uvm_test_top.g2u_env_0.vlb_g2u_agent_0"),
                                          .field_name("vif"),
                                          .value(vlb_g2u_if_0));
    
      run_test();
    end
endmodule
