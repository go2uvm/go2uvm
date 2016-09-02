
`define WIDTH 8

module up_down_counter ( input clk, rst_n, cen, load, up_dn,
             input [`WIDTH-1:0]data,
             output reg [`WIDTH-1:0]count );

  always @ ( posedge clk )

    begin

      if( !rst_n )

        count <= {`WIDTH{1'b0}};

      else 

        begin

          case( load )

            1'b0 : count <= data;

            1'b1 : if (cen)

                     begin

                       case( up_dn )

                         1'b1 : if ( count < {`WIDTH{1'b1}} )                       
                                  count <= count + 1;
                                else 
                                  count <= {`WIDTH{1'b1}}; 

                         1'b0 : if ( count > {`WIDTH{1'b0}} )                       
                                  count <= count - 1;
                                else
                                  count <= {`WIDTH{1'b0}}; 

                       endcase 

                     end 

                   else

                     count <= count + 1'b0;

          endcase 

        end
     
    end
                        
endmodule : up_down_counter
       
               
            
