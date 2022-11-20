/* 
* Copyright (c) 2004-2017 VerifWorks, Bangalore, India
* http://www.verifworks.com 
* Contact: support@verifworks.com 
* 
* This program is part of Go2UVM at www.go2uvm.org
* Some portions of Go2UVM are free software.
* You can redistribute it under the terms of the 
* GNU Lesser General Public License as   
* published by the Free Software Foundation, version 3 and provided
* that this original copyright is retained intact
*
* VerifWorks reserves the right to obfuscate part or full of the code
* at any point in time. You are not allowed to decrypt or reverse-engineer
* this code without explicit, written permission from the original authors
* 
* We also support a commerical licensing option for an enhanced version
* of Go2UVM, please contact us via support@verifworks.com

* This program is distributed in the hope that it will be useful, but 
* WITHOUT ANY WARRANTY; without even the implied warranty of 
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU 
* Lesser General Lesser Public License for more details.
*
* You should have received a copy of the GNU Lesser General Public License
* along with this program. If not, see <http://www.gnu.org/licenses/>.
*/

function go2uvm_comp_access::new 
  (string name = "go2uvm_comp_access", 
   uvm_component parent = null);
  super.new(name, parent);
endfunction : new



function go2uvm_comp_access::T go2uvm_comp_access::get_comp 
  (string abs_path_to_comp, bit verbose = 0);

  uvm_component found_comp;
  T target_comp;
  bit cast_res;
  
  found_comp = uvm_top.find(abs_path_to_comp);

  if (found_comp == null) begin : err
    return null;
  end : err
  else begin : path_ok
    cast_res = $cast (target_comp, found_comp);

    if (!cast_res) begin : type_err
      return null;
    end : type_err
    else begin : all_ok
      return target_comp;
    end : all_ok
  end : path_ok

endfunction : get_comp 
