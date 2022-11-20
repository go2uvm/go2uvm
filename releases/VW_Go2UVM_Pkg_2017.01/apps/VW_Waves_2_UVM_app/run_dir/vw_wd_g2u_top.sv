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


// Generating Go2UVM top module for DUT: vw_wd_g2u_top
// ---------------------------------------------------------
module vw_wd_g2u_top;
  timeunit 1ns;
  timeprecision 1ns;
  parameter VW_CLK_PERIOD = 10;
  // Simple clock generator
  bit clk ;
  always # (VW_CLK_PERIOD/2) clk <= ~clk;
  // Interface instance
  vw_wd_g2u_if vw_wd_g2u_if_0 (.*);
  assign vw_wd_g2u_if_0.clk = clk; 

  // Using VW_Go2UVM
  vw_wd_g2u_test vw_wd_g2u_test_0;
  initial begin : go2uvm_test
    vw_wd_g2u_test_0 = new (); 

    // Connect virtual interface to physical interface
    uvm_config_db#(virtual vw_wd_g2u_if)::set( 
     .cntxt(null), .inst_name("*"), 
     .field_name("vif"), .value(vw_wd_g2u_if_0)); 

    // Kick start standard UVM phasing
    run_test ();
  end : go2uvm_test
endmodule : vw_wd_g2u_top 
