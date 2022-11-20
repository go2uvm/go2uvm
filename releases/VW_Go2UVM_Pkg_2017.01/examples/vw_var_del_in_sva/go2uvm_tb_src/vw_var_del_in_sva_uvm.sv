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

import vw_go2uvm_pkg::*;

`define TOP top

class sva_test extends go2uvm_base_test;
  `uvm_component_utils(sva_test)
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  virtual task reset();
    `TOP.rst_n <= 1'b0;
    repeat (10) @ (posedge `TOP.clk);
    `TOP.rst_n <= 1'b1;
    repeat (3) @ (posedge `TOP.clk);
    `g2u_display ("End of Reset")
  endtask : reset
  virtual task main();

    `g2u_display ("Start of PASS trace")
    `TOP.start_sig <= 1; 
    `TOP.end_sig <= 0;
    repeat (1) @ (posedge `TOP.clk);
    `TOP.start_sig<= 0; 
    `TOP.end_sig <= 1;
    repeat (1) @ (posedge `TOP.clk);
    `TOP.end_sig<= 0; 
    `g2u_display ("End of PASS trace")
    repeat (3) @ (posedge `TOP.clk);

    `g2u_display ("Start of FAIL trace")
    `TOP.start_sig <= 1; 
    `TOP.end_sig <= 0;
    repeat (1) @ (posedge `TOP.clk);
    `TOP.start_sig<= 0; 
    repeat (10) @ (posedge `TOP.clk);
    `TOP.end_sig <= 1;
    //uvm_report_mock::expect_error ("*", "*");
    repeat (1) @ (posedge `TOP.clk);
    `TOP.end_sig<= 0; 
    `g2u_display ("End of FAIL trace")
    repeat (3) @ (posedge `TOP.clk);



  endtask : main
endclass : sva_test

module top;
  logic clk=0, start_sig=0, end_sig=0;
  logic rst_n = 0;

  initial forever #10 clk=!clk; 
  int   var_del; 
  initial var_del =3;

  // Instantiate the DUT
  vw_var_del_in_sva dut (.*);

  default clocking @(posedge clk); 
  endclocking

  initial begin : test
    run_test();
  end : test
  
endmodule : top
