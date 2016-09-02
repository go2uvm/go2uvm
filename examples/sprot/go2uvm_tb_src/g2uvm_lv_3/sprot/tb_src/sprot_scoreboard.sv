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

class sprot_scoreboard extends uvm_scoreboard;

    sprot_xactn trans;
  
  `uvm_component_utils_begin(sprot_scoreboard)
  `uvm_component_utils_end
 
  uvm_tlm_analysis_fifo #(sprot_xactn) in_afifo;
  uvm_tlm_analysis_fifo #(sprot_xactn) out_afifo;
  
  function new(string name, uvm_component parent);
    super.new(.name(name), .parent(parent));
     in_afifo = new("in_afifo",this);
     out_afifo = new("out_afifo",this); 
  endfunction : new

  extern virtual task run_phase(uvm_phase phase);

endclass : sprot_scoreboard


task sprot_scoreboard::run_phase(uvm_phase phase);
  `uvm_info(get_name(),"Start of Run phase ..",UVM_MEDIUM)
endtask : run_phase
