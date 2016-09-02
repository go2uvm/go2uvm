 import uvm_pkg::*;
  `include "uvm_macros.svh"

import vw_go2uvm_pkg::*;
`include "vw_go2uvm_defines.svh"

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


class go2uvm_count_test extends go2uvm_base_test;
  virtual count_if vif;

  task reset ();
    `uvm_info(log_id, "Start of reset", UVM_MEDIUM)
    vif.cb.rst_n <= 1'b0;
    repeat(10) @ (vif.cb);
    vif.cb.rst_n <= 1'b1;
    @ (vif.cb);
    `uvm_info(log_id, "End of reset", UVM_MEDIUM)
  endtask : reset

  task main();
     int i;
    `uvm_info(log_id, "Start of Test", UVM_MEDIUM)
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
    `uvm_info(log_id, "End of Test", UVM_MEDIUM)
 endtask : main

endclass : go2uvm_count_test

//Module
module go2uvm_count;
  logic clk;


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

    `vw_go2uvm_test(go2uvm_count_test, count_if_0)

endmodule : go2uvm_count


