import uvm_pkg::*;
import vw_go2uvm_pkg::*;
`include "uvm_macros.svh"
`include "vw_go2uvm_macros.svh"
interface vw_wd_g2u_if();
  logic PCLK; 
  logic PWRITE; 
  logic PSEL; 
  logic PENABLE; 
  logic PREADY; 
  default clocking cb @ (posedge PCLK);
    output PWRITE; 
    output PSEL; 
    output PENABLE; 
    output PREADY; 
  endclocking : cb 
endinterface : vw_wd_g2u_if
