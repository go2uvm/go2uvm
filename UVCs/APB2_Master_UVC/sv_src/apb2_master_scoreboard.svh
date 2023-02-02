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


class apb2_master_scoreboard extends uvm_scoreboard;

    apb2_master_xactn trans;

  `uvm_component_utils_begin(apb2_master_scoreboard)
    `uvm_field_object(trans,UVM_ALL_ON)
  `uvm_component_utils_end   

 uvm_tlm_analysis_fifo #(apb2_master_xactn) in_afifo; 
// uvm_tlm_analysis_fifo #(apb2_master_xactn) out_afifo; 
 
  function new(string name, uvm_component parent);
    super.new(.name(name),.parent(parent));
     in_afifo = new("in_afifo",this);
//     out_afifo = new("out_afifo",this);
  endfunction : new
 
  int i;
  int k;
  int imax;
  int pass_count, fail_count, invl_count;
  bit [DATA_WIDTH-1:0]apb_mem [0:32];

  extern virtual task run_phase(uvm_phase phase);

endclass : apb2_master_scoreboard

