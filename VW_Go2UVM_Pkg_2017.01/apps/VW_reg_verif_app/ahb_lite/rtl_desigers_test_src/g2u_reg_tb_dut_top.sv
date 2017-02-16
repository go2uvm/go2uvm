//* Copyright (c) 2004-2017 VerifWorks, Bangalore, India
//* http://www.verifworks.com 
//* Contact: support@verifworks.com 
//* 
//* This program is part of Go2UVM at www.go2uvm.org
//* Some portions of Go2UVM are free software.
//* You can redistribute it and/or modify  
//* it under the terms of the GNU Lesser General Public License as   
//* published by the Free Software Foundation, version 3.
//*
//* VerifWorks reserves the right to obfuscate part or full of the code
//* at any point in time. 
//* We also support a comemrical licensing option for an enhanced version
//* of Go2UVM, please contact us via support@verifworks.com
//
//* This program is distributed in the hope that it will be useful, but 
//* WITHOUT ANY WARRANTY; without even the implied warranty of 
//* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU 
//* Lesser General Lesser Public License for more details.
//*
//* You should have received a copy of the GNU Lesser General Public License
//* along with this program. If not, see <http://www.gnu.org/licenses/>.

module g2u_reg_tb_dut_top();

`include "g2u_reg_testlist.svi"

//  parameter CLOCK_PERIOD = 10; // Assign clock Period 

  logic clk;

  g2u_reg_if g2u_reg_if_0(.clk (clk) ); //instantiate uvc interface
  
 initial
  begin : cgen
    clk = 0;
    forever #10 clk <= ~clk; 
  end : cgen

  //instantiate and connect dut to interface(s) here
  AHB_Slave DUT1 ( .HRESETn(HRESETN),          
    		   .HSELx(HSELx),
   	           .H_ADDR(H_ADDR),
    		   .H_TRANS(HTRANS),
   		   .HWRITE(HWRITE),
    		   .HCLK(HCLK),
   		   .HSIZE(HSIZE),
   		   .HBURST(HBURST),
    		   .HWDATA(HWDATA),
    		   .HRDATA(HRDATA),
    		   .HREADY(HREADY),
    		   .HRESP(HRESP));

  initial
    begin
      uvm_config_db#(virtual g2u_reg_if)::set(.cntxt(null),
                                          .inst_name("uvm_test_top.g2u_reg_env_0.g2u_reg_agent_0"),
                                          .field_name("vif"),
                                          .value(g2u_reg_if_0));
    
      run_test();
    end
endmodule
