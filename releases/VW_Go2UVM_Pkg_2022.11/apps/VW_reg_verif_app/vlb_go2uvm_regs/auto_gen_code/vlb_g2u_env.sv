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


// Include special library for G2U_REG
`include "vw_g2u_reg_inc.svh"
class vlb_g2u_env extends uvm_env;

  g2u_reg_agent vlb_g2u_agent_0;
  vlb_reg_block vlb_reg_block_0;

  `uvm_component_utils_begin(vlb_g2u_env)
  `uvm_component_utils_end

  function new(string name, uvm_component parent);
    super.new(.name(name), .parent(parent));
  endfunction : new

  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);


endclass : vlb_g2u_env 

function void vlb_g2u_env::build_phase(uvm_phase phase);
  super.build_phase(.phase(phase));
  vlb_g2u_agent_0 = g2u_reg_agent::type_id::create(.name("vlb_g2u_agent_0"),
				      .parent(this));
  
  uvm_config_db#(uvm_active_passive_enum)::set(.cntxt(this),
				               .inst_name("*"),
				               .field_name("is_active"),
					       .value(UVM_ACTIVE));
  this.vlb_reg_block_0 = vlb_reg_block::type_id::create("vlb_reg_block_0");
  this.vlb_reg_block_0.build();
  this.vlb_reg_block_0.print();
endfunction : build_phase

function void vlb_g2u_env::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  this.vlb_reg_block_0.vlb_map.set_sequencer(this.vlb_g2u_agent_0.g2u_reg_sequencer_0, this.vlb_g2u_agent_0.g2u_reg_adapter_0);
endfunction  : connect_phase



`define VL_CTRL_REG g2u_reg_env_0.vlb_reg_block_0.vl_ctrl_reg
`define VL_DATA_REG g2u_reg_env_0.vlb_reg_block_0.vl_data_reg
`define VLB_REG_BLOCK g2u_reg_env_0.vlb_reg_block_0

