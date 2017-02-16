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

import vw_go2uvm_pkg::*;
import vl_ahb_pkg::*;

interface g2u_reg_if (input logic clk);



 		logic       HRESETn;
		logic  [AHB_DATA_WIDTH-1:0]  HWDATA;
		logic       HWRITE;
		logic       HWRVALID;
		logic [AHB_ADDR_WIDTH-1:0] H_ADDR;
		logic             HREADY;
		logic [AHB_DATA_WIDTH-1:0] HRDATA; 


  // Clocking block declaration
  
  default clocking g2u_reg_cb @(posedge clk);
        	inout      	 HRESETn;
		inout   	 HWDATA;
		inout       	HWRITE;
		inout       	HWRVALID;
		inout 		H_ADDR;
		input           HREADY;
		input   	HRDATA;

  endclocking : g2u_reg_cb
  

  task g2u_reset();
    `g2u_display ("Starting reset task in g2u_reset")
    HRESETn <= 1'b0;
    ##4;
     HRESETn <= 1'b1;
    ##2;
    `g2u_display ("End of reset task in g2u_reset")
  endtask : g2u_reset
         
  task g2u_write (uvm_reg_addr_t wr_addr, uvm_reg_data_t wr_data);
    `g2u_display ( "Starting a new write")


       	HWRVALID <= 1'b1;
        HWRITE <= 1'b1;
        H_ADDR <= wr_addr;
	HWDATA <= wr_data;
        @(posedge clk);
        HWRITE <= 1'b0;
	 @(posedge clk);

  
    `g2u_display ( 
      $sformatf ("End of Write addr: 'h%0x data: 'h%0x",
        wr_addr, wr_data))
  endtask : g2u_write 

  task g2u_read (uvm_reg_addr_t rd_addr, output uvm_reg_data_t rd_data);
    `g2u_display ( "Starting a new read")
     
	HWRVALID <= 1'b1;
    	HWRITE <= 1'b0;
    	H_ADDR <= rd_addr;
    	@(posedge clk);
    	//wr_rd <= 1'b0;
    	//wr_rd_valid <= 1'b0;
    	@(posedge clk);
    	rd_data <= HRDATA;
    	HWRITE <= 1'b0;
   
    `g2u_display ( 
      $sformatf ("End of Read addr: 'h%0x data: 'h%0x",
        rd_addr, rd_data))
  endtask : g2u_read 


endinterface : g2u_reg_if
