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


function void apb2_master_base_test::build_phase(uvm_phase phase);
  super.build_phase(.phase(phase));
  apb2_master_env_0 = apb2_master_env::type_id::create(.name("apb2_master_env"),
                                    .parent(this));
endfunction : build_phase


function void apb2_master_base_test::connect_phase(uvm_phase phase);
  uvm_root::get().print_topology();
endfunction : connect_phase


task apb2_master_base_test::main_phase(uvm_phase phase);
  phase.raise_objection(this);
  `uvm_info(get_name(),"Test is running...",UVM_MEDIUM)
  #1000;
  //delay is simple end of test mechanism
  //use objections in sequences for better end of test detection
  `uvm_info(get_name(), "End of main phase", UVM_MEDIUM)
  phase.drop_objection(this);
endtask : main_phase
