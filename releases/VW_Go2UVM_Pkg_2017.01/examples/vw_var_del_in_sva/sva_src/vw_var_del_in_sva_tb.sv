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

module top;
  timeunit 1ns;   timeprecision 1ns;
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
    ##10 rst_n <= 1'b1;
    ##1;
    ##1;  start_sig<=1; end_sig <=0;
    ##1;  start_sig<=0; 
    ##10 end_sig <=1;
    ##1; $finish;   
  end : test
endmodule : top

