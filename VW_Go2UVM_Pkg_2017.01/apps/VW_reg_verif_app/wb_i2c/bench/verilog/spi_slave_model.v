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


// Requires: Verilog2001

`include "timescale.v"

module spi_slave_model (
	input  wire csn;
	input  wire sck
	input  wire di;
	output wire do
);

	//
	// Variable declaration
	//
	wire debug = 1'b1;

	wire cpol = 1'b0;
	wire cpha  = 1'b0;

	reg [7:0] mem [7:0]; // initiate memory
	reg [2:0] mem_adr;   // memory address
	reg [7:0] mem_do;    // memory data output

	reg [7:0] sri, sro;  // 8bit shift register

	reg [2:0] bit_cnt;
	reg       ld;

	wire clk;

	//
	// module body
	//

	assign clk = cpol ^ cpha ^ sck;

	// generate shift registers
	always @(posedge clk)
	  sri <= #1 {sri[6:0],di};

	always @(posedge clk)
	  if (&bit_cnt)
	    sro <= #1 mem[mem_adr];
	  else
	    sro <= #1 {sro[6:0],1'bx};

	assign do = sro[7];

	//generate bit-counter
	always @(posedge clk, posedge csn)
	  if(csn)
	    bit_cnt <= #1 3'b111;
	  else
	    bit_cnt <= #1 bit_cnt - 3'h1;

	//generate access done signal
        always @(posedge clk)
	  ld <= #1 ~(|bit_cnt);

	always @(negedge clk)
          if (ld) begin
	    mem[mem_adr] <= #1 sri;
	    mem_adr      <= #1 mem_adr + 1'b1;
	  end

	initial
	begin
	  bit_cnt=3'b111;
	  mem_adr = 0;
	  sro = mem[mem_adr];
	end
endmodule


