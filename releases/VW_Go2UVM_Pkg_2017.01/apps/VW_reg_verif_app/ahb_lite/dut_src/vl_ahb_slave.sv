//* Copyright (c) 2004-2017 VerifWorks, Bangalore, India
//* http://www.verifworks.com 
//* Contact: support@verifworks.com 
//* 
//* This program is part of Go2UVM at www.go2uvm.org
//* Some portions of Go2UVM are free software.
//* You can redistribute it and/or modify  
//* it under the terms of the GNU Lesser General Public License as   
//* published by the Free Software Foundation, version 3.
//*
//* VerifWorks reserves the right to obfuscate part or full of the code
//* at any point in time. 
//* We also support a comemrical licensing option for an enhanced version
//* of Go2UVM, please contact us via support@verifworks.com
//
//* This program is distributed in the hope that it will be useful, but 
//* WITHOUT ANY WARRANTY; without even the implied warranty of 
//* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU 
//* Lesser General Lesser Public License for more details.
//*
//* You should have received a copy of the GNU Lesser General Public License
//* along with this program. If not, see <http://www.gnu.org/licenses/>.



// Move these to a package and make them parameters

`define IDLE        3'b000
`define ACTIVE      3'b001
`define AGAIN       3'b010
`define LITTLE      3'b011 
`define WRITE_BURST 3'b100
`define READ_BURST  3'b101


`define NON_SEQ     2'd0
`define SEQ    2'd1
`define BUSY    2'd2
`define IDLE_TRANS  2'd3

`define OKAY  2'b00
`define ERROR 2'b01
`define RETRY 2'b10
`define SPLIT 2'b11

import vl_ahb_pkg::*;


// TBD
// Add an AHB interface, as generated via dvc_svi

module AHB_Slave( HREADY,
		  HRESP,
		  HRDATA,
		  HSPLITx,
		  HSELx,
		  H_ADDR,
		  HWRITE,
		  H_TRANS,
		  HSIZE,
		  HBURST,
		  HWDATA,
		  HRESETn,
		  HCLK,
		  HMASTER,
		  HMASTLOCK
		  );
   
   output  HREADY;
   // TBD remove hard coed numbers, make them parameters
   output [1:0] HRESP;
   output [AHB_DATA_WIDTH-1:0] HRDATA;
   output [AHB_DATA_WIDTH-1:0] HSPLITx;
   
   
   input 	 HSELx,HWRITE,HRESETn,HCLK;
   input 		 HMASTLOCK;
   input logic [AHB_ADDR_WIDTH-1:0] 	 H_ADDR;
   input [AHB_DATA_WIDTH-1:0]  HWDATA;
   input [2:0] 	 HSIZE;
   input [2:0] 	 HBURST;
   input [3:0] 	 HMASTER;
   input logic [1:0] 	 H_TRANS;
   reg [AHB_DATA_WIDTH-1:0] 	 HRDATA;
   
   logic [AHB_ADDR_WIDTH-1:0]  HADDR;
   logic [1:0] 	 HTRANS;

   reg 		 HREADY;
   reg [1:0] 	 HRESP;
   reg [15:0] 	 HSPLITx;
   reg [AHB_ADDR_WIDTH-1:0] 	 local_addr;
   reg [3:0] 	 SPLIT_RESP;
   reg [AHB_DATA_WIDTH-1:0] 	 memory_slave[0:2**AHB_ADDR_WIDTH-1]; 
   reg [2:0] 	 ps_slave1,ns_slave1;
   
   integer 	 count;

   // TBD
   // Use named block in begin/end
   // DO NOT change to always_comb yet
   
   always @ (ps_slave1 or ns_slave1 or HRESETn or 
             HSELx or HWDATA or HWRITE )
      
     begin
	case (ps_slave1)
	  
	  `IDLE  :begin
             if(!HRESETn && HSELx==0)
               ns_slave1=`IDLE;
             else
               begin 
		  // HSELx=1'd1;
		  HREADY=1'b1;
		  //HMASTLOCK=1'b0;
		  //  HWRITE=1'b1;
		  //HBURST=3'b001;
		  // HADDR=$random %32;
		  local_addr=16'd0;
		  ns_slave1=`ACTIVE;
	       end
          end 
	  
	  `ACTIVE : begin
	     if(HRESETn && HSELx && HWRITE )
	       begin
		  HREADY=1'b0;
		  ns_slave1=`WRITE_BURST;
	       end
	     else if(HRESETn && HSELx && !HWRITE )
	       begin
		  HREADY= 1'b0;
		  ns_slave1=`READ_BURST;
	       end
	     else if(!HREADY) 
	       begin
		  ns_slave1=`AGAIN;
		  HRESP= `RETRY;
	       end
	     else begin
	       ns_slave1=`IDLE;
                end
	  end 
	  
	  `AGAIN :  begin
             if(HREADY)
               ns_slave1=`ACTIVE;
             else
               ns_slave1=`LITTLE;
          end
          
	  `WRITE_BURST  : begin : wr_burst
             if (HRESETn && HSELx && HWRITE ) begin : valid_wr
		
               case(HBURST)
		 // TBD - use enums for these various BURST types
		 3'b000 : begin
		    memory_slave[HADDR]= HWDATA;
		    HREADY=1'b1; HRESP= `OKAY;
		    HTRANS=`NON_SEQ;
		    ns_slave1=`IDLE;

		 end//000--Single transfer
		 
		 3'b001 : begin  // incrememting Burst unspecified Length
		    memory_slave[HADDR]=HWDATA;
		    
		    HADDR=HADDR+1;
		    count=count+1;
		    if(count<32)
		      ns_slave1=`WRITE_BURST;
		    else
		      HREADY=1'b1;HRESP= `OKAY;
                    ns_slave1=`IDLE;
		    
		 end//001
		 
		 3'b010 : begin   // 4BEAT WRAPPING burst
		    memory_slave[HADDR]=HWDATA; 
		    HADDR=HADDR+4;
		    count=count+1;
		    if(count==4) 
		      begin
                         HREADY=1'b1; HRESP= `OKAY;
			 HADDR=local_addr;
			 count=0;
			 ns_slave1=`IDLE;
		      end//count<4
		    else
                      ns_slave1=`WRITE_BURST;
		 end//010
		 
		 3'b011 : begin///4 beat Incrementing Burst
		    memory_slave[HADDR]=HWDATA;
		    HADDR=HADDR+4;
		    count=count+1;
		    if(count<4)
		      ns_slave1=`WRITE_BURST;
		    else
                      HREADY=1'b1;
		    HRESP= `OKAY;
		    ns_slave1=`IDLE;
		 end//011
		 
		 3'b100 : begin// 8 Beat Wrapping Burst
		    memory_slave[HADDR]=HWDATA;
		    HADDR=HADDR+4;
		    count=count+1;
		    if(count==8) 
		      begin
                         HREADY=1'b1; HRESP= `OKAY;
			 HADDR=local_addr;
			 count=0;
			 ns_slave1=`IDLE;
		      end//count<4
		    else
                      ns_slave1=`WRITE_BURST;
		 end//100
		 
		 
		 3'b101 : begin  ///8 beat Incrementing Burst
		    memory_slave[HADDR]=HWDATA;
		    HADDR=HADDR+4;
		    count=count+1;
		    if(count<8)
		      ns_slave1=`WRITE_BURST;
		    else
		      HREADY=1'b1;HRESP= `OKAY;
		    ns_slave1=`IDLE;
		    
		 end//101
		 
		 3'b110 : begin // 16 beat wrapping Burst
		    memory_slave[HADDR]=HWDATA;
		    HADDR=HADDR+4;
		    count=count+1;
		    if(count==16) 
		      begin
                         HREADY=1'b1;HRESP= `OKAY;
			 HADDR=local_addr;count=0;
			 ns_slave1=`IDLE;
		      end//count<4
		    else
                      ns_slave1=`WRITE_BURST;
		    
		 end//110
		 
		 3'b111 : begin
		    memory_slave[HADDR]=HWDATA;
		    HADDR=HADDR+4;
		    count=count+1;
		    if(count<16)
		      ns_slave1=`WRITE_BURST;
		    else
		      HREADY=1'b1;HRESP= `OKAY;
		    ns_slave1=`IDLE;
		 end//111
		 
		 default : begin
                    HREADY=1'b1;HRESP= `OKAY;
                    ns_slave1=`IDLE;
                 end
	       endcase//for WRITE operation
	     end : valid_wr
	     else begin : no_wr_sel
		HRESP= `ERROR;
	     end : no_wr_sel
	     
	  end : wr_burst
	  
	  
	  `READ_BURST : 
	    //READ Operation Starts Here
	    begin : rd_burst
               if(HRESETn && HSELx && !HWRITE) begin : valid_rd
		 case(HBURST)
		   
		   3'b000 : begin
		      HRDATA=memory_slave[HADDR];
                      HREADY=1'b1;  
		      ns_slave1=`IDLE;HRESP= `OKAY;
		   end//000--Single transfer
		   
		   3'b001 : begin  // incrememting Burst unspecified Length
		      HRDATA=memory_slave[HADDR];
		      HADDR=HADDR+1;
		      count=count+1;
		      if(count<32)
			ns_slave1=`READ_BURST;
		      else
			HREADY=1'b1;HRESP= `OKAY;
		      ns_slave1=`IDLE;
		      
		   end//001
		   
		   3'b010 : begin   // 4BEAT WRAPPING burst
		      HRDATA=memory_slave[HADDR];
		      HADDR=HADDR+4;
		      count=count+1;
		      if(count==4) 
			begin
			   HREADY=1'b1;
                           HADDR=local_addr;count=0;
			   ns_slave1=`IDLE;
			end//count<4
		      else
                        ns_slave1=`READ_BURST;
		   end//010
		   
		   3'b011 : begin///4 beat Incrementing Burst
		      HRDATA=memory_slave[HADDR];
		      HADDR=HADDR+4;
		      count=count+1;
		      if(count<4)
			ns_slave1=`READ_BURST;
		      else
			HREADY=1'b1;HRESP= `OKAY;
                      ns_slave1=`IDLE;
		   end//011
		   
		   3'b100 : begin// 8 Beat Wrapping Burst
		      HRDATA=memory_slave[HADDR];
		      HADDR=HADDR+4;
		      count=count+1;
		      if(count==8) 
			begin
			   HREADY=1'b1;HRESP= `OKAY;
                           HADDR=local_addr;
			   count=0;
			   ns_slave1=`IDLE;
			end//count<4
		      else
                        ns_slave1=`READ_BURST;
		   end//100
		   
		   
		   3'b101 : begin  ///8 beat Incrementing Burst
		      HRDATA=memory_slave[HADDR];
		      HADDR=HADDR+4;
		      count=count+1;
		      if(count<8)
			ns_slave1=`READ_BURST;
		      else
			HREADY=1'b1;HRESP= `OKAY;
                      ns_slave1=`IDLE;
		      
		   end//101
		   
		   3'b110 : begin // 16 beat wrapping Burst
		      HRDATA=memory_slave[HADDR];
		      HADDR=HADDR+4;
		      count=count+1;
		      if(count==16) 
			begin
			   HREADY=1'b1;HRESP= `OKAY;
                           HADDR=local_addr;
			   count=0;
			   ns_slave1=`IDLE;
			end//count<4
		      else
                        ns_slave1=`READ_BURST;
		      
		   end//110
		   
		   3'b111 : begin
		      HRDATA=memory_slave[HADDR];
		      HADDR=HADDR+4;
		      count=count+1;
		      if(count<16)
			ns_slave1=`READ_BURST;
		      else
			HREADY=1'b1;
                      ns_slave1=`IDLE;
		   end//111
		   
		   default :  begin
                      HREADY=1'b1;HRESP= `OKAY;
                      ns_slave1=`IDLE;
                   end
		   
		 endcase //for Read Operation    
	       end : valid_rd
	       else begin : no_valid_rd
		 HRESP= `ERROR;
	       end : no_valid_rd
	    end : rd_burst
	  
	  `LITTLE : begin
             SPLIT_RESP=HMASTER;
             if(HMASTLOCK)
               ns_slave1=`ACTIVE;
             else
               HSPLITx=SPLIT_RESP;
             ns_slave1=`IDLE;
          end

	endcase
	
     end // always @ (ps_slave1 or ns_slave1 or HRESETn or...

   // TBD
   // Add negedge rst to always block below
   // Use <= NBA
   
   always@(posedge HCLK or negedge HRESETn)
     begin
        if(!HRESETn)
begin
        ps_slave1 <= 0;
end
        else
          begin
            HADDR <= H_ADDR;
            HTRANS <= H_TRANS;
	    ps_slave1<=ns_slave1;
          end
     end          
endmodule

