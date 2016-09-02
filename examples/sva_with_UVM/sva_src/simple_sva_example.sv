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

