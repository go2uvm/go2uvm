`timescale 1ns/1fs
module vw_g2u_clk_gen #(
  parameter FREQUENCY_MHZ = 100, 
  parameter INIT_VAL = 0)
 (output logic clk);

  timeunit 1ns;
  timeprecision 1fs;

  real clk_period; 
  real clk_half_period; 
  real freq_mhz_val_in_real;
 
  initial begin : gen_clk_blk
    freq_mhz_val_in_real = FREQUENCY_MHZ;
    clk_period =  1000/(freq_mhz_val_in_real); // Convert MHz to ns
    clk_half_period =  clk_period/2.0;
    
    if (INIT_VAL == 0)
     begin
       clk = 1'b0;
       #clk_half_period;
     end
    
    forever begin : clk_fe
       clk = 1'b1;
       #clk_half_period;
       clk = 1'b0;
       #clk_half_period;
    end : clk_fe
  end : gen_clk_blk

endmodule : vw_g2u_clk_gen


module vw_g2u_clk_div #(parameter NUM_DIV = 1)
(
  // Input Clock 
  input i_clk,
  // Output clock as a bit-vector
  // 1 bit more than the NUM_DIV - as the 0th clk out
  // shall be same FREQ as in_clk, but with phase differenece
  // all other clocks/bits shall eb sligned in phase to 0th clk

  output logic [NUM_DIV:0] o_clk_vec
);

  initial begin : divide
    o_clk_vec[NUM_DIV:0] = {{NUM_DIV{1'b0}},1'b0};
    forever begin : fe_1
      @(i_clk) ; 
      o_clk_vec[NUM_DIV:0] = {o_clk_vec[NUM_DIV:1], i_clk} - 'd1;
    end : fe_1
  end : divide

endmodule : vw_g2u_clk_div

