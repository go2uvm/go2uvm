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
// along with program. If not, see <http://www.gnu.org/licenses/>.

// Generating Go2UVM Test for module: fifo
// ---------------------------------------------------------

// Automatically generated from VerifWorks's DVCreate-Go2UVM product
// Thanks for using VerifWorks products, see http://www.verifworks.com for more

import uvm_pkg::*;
`include "vw_go2uvm_macros.svh"
// Import Go2UVM Package
import vw_go2uvm_pkg::*;

// Use the base class provided by the vw_go2uvm_pkg
`G2U_TEST_BEGIN(fifo_test)

  // Create a handle to the actual interface
 `G2U_GET_VIF(fifo_if)

  task reset();
    `g2u_display ("Start of reset")
     vif.cb.rst_n <= 1'b0;
     repeat (5) @ (vif.cb);
     vif.cb.rst_n <= 1'b1;
     repeat (1) @ (vif.cb);
    `g2u_display ("End of reset")
  endtask : reset

  task main ();
    `g2u_display ("Start of main")
    `g2u_display ("Fill in your main logic here ")
     vif.cb.push<= 1'b1;
     vif.cb.data_in <= 22;
     repeat (1) @ (vif.cb);
     vif.cb.push<= 1'b0;
     repeat (5) @ (vif.cb);
    `g2u_display ("End of main")
  endtask : main

`G2U_TEST_END
