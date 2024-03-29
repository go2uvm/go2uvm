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


function void apb2_master_env::build_phase(uvm_phase phase);
  super.build_phase(.phase(phase));
  apb2_master_agent_0 = apb2_master_agent::type_id::create(.name("apb2_master_agent"),
                                      .parent(this));

  uvm_config_db#(uvm_active_passive_enum)::set(.cntxt(this),
                                               .inst_name("*"),
                                               .field_name("is_active"),
                                               .value(UVM_ACTIVE));
endfunction : build_phase
