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

class sprot_agent extends uvm_agent;

  sprot_sequencer sprot_sequencer_0;
  sprot_driver sprot_driver_0;
  sprot_input_monitor sprot_input_monitor_0;
  sprot_output_monitor sprot_output_monitor_0;
  sprot_scoreboard sprot_scoreboard_0;
  sprot_fcov sprot_fcov_0;
  
  virtual  sprot_if sprot_if_0;
  
  `uvm_component_utils_begin (sprot_agent)
    `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_DEFAULT)
  `uvm_component_utils_end
  
  function new(string name, uvm_component parent);
    super.new(.name(name), .parent(parent));
  endfunction : new
  
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);

endclass : sprot_agent

  function void sprot_agent::build_phase(uvm_phase phase);
       
    super.build_phase(.phase(phase));
    if (!uvm_config_db#(uvm_active_passive_enum)::get
          (.cntxt(this),
           .inst_name(""),
           .field_name("is_active"),
    	   .value(this.is_active))) begin : def_val_for_is_active
             `uvm_warning(get_name,$sformatf("No override for is_active: Using default is_active as:%s",
                                         this.is_active.name));
       end : def_val_for_is_active
       
    
    
      `uvm_info(get_name(),$sformatf("is_active is set to %s",this.is_active.name()),UVM_MEDIUM);   
    
       sprot_input_monitor_0=sprot_input_monitor::type_id::create(.name("sprot_input_monitor"), .parent(this));
       sprot_output_monitor_0=sprot_output_monitor::type_id::create(.name("sprot_output_monitor"), .parent(this));
 
       sprot_scoreboard_0 = sprot_scoreboard::type_id::create(.name("sprot_scoreboard"), .parent(this));
       sprot_fcov_0 = sprot_fcov::type_id::create(.name("sprot_fcov"), .parent(this)); 
    
       if (this.is_active == UVM_ACTIVE)
        begin
          sprot_driver_0=sprot_driver::type_id::create(.name("sprot_driver"),. parent(this));
          sprot_sequencer_0=sprot_sequencer::type_id::create( .name("sprot_sequencer"), .parent(this));
        end
  endfunction : build_phase

  function void sprot_agent::connect_phase(uvm_phase phase);

    if(!uvm_config_db#(virtual sprot_if)::get(this,
          				    "",
          				    "sprot_if_0",
          				     this.sprot_if_0))
       begin:no_vif
      	`uvm_fatal("get_interface","no virtual interface available");
       end:no_vif
     else
       begin:vi_assigned
          `uvm_info("get_interface",$sformatf("virtual interface connected"),UVM_MEDIUM)
       end:vi_assigned

      
    sprot_input_monitor_0.vif = this.sprot_if_0;
    sprot_output_monitor_0.vif = this.sprot_if_0;

    if (this.is_active == UVM_ACTIVE)
      begin
        this.sprot_driver_0.seq_item_port.connect(sprot_sequencer_0.seq_item_export);
        this.sprot_driver_0.vif = this.sprot_if_0;
      end

       this.sprot_input_monitor_0.in_aport.connect(this.sprot_scoreboard_0.in_afifo.analysis_export);
       this.sprot_output_monitor_0.out_aport.connect(this.sprot_scoreboard_0.out_afifo.analysis_export); 
       this.sprot_output_monitor_0.out_aport.connect(this.sprot_fcov_0.analysis_export);

endfunction : connect_phase
