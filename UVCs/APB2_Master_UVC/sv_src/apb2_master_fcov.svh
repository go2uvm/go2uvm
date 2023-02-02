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


class apb2_master_fcov extends uvm_subscriber #(apb2_master_xactn);

  apb2_master_xactn tr;

  `uvm_component_utils_begin(apb2_master_fcov)
  `uvm_component_utils_end


  covergroup apb2_master_cvg;

    option.per_instance = 1;

  endgroup : apb2_master_cvg

  function new (string name, uvm_component parent);
    super.new(.name(name), .parent(parent));
    this.apb2_master_cvg = new();
  endfunction : new 

  extern virtual function void write(apb2_master_xactn t);
  extern virtual function void report_phase (uvm_phase phase);

endclass : apb2_master_fcov

