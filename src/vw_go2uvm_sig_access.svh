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



class go2uvm_sig_access extends uvm_object;
  `uvm_object_utils(go2uvm_sig_access)

  static string sig_name_s;
  static string sig_val_s;
  static string verbose_s;

  function new (string name = "go2uvm_sig_access");
    super.new (name);
  endfunction : new

  extern static function void g2u_force (string sig_name, 
    logic [`VW_G2U_SIG_MAX_W-1:0] sig_val, 
    bit verbose = 1,
    bit is_vhdl_sig = 0);

  extern static function void g2u_deposit (string sig_name, 
    logic [`VW_G2U_SIG_MAX_W-1:0] sig_val, 
    bit verbose = 1,
    bit is_vhdl_sig = 0);

   extern static function void g2u_release (string sig_name, 
    bit verbose = 1,
    bit is_vhdl_sig = 0);

endclass : go2uvm_sig_access 

  /*
  extern static function void g2u_observe (string orig_sig_name,
    string local_sig_name, 
    bit verbose = 1);
    $init_signal_spy(orig_sig_name, local_sig_name, verbose);
  endfunction : g2u_observe
  */
