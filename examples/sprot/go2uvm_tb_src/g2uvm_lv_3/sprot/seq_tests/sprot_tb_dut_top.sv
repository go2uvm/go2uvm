module sprot_tb_dut_top();

`include "sprot_inc.svh"
`include "sprot_rand_test.sv"

//  parameter CLOCK_PERIOD = 10; // Assign clock Period 

  logic clk;

  sprot_if sprot_if_0(.clk (clk) ); //instantiate uvc interface

 initial
  begin : cgen
    clk = 0;
    forever #10 clk <= ~clk; 
  end : cgen

  //instantiate and connect dut to interface(s) here
  
  initial
    begin
      uvm_config_db#(virtual sprot_if)::set(.cntxt(null),
                                          .inst_name("uvm_test_top.sprot_env.sprot_agent"),
                                          .field_name("sprot_if_0"),
                                          .value(sprot_if_0));
    
      run_test();
    end
endmodule
