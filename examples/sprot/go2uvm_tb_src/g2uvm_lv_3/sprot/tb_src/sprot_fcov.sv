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

class sprot_fcov extends uvm_subscriber #(sprot_xactn);

  sprot_xactn tr;

  `uvm_component_utils_begin(sprot_fcov)
  `uvm_component_utils_end


  covergroup sprot_cvg;
  
    option.per_instance = 1;
    
  endgroup : sprot_cvg

  function new (string name, uvm_component parent);
    super.new(.name(name), .parent(parent));
    this.sprot_cvg = new();
  endfunction : new

  extern virtual function void write(sprot_xactn t);
  extern virtual function void report_phase (uvm_phase phase);

endclass : sprot_fcov


function void sprot_fcov::write(sprot_xactn t);
  this.tr = t;
  this.sprot_cvg.sample();
endfunction : write


  
function void sprot_fcov::report_phase (uvm_phase phase);
  `uvm_info (get_name(), $sformatf (" Test achieved functional coverage: %3.2f%%", this.sprot_cvg.get_coverage()), UVM_LOW)
endfunction : report_phase
