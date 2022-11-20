/* 
* Copyright (c) 2004-2017 VerifWorks, Bangalore, India
* http://www.verifworks.com 
* Contact: support@verifworks.com 
* 
* This program is part of Go2UVM at www.go2uvm.org
* Some portions of Go2UVM are free software.
* You can redistribute it and/or modify  
* it under the terms of the GNU Lesser General Public License as   
* published by the Free Software Foundation, version 3.
*
* VerifWorks reserves the right to obfuscate part or full of the code
* at any point in time. 
* We also support a comemrical licensing option for an enhanced version
* of Go2UVM, please contact us via support@verifworks.com

* This program is distributed in the hope that it will be useful, but 
* WITHOUT ANY WARRANTY; without even the implied warranty of 
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU 
* Lesser General Lesser Public License for more details.
*
* You should have received a copy of the GNU Lesser General Public License
* along with this program. If not, see <http://www.gnu.org/licenses/>.
*/


import vw_go2uvm_pkg::*;
interface g2u_reg_if (input logic clk);
parameter dwidth = 8;
parameter awidth = 3;

logic                  rst_n;
logic [awidth   -1:0]	adr;
logic  [dwidth   -1:0]	din;
logic [dwidth   -1:0]	dout;
logic                 cyc, stb;
logic       	        	we;
logic [dwidth/8 -1:0] sel;
logic		                ack, err, rty;


    
   default clocking vlb_cb @ (posedge clk);
   endclocking : vlb_cb

  
  task g2u_reset();
    `g2u_display ("Starting reset task in g2u_reset")
    rst_n <= 1'b1;
    ##1;
    rst_n <= 1'b0;
    adr  = 0;
    dout = 0;
		cyc  = 1'b0;
		stb  = 1'b0;
		we   = 1'b0;
		sel  = {dwidth/8{1'b0}};
   ##4;
    rst_n <= 1'b1;
    ##2;
    `g2u_display ("End of reset task in g2u_reset")
  endtask : g2u_reset
         

// read single
  task g2u_read (uvm_reg_addr_t rd_addr, output uvm_reg_data_t rd_data);
    `g2u_display ( "Starting a new read")

		// assert wishbone signals
		adr  = rd_addr;
		dout = {dwidth{1'bx}};
		cyc  = 1'b1;
		stb  = 1'b1;
		we   = 1'b0;
		sel  = {dwidth/8{1'b1}};
		@(posedge clk);

		// wait for acknowledge from slave
		while(~ack)	@(posedge clk);

		// negate wishbone signals
		#1;
		cyc  = 1'b0;
		stb  = 1'bx;
		adr  = {awidth{1'bx}};
		dout = {dwidth{1'bx}};
		we   = 1'hx;
		sel  = {dwidth/8{1'bx}};
		rd_data    = din;

    `g2u_display ( 
      $sformatf ("End of Read addr: 'h%0x data: 'h%0x",
        rd_addr, rd_data))
  endtask : g2u_read 
   
  task g2u_write (uvm_reg_addr_t wr_addr, uvm_reg_data_t wr_data);
    `g2u_display ( "Starting a new write")
		adr  = wr_addr;
		dout = wr_data;
		cyc  = 1'b1;
		stb  = 1'b1;
		we   = 1'b1;
		sel  = {dwidth/8{1'b1}};
		@(posedge clk);

		// wait for acknowledge from slave
		while(~ack)	@(posedge clk);

		// negate wishbone signals
		cyc  = 1'b0;
		stb  = 1'bx;
		adr  = {awidth{1'bx}};
		dout = {dwidth{1'bx}};
		we   = 1'hx;
		sel  = {dwidth/8{1'bx}};

		@(posedge clk);
     `g2u_display ( 
      $sformatf ("End of Write addr: 'h%0x data: 'h%0x",
        wr_addr, wr_data))
  endtask : g2u_write 
endinterface: g2u_reg_if
