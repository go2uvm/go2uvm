// Copyright (c) 2004-2017 VerifWorks, Bangalore, India
// http://www.verifworks.com 
// Contact: support@verifworks.com 
// 
// This program is part of Go2UVM at www.go2uvm.org
// Some portions of Go2UVM are free software.
// You can redistribute it and/or modify  
// it under the terms of the GNU Lesser General Public License as   
// published by the Free Software Foundation, version 3.
//
// VerifWorks reserves the right to obfuscate part or full of the code
// at any point in time. 
// We also support a comemrical licensing option for an enhanced version
// of Go2UVM, please contact us via support@verifworks.com
//
// This program is distributed in the hope that it will be useful, but 
// WITHOUT ANY WARRANTY; without even the implied warranty of 
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU 
// Lesser General Lesser Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public License
// along with this program. If not, see <http://www.gnu.org/licenses/>.

  // Requirement
  // After "start_sig" goes high
  // within a variable delay of var_del clock cycles
  // signal "end_sig" should go high

  // start_sig |-> ##[1:var_del] end_sig

import uvm_pkg::*;
`include "uvm_macros.svh"

module vw_var_del_in_sva (
input  clk, rst_n, start_sig, end_sig,
 input int  var_del); 

  default clocking cb @(posedge clk);
  endclocking : cb
  default disable iff (!rst_n);

 
  property p_with_var_delay;
    int v_cnt;
    (start_sig, v_cnt = var_del + 1'b1,
          uvm_report_info("VW_CIP", $sformatf("v_cnt: %0d", v_cnt), UVM_FULL)
    )  |->  
      (
       (v_cnt > 0, v_cnt = v_cnt - 1, 
          uvm_report_info ("VW_CIP", $sformatf ("v_cnt: %0d", v_cnt), UVM_FULL)
       )[*1:$] ##1 (end_sig && v_cnt >= 0)
      ) ;         
  endproperty : p_with_var_delay
  ap_seq_with_var_delay : assert property (p_with_var_delay)
  else `uvm_error ("VW_CIP", 
    $sformatf("end_sig did not go high within %0d number of clocks after start_sig", var_del))


endmodule : vw_var_del_in_sva

