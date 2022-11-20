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
// Code your design interface as per spec
// Add assertions inside the interface
// Use `uvm_error for action blocks

interface sva_if (input clk);
  logic rst_n;
  logic start = 1'b0, a, b;

  default clocking cb @ (posedge clk);
    output start, a, b;
  endclocking : cb

  a1 : assert property (start |=> a ##1 b) else
    `uvm_error ("SVA-UVM", "Protocol violation, no a ##1 b");

endinterface : sva_if

