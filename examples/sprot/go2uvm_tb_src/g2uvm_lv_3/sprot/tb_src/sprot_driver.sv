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

class sprot_driver extends uvm_driver #(sprot_xactn);

  virtual sprot_if vif;
  

  function new(string name, uvm_component parent);
    super.new(.name(name), .parent(parent));
  endfunction : new

  `uvm_component_utils_begin(sprot_driver)
  `uvm_component_utils_end

  extern virtual task reset_phase(uvm_phase phase);
  extern virtual task main_phase(uvm_phase phase);
endclass : sprot_driver 


task sprot_driver::reset_phase(uvm_phase phase);
  `uvm_info(get_name(),"Start of Reset Phase ....",UVM_HIGH)
    phase.raise_objection(this);

    phase.drop_objection(this);
  `uvm_info(get_name(),"End of Reset Phase ....",UVM_HIGH)
endtask : reset_phase

task sprot_driver::main_phase(uvm_phase phase);
  `uvm_info(get_name(),"Start of Main Phase ....",UVM_HIGH)
  forever
    begin : b1
      this.seq_item_port.get_next_item(this.req);
      `uvm_info(get_name(),
                $sformatf("Driving req: %s", this.req.sprint()), UVM_MEDIUM)
      this.seq_item_port.item_done();
    end	: b1
endtask : main_phase
