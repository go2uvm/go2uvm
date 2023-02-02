//AMBA APB-2.0 SLAVE


`define ADDR_WIDTH 8 
`define DATA_WIDTH 8
`define STATE_WIDTH 2 

module slave_apb 
  ( input                    PCLK,      //CLK
    input                    PRESETn,   //Active low reset 
    input                    PSELx,     //To Select Slave  
    input                    PENABLE,   //To Enablling the write & read 
    input                    PWRITE,    //Write signal
    input [`ADDR_WIDTH-1:0 ] PADDR,     //Addr signal
    input [`DATA_WIDTH-1:0 ] PWDATA,    //Write Data

    output reg [`DATA_WIDTH-1:0 ]PRDATA     //Read Data
  );
 
  //Parameter Declarations
  parameter IDLE = 2'd0,SETUP = 2'd1,ENABLE = 2'd2;     //States in FSM

  //Internal Signals
  reg [`STATE_WIDTH -1 :0] PSTATE,NSTATE;                  //Present State,Next State
  reg [`DATA_WIDTH -1 :0 ]SLAVE_MEM[0:2**`ADDR_WIDTH -1];  //Slave Memory 

  //Based on Fsm_Apb 
  //Present State Logic
  always @ (posedge PCLK or negedge PRESETn)
  begin
    if (!PRESETn)
    PSTATE <= IDLE;
    else
    PSTATE <= NSTATE;
  end

  //Next State Logic & output Logic
  always @ (PCLK or PSELx or PENABLE or PSTATE )
  begin
    case (PSTATE)
     IDLE : begin
	     if (PSELx == 1'b1 )
             NSTATE = SETUP;
             else
      	     NSTATE = IDLE;
	    end
     SETUP: begin
             NSTATE = ENABLE;
            end
     ENABLE:begin
	     if (PSELx == 1'b1) 
	        NSTATE = SETUP;
	     else 
	        NSTATE = IDLE;
             end 
    default:begin
	     NSTATE = IDLE;
	    end
      endcase	       
  end
 
  //OUtput Logic
  always @ ( posedge PCLK or negedge PRESETn)
  begin
    if (!PRESETn)
       PRDATA <= 0;
    else
    begin	    
    case (PSTATE)
    IDLE  :PRDATA <= 0;
    SETUP :PRDATA <= 0; 
    ENABLE:begin
	   if (PWRITE == 1'b1)
             SLAVE_MEM[PADDR] <= PWDATA;
           else 
             PRDATA <= SLAVE_MEM[PADDR];
           end
    default:begin
	     PRDATA <= 0; 
            end
    endcase
    end
  end
endmodule



  
    

       




