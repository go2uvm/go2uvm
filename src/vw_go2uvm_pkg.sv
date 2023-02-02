/* 
* Copyright (c) 2016-2019 VerifWorks, Bangalore, India
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



//----------------------------------------------------------------------
`ifndef VW_GO2UVM_SVH
`define VW_GO2UVM_SVH

import uvm_pkg::*;
`include "uvm_macros.svh"

package vw_go2uvm_pkg;
  import uvm_pkg::*;
  export uvm_pkg::*;
  `include "uvm_macros.svh"
  string log_id = "Go2UVM";
  parameter string UVM_VW_COPYRIGHT   = "(C) 2016-2022 VerifWorks http://www.verifworks.com ";

  parameter GO2UVM_WDOG_DEL_IN_NS = 10000;

`pragma protect data_method = "aes128-cbc"
`pragma protect author = "IP Provider", author_info = "Widget 5 v3.2"
`pragma protect key_keyowner = "Mentor Graphics Corporation"
`pragma protect key_method = "rsa"
`pragma protect key_keyname = "MGC-VERIF-SIM-RSA-2"
`pragma protect begin

  `include "vw_go2uvm_macros.svh"
  `include "vw_go2uvm_types.svh"


  // Prototypes
  `include "vw_go2uvm_version.svh"
  `include "vw_go2uvm_sig_access.svh"
  `include "vw_go2uvm_comp_access.svh"
  `include "vw_go2uvm_base_test.svh"

  // Implementation
  `include "vw_go2uvm_version.sv"
  `include "vw_go2uvm_sig_access.sv"
  `include "vw_go2uvm_comp_access.sv"
  `include "vw_go2uvm_base_test.sv"

  `include "vw_go2uvm_chkr_lib.sv"


  function string get_name();
    return log_id;
  endfunction : get_name

  function void set_name(string s);
    log_id = s;
  endfunction : set_name

 function void g2u_force (string sig_name, 
    logic [`VW_G2U_SIG_MAX_W-1:0] sig_val, 
    bit verbose = 1,
    bit is_vhdl_sig = 0);
    go2uvm_sig_access::g2u_force (sig_name, 
      sig_val, verbose,is_vhdl_sig);
 endfunction : g2u_force 

  string plus_args_in_code [$];
  string plus_args_from_user [string];

`pragma protect end

endpackage : vw_go2uvm_pkg
`endif // VW_GO2UVM_SVH
import vw_go2uvm_pkg::*;

`include "vw_go2uvm_sim_utils.sv"
`include "vw_go2uvm_clk_utils.sv"

