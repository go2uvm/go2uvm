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


task apb2_master_driver::reset_phase(uvm_phase phase);
  `g2u_display("Start of Reset Phase ....",UVM_HIGH)
  phase.raise_objection(this);
  `g2u_display("Testbench started",UVM_HIGH)
  this.vif.apb_driver_cb.presetn <= 1'b0;
  this.vif.apb_driver_cb.penable <= 1'b0;
  this.vif.apb_driver_cb.pselx   <=  'b0;
  this.vif.apb_driver_cb.pwdata   <=  'b0;
  this.vif.apb_driver_cb.paddr   <=  'b0;
  this.vif.apb_driver_cb.pwrite   <=  'b0;
  repeat(10) @(this.vif.apb_driver_cb);  
  this.vif.apb_driver_cb.presetn <= 1'b1;
  phase.drop_objection(this);
  `g2u_display("End of Reset Phase ....",UVM_HIGH)
endtask : reset_phase

task apb2_master_driver::main_phase(uvm_phase phase);
  `g2u_display("Start of Main Phase ....",UVM_HIGH)
  forever
    begin : b1
      this.seq_item_port.get_next_item(this.item);
this.send_to_dut(this.item);
      this.seq_item_port.item_done();
    end : b1
endtask : main_phase

task apb2_master_driver::apb_write(input [ADDR_WIDTH-1:0] addr, input [DATA_WIDTH-1:0] data);
  @(this.vif.apb_driver_cb);  
  this.vif.apb_driver_cb.pwdata <= data;
  this.vif.apb_driver_cb.pselx  <= 1'b1;  
  this.vif.apb_driver_cb.penable<= 1'b0;
  this.vif.apb_driver_cb.pwrite <= 1'b1;
  this.vif.apb_driver_cb.paddr  <= addr;
  this.vif.apb_driver_cb.pwdata <= data;
  @(this.vif.apb_driver_cb);
  this.vif.apb_driver_cb.penable<= 1'b1;
  @(this.vif.apb_driver_cb);
  this.vif.apb_driver_cb.penable<= 1'b0;
  this.vif.apb_driver_cb.pselx  <= 1'b0;  
endtask :apb_write   

task apb2_master_driver::apb_read(input [ADDR_WIDTH-1:0] addr);
   @(this.vif.apb_driver_cb);
  this.vif.apb_driver_cb.pselx  <= 1'b1;
  this.vif.apb_driver_cb.penable<= 1'b0;
  this.vif.apb_driver_cb.pwrite <= 1'b0;
  this.vif.apb_driver_cb.paddr  <= addr;
  @(this.vif.apb_driver_cb);
  this.vif.apb_driver_cb.penable<=1'b1;
  @(this.vif.apb_driver_cb);
  this.vif.apb_driver_cb.penable <= 1'b0;
  this.vif.apb_driver_cb.pselx <= 1'b0; 
  repeat(2) @(this.vif.apb_driver_cb);
endtask :apb_read

task apb2_master_driver::send_to_dut(input apb2_master_xactn  item);
  `g2u_printf(("Driving item: %s", this.item.sprint()))
  case(item.kind)
    RD:this.apb_read(.addr(item.addr));
    WR:this.apb_write(.addr(item.addr),.data(item.data));
  endcase
endtask : send_to_dut
