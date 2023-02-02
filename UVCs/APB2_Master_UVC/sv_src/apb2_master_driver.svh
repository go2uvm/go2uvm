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


class apb2_master_driver extends uvm_driver #(apb2_master_xactn);
 
  virtual apb2_master_if vif;
  apb2_master_xactn item;

  function new(string name, uvm_component parent);
    super.new(.name(name), .parent(parent));
  endfunction : new

  `uvm_component_utils_begin(apb2_master_driver)
    `uvm_field_object(item,UVM_ALL_ON)
  `uvm_component_utils_end

  extern virtual task reset_phase(uvm_phase phase);
  extern virtual task main_phase(uvm_phase phase);
  extern virtual task send_to_dut(input apb2_master_xactn  item);
  extern virtual task apb_write(input [ADDR_WIDTH-1:0] addr, 
				input [DATA_WIDTH-1:0] data);
  extern virtual task apb_read(input [ADDR_WIDTH-1:0] addr); 

endclass : apb2_master_driver

