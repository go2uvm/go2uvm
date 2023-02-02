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


class apb2_master_agent extends uvm_agent;

  apb2_master_sequencer apb2_master_sequencer_0;
  apb2_master_driver apb2_master_driver_0;
  apb2_master_input_monitor apb2_master_input_monitor_0;
//  apb2_master_output_monitor apb2_master_output_monitor_0;
  apb2_master_scoreboard apb2_master_scoreboard_0;
//  apb2_master_fcov apb2_master_fcov_0;

  virtual  apb2_master_if apb2_master_if_0;

  `uvm_component_utils_begin (apb2_master_agent)
    `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_DEFAULT)
  `uvm_component_utils_end

  function new(string name, uvm_component parent);
    super.new(.name(name), .parent(parent));
  endfunction : new

  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);

endclass : apb2_master_agent

