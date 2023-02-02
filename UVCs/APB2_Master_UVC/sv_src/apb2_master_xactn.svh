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


class apb2_master_xactn extends uvm_sequence_item; 

  rand logic [ADDR_WIDTH-1:0]addr;
  rand logic [DATA_WIDTH-1:0]data;
  logic [DATA_WIDTH-1:0]act_data_for_sbrd;
  logic [DATA_WIDTH-1:0]exp_data_for_sbrd;

  rand apb_kind_e kind;

  `uvm_object_utils_begin(apb2_master_xactn)
    `uvm_field_int(addr,UVM_ALL_ON)
    `uvm_field_int(data,UVM_ALL_ON)
    `uvm_field_enum(apb_kind_e,kind,UVM_ALL_ON)
  `uvm_object_utils_end
 
  function new(string name="apb2_master_xactn");
    super.new(name);
  endfunction : new

endclass : apb2_master_xactn
