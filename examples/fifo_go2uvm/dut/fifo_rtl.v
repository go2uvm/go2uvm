`define DATA_WIDTH 8
`define ADDR_WIDTH 4 


module  fifo  # (parameter DEPTH = 2**`ADDR_WIDTH-1 )
               ( input      clk,rst_n,push,pop,
                 input      [`DATA_WIDTH-1:0] data_in,
                 output reg push_err_on_full,pop_err_on_empty,
                 output     full,empty,
                 output reg [`DATA_WIDTH-1:0] data_out);

// Internal register
reg [`ADDR_WIDTH-1:0] w_ptr,r_ptr;                                    
reg [`DATA_WIDTH-1:0] mem [0:2**`ADDR_WIDTH-1];                        
reg [1:0] wrap_wr,wrap_re; 

assign full = ((wrap_wr != wrap_re ) && (w_ptr==r_ptr))?1'b1:1'b0;                                // Full flag with conditin //


assign empty= ((wrap_wr == wrap_re ) && (w_ptr==r_ptr)) ?1'b1:1'b0;                               // Empty flag with condition // 


// wrap write and write pointer //
always @(posedge clk , negedge rst_n )                                    
  begin
     if(!rst_n)
       wrap_wr <= 0;
     else if (w_ptr ==DEPTH)  
      wrap_wr <= wrap_wr+1'b1;
  end

always@(posedge clk , negedge rst_n)                                                
  begin
    if(!rst_n)
        wrap_re <= 0;
    else if (r_ptr ==DEPTH)  
      wrap_re <= wrap_re+1'b1;
end
/************************************push and pop operation *********************************************/ 
always @ (posedge clk , negedge rst_n)                                
begin
  if (!rst_n)
    begin
      data_out <= {`DATA_WIDTH{1'b0}};
      w_ptr <= 0;
      r_ptr <= 0;
    end
  else
    begin
       if (push)
         begin 
           if(!full)
              begin
                mem [w_ptr] <= data_in;
                w_ptr <= w_ptr +1'b1;
              end
         end
       else if (pop)
         begin
           if(!empty)  
             begin
               data_out <= mem [r_ptr];
               r_ptr <= r_ptr +1'b1;
             end
         end
    end
end

always @ (posedge clk , negedge rst_n)
begin
  if(!rst_n)
      begin
        push_err_on_full <= 0;
        pop_err_on_empty <= 0;
      end
  else
      begin
        push_err_on_full <= push && full;
        pop_err_on_empty <= pop  && empty;
      end
end

endmodule

