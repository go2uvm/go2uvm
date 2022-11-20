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

`define WIDTH 8

interface count_if (input clk);
  logic rst_n, cen, load, up_dn;
  logic [`WIDTH-1:0]data, count; 

  clocking cb @ (posedge clk);
    output rst_n;
    output cen;
    output load;
    output up_dn;
    input  count;
    output data;
  endclocking : cb


endinterface : count_if


`G2U_TEST_BEGIN(go2uvm_count_test)

  `G2U_GET_VIF(count_if)

  task reset ();
    `g2u_display("Start of reset")
    vif.cb.rst_n <= 1'b0;
    repeat(10) @ (vif.cb);
    vif.cb.rst_n <= 1'b1;
    @ (vif.cb);
    `g2u_display("End of reset")
  endtask : reset

  task main();
     int i;
    `g2u_display("Start of Test")
     @ (vif.cb);
    vif.cb.rst_n <= 1'b1;
    vif.cb.load <= 1'b1;

    repeat(2) @ (vif.cb);
     vif.cb.rst_n <= 1'b1;
     vif.cb.load <= 1'b0;
     vif.cb.data <= 8'h78;

    repeat(2) @ (vif.cb);
     vif.cb.load <= 1'b1;
     vif.cb.cen <= 1'b1;
     vif.cb.up_dn <= 1'b1;

    repeat(3) @ (vif.cb);
     vif.cb.load <= 1'b1;
     vif.cb.cen <= 1'b1;
     vif.cb.up_dn <= 1'b0;
    
    repeat(10) @ (vif.cb);
     vif.cb.load <= 1'b1;
     vif.cb.cen <= 1'b1;
     vif.cb.up_dn <= 1'b1;
   
    repeat(10) @ (vif.cb);
     vif.cb.load <= 1'b1;
     vif.cb.cen <= 1'b0;

    repeat(2) @ (vif.cb);
     vif.cb.rst_n <= 1'b1;
     vif.cb.load <= 1'b1;

    #100;
    `g2u_display("End of Test")
 endtask : main
`G2U_TEST_END


//Module
module go2uvm_count;
  logic clk;

    go2uvm_count_test go2uvm_count_test_0;

    //Instantiation of Interface
    count_if count_if_0 (.clk(clk));


    // DUT Instantiation
     up_down_counter DUT ( .clk   (count_if_0.clk),
               .rst_n (count_if_0.rst_n), 
               .cen   (count_if_0.cen), 
               .load  (count_if_0.load), 
               .up_dn (count_if_0.up_dn),
               .data  (count_if_0.data),
               .count (count_if_0.count)
              );

  initial 
    begin
      clk = 1'b0;
      forever #5 clk = !clk;
    end

  initial
    begin 
      go2uvm_count_test_0 = new ();
      `G2U_SET_VIF(count_if,count_if_0)
      run_test ();
    end 

endmodule : go2uvm_count


