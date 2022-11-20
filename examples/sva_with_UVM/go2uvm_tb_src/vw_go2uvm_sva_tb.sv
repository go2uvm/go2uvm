// Copyright (c) 2004-2017 VerifWorks, Bangalore, India
// http://www.verifworks.com 
// Contact: support@verifworks.com 
// 
// This program is part of Go2UVM at www.go2uvm.org
// Some portions of Go2UVM are free software.
// You can redistribute it and/or modify  
// it under the terms of the GNU Lesser General Public License as   
// published by the Free Software Foundation, version 3.
//
// VerifWorks reserves the right to obfuscate part or full of the code
// at any point in time. 
// We also support a comemrical licensing option for an enhanced version
// of Go2UVM, please contact us via support@verifworks.com
//
// This program is distributed in the hope that it will be useful, but 
// WITHOUT ANY WARRANTY; without even the implied warranty of 
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU 
// Lesser General Lesser Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public License
// along with this program. If not, see <http://www.gnu.org/licenses/>.


import uvm_pkg::*;
`include "uvm_macros.svh"

// VW_UVM_SVA
// Use this package to get VW's UVM Pkg for SVA tests
import vw_go2uvm_pkg::*;

// VW_UVM_SVA
// In file ../sva_src/simple_sva_example.sv a simple SV interface
// named sva_if is coded with a simple assertion
// We will write a UVM trace in this file for the same

// VW_UVM_SVA
// Use the base class provided by the vw_go2uvm_pkg

`G2U_TEST_BEGIN(sva_test)

// Connect to a design interface
  `G2U_GET_VIF(sva_if)


  // VW_UVM_SVA
  // Drive your stimulus as desired
  // The below code should be very familiar to even a Verilog engineer
  // Only additional features shown are the clocking-block and `g2u_display macros

 task main ();
  this.vif.cb.a <= 1'b0;
  this.vif.cb.b <= 1'b0;
  @ (this.vif.cb);
  this.vif.cb.start <= 1'b1;
  @ (this.vif.cb);
  this.vif.cb.start <= 1'b0;
  this.vif.cb.a <= 1'b1;
  @ (this.vif.cb);
  this.vif.cb.a <= 1'b0;
  @ (this.vif.cb);
  `g2u_display ("Expect a SVA failure as b is NOT high")
  `g2u_display ("Expect a SVA failure as b is NOT high")
  @ (this.vif.cb);
  `g2u_display ("End of 1 trace")

 endtask : main
`G2U_TEST_END


module sva_uvm;
  parameter CLK_HPERIOD = 10;
  logic clk = 1'b0;
  // VW_UVM_SVA
  // The Test class
  sva_test sva_test_0;
  sva_if sva_if_0 (.*);

  always #(CLK_HPERIOD) clk <= ~clk;

  initial begin : stim
    sva_test_0 = new ();
    // VW_UVM_SVA
    // Connect virtual interface to physical interface
    `G2U_SET_VIF (sva_if ,sva_if_0 )
    `g2u_display ("Starting run_test")
    run_test (); // "sva_test");
  end : stim

endmodule : sva_uvm
