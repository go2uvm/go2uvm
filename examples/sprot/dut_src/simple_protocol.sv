package sprot_pkg;
  typedef enum bit [1:0] {IDLE, A_ST, B_ST} sprot_fsm_t;
endpackage : sprot_pkg

module sprot (input clk, rst_n,
  input start, a, b,
  output logic prot_err, xfer_end);

  import sprot_pkg::*;

  default clocking cb @ (posedge clk);
    input start, a, b;
  endclocking : cb

  a1 : assert property (start |=> a ##1 b);

  sprot_fsm_t cur_st, next_st;

  always_ff @(posedge clk) begin : prot
    if (!rst_n) begin : rst_cyc
      prot_err <= 1'b0;
      xfer_end <= 1'b0;
      next_st <= IDLE;
    end : rst_cyc
    else begin : normal_cyc
    case (cur_st)
      IDLE : begin
        prot_err <= 1'b0;
        xfer_end <= 1'b0;
        if (start) begin : new_xfer
          next_st <= A_ST;
        end : new_xfer
      end // IDLE
      A_ST : begin
        if (a) begin 
          next_st <= B_ST;
        end 
	else begin
          next_st <= IDLE;
          prot_err <= 1'b1;
          xfer_end <= 1'b1;
	end
      end // A_ST

      B_ST : begin
        if (b) begin 
          next_st <= IDLE;
          prot_err <= 1'b0;
          xfer_end <= 1'b1;
        end 
	else begin
          next_st <= IDLE;
          prot_err <= 1'b1;
          xfer_end <= 1'b1;
	end
      end // B_ST
    endcase // (cur_st)
    end : normal_cyc
  end : prot

  always_ff @(posedge clk) begin : fsm
    if (!rst_n) begin
      cur_st <= IDLE;
    end
    else begin
      cur_st <= next_st;
    end
  end : fsm

endmodule : sprot

