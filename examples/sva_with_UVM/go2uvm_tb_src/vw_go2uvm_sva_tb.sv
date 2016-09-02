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

class sva_test extends go2uvm_base_test;

  virtual sva_if vif;

  // VW_UVM_SVA
  // Drive your stimulus as desired
  // The below code should be very familiar to even a Verilog engineer
  // Only additional features shown are the clocking-block and `uvm_info macros

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
  `uvm_info (log_id, "Expect a SVA failure as b is NOT high", UVM_MEDIUM)
  @ (this.vif.cb);
  `uvm_info (log_id, "End of 1 trace", UVM_MEDIUM)

 endtask : main
endclass : sva_test


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
    sva_test_0.vif = sva_if_0;
    run_test (); // "sva_test");
  end : stim

endmodule : sva_uvm
