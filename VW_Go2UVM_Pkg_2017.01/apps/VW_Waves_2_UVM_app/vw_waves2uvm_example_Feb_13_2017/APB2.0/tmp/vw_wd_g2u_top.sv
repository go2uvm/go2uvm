// Generating Go2UVM top module for DUT: vw_wd_g2u_top
// ---------------------------------------------------------
module vw_wd_g2u_top;
  timeunit 1ns;
  timeprecision 1ns;
  parameter VW_CLK_PERIOD = 10;
  // Simple clock generator
  bit clk ;
  always # (VW_CLK_PERIOD/2) clk <= ~clk;
  // Interface instance
  vw_wd_g2u_if vw_wd_g2u_if_0 (.*);
  assign vw_wd_g2u_if_0.clk = clk; 

  // Using VW_Go2UVM
  vw_wd_g2u_test vw_wd_g2u_test_0;
  initial begin : go2uvm_test
    vw_wd_g2u_test_0 = new (); 

    // Connect virtual interface to physical interface
    uvm_config_db#(virtual vw_wd_g2u_if)::set( 
     .cntxt(null), .inst_name("*"), 
     .field_name("vif"), .value(vw_wd_g2u_if_0)); 

    // Kick start standard UVM phasing
    run_test ();
  end : go2uvm_test
endmodule : vw_wd_g2u_top 
