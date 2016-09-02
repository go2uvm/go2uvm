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

class sprot_input_monitor extends uvm_monitor;

  virtual sprot_if vif;

  sprot_xactn x0;

  //TLM port for scoreboard communication 
  // (implement scoreboard write method if needed)

  uvm_analysis_port #(sprot_xactn) in_aport;

  `uvm_component_utils_begin(sprot_input_monitor)
  `uvm_component_utils_end

  function new(string name, uvm_component parent);
    super.new(.name(name), .parent(parent));
    in_aport = new(.name("in_aport"), .parent(this));
  endfunction : new

  extern virtual task run_phase(uvm_phase phase);
  extern virtual task collect_data();

endclass : sprot_input_monitor

task sprot_input_monitor::run_phase(uvm_phase phase);
  `uvm_info(get_name(),"Run Phase is Running ..",UVM_HIGH)
  collect_data();
endtask : run_phase

task sprot_input_monitor::collect_data();
endtask : collect_data
