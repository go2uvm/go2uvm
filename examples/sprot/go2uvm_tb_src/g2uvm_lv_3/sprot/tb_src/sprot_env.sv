//#----------------------------------------------------------------------
//#   Copyright 2004-2014 CVC Pvt. Ltd. Bangalore, India
//#    http://www.cvcblr.com 
//#   All Rights Reserved Worldwide
//#
//#   Licensed under the Apache License, Version 2.0 (the
//#   "License"); you may not use this file except in
//#   compliance with the License.  You may obtain a copy of
//#   the License at
//#
//#       http://www.apache.org/licenses/LICENSE-2.0
//#
//#   Unless required by applicable law or agreed to in
//#   writing, software distributed under the License is
//#   distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
//#   CONDITIONS OF ANY KIND, either express or implied.  See
//#   the License for the specific language governing
//#   permissions and limitations under the License.
//#----------------------------------------------------------------------

class sprot_env extends uvm_env;

  sprot_agent sprot_agent_0;

  `uvm_component_utils(sprot_env)

  function new(string name, uvm_component parent);
    super.new(.name(name), .parent(parent));
  endfunction : new

  extern virtual function void build_phase(uvm_phase phase);

endclass : sprot_env 

function void sprot_env::build_phase(uvm_phase phase);
  super.build_phase(.phase(phase));
  sprot_agent_0 = sprot_agent::type_id::create(.name("sprot_agent"),
				      .parent(this));
  
  uvm_config_db#(uvm_active_passive_enum)::set(.cntxt(this),
				               .inst_name("*"),
				               .field_name("is_active"),
					       .value(UVM_ACTIVE));
endfunction : build_phase
