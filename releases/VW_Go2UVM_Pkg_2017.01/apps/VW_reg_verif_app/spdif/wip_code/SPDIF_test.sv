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


//-- spdif_REG_TEST

import spdif_pkg_uvm::*;
import uvm_pkg::*;
`include "uvm_macros.svh"

class spdif_reg_test extends uvm_test;
  `uvm_component_utils_begin (spdif_reg_test)
  `uvm_component_utils_end

  spdif_reg_block   spdif_reg_model;
  uvm_status_e    status;
  uvm_reg_data_t  value;

  function new(string name, uvm_component parent );
    super.new(name,parent);
  endfunction :new

  extern virtual function void    build_phase (uvm_phase phase);
  extern virtual task             main_phase  (uvm_phase phase);

endclass :spdif_reg_test


//-------------------------------build_phase---------------------------------------------//
function void spdif_reg_test::build_phase(uvm_phase phase);          
  super.build_phase(phase);
   spdif_reg_model = spdif_reg_block::type_id::create(.name("spdif_reg_model"),.parent(this));  // Builds/Creates a space for spdif_reg_test
   this.spdif_reg_model.build();
endfunction : build_phase

//-------------------------------main_phase-----------------------------------------------//
task spdif_reg_test::main_phase (uvm_phase phase);
  int res;

  phase.raise_objection (this);
 
  `g2u_display("spdif_reg_test","Test is running......",UVM_MEDIUM)
   
   res =spdif_reg_model.randomize();                                            
   this.spdif_reg_model.print();
   this.spdif_reg_model.SPDIF_Tx_Int_Mask.print();
   this.value = spdif_reg_model.SPDIF_Tx_Int_Mask.get();
   `g2u_display (get_name(), $sformatf("%p", this.value), UVM_MEDIUM)

   #1000;
   `g2u_display("spdif_reg_test","USER ACTIVATED END OF SIMULATION",UVM_LOW)

  phase.drop_objection(this);
endtask :main_phase


module top;

  initial begin : test
    run_test();
  end : test

endmodule : top



