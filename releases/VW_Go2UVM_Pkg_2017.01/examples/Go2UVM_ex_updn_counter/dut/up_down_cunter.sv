// Copyright (c) 2004-2017 VerifWorks, Bangalore, India
// http://www.verifworks.com 
// Contact: support@verifworks.com 
// 
// This program is part of Go2UVM at www.go2uvm.org
// Some portions of Go2UVM are free software.
// You can redistribute it and/or modify  
// it under the terms of the GNU Lesser General Public License as   
// published by the Free Software Foundation, version 3.
//
// VerifWorks reserves the right to obfuscate part or full of the code
// at any point in time. 
// We also support a comemrical licensing option for an enhanced version
// of Go2UVM, please contact us via support@verifworks.com
//
// This program is distributed in the hope that it will be useful, but 
// WITHOUT ANY WARRANTY; without even the implied warranty of 
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU 
// Lesser General Lesser Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public License
// along with this program. If not, see <http://www.gnu.org/licenses/>.

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
       
               
            
