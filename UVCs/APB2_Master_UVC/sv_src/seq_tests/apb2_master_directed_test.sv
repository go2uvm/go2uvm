/* 
* Copyright (c) 2004-2023 CVC, VerifWorks, London-UK & Bangalore, India
* http://www.verifworks.com 
* Contact: support@verifworks.com 
* 
* This program is part of Go2UVM at https://github.com/go2uvm/go2uvm
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


task apb2_master_rand_seq::body();
  `uvm_info(get_name(),$sformatf(":Sequence is Running ...."),UVM_MEDIUM)
  `uvm_do_with(req, {this.kind == WR;this.addr == 8'h3;this.data == 8'd1;} )
  `uvm_do_with(req, {this.kind == WR;this.addr == 8'h9;this.data == 8'd3;} )
  `uvm_do_with(req, {this.kind == WR;this.addr == 8'h6;this.data == 8'd2;} )  
  `uvm_do_with(req, {this.kind == WR;this.addr == 8'h20;this.data == 8'd104;} )  
  `uvm_do_with(req, {this.kind == WR;this.addr == 8'h1D;this.data == 8'd200;} )  
  `uvm_do_with(req, {this.kind == WR;this.addr == 8'h1E;this.data == 8'd40;} )  
  `uvm_do_with(req, {this.kind == WR;this.addr == 8'h1F;this.data == 8'd50;} )  
  `uvm_do_with(req, {this.kind == WR;this.addr == 8'h11;this.data == 8'd100;} )  
  #100;  
  `uvm_do_with(req, {this.kind == RD;this.addr == 8'h3;} )
  `uvm_do_with(req, {this.kind == RD;this.addr == 8'h6;} )
  `uvm_do_with(req, {this.kind == RD;this.addr == 8'h9;} )
  `uvm_do_with(req, {this.kind == RD;this.addr == 8'h20;} )
  `uvm_do_with(req, {this.kind == RD;this.addr == 8'h1D;} )
  `uvm_do_with(req, {this.kind == RD;this.addr == 8'h1E;} )
  `uvm_do_with(req, {this.kind == RD;this.addr == 8'h1F;} )
  `uvm_do_with(req, {this.kind == RD;this.addr == 8'h11;} )
  #100;  
`uvm_info(get_name(),$sformatf(":Sequence is Complete ...."),UVM_MEDIUM)
endtask : body
