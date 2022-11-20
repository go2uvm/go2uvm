// CIP library
//

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


  // Requirement
  // After "start_sig" goes high
  // within a variable delay of var_del clock cycles
  // signal "end_sig" should go high

  // start_sig |-> ##[1:var_del] end_sig


`ifdef VW_GO2UVM_CIP

checker vw_window_chk (
  clk, rst_n, start_sig, end_sig,
  int  var_del); 

    default clocking cb @(posedge clk);
    endclocking : cb

  default disable iff (!rst_n);

 
  property p_var_delay_window;
    int v_cnt;
    (start_sig, v_cnt = var_del,
          uvm_report_info("VW_CIP", $sformatf("v_cnt: %0d", v_cnt), UVM_FULL)
    )  |->  
      (
       (v_cnt > 0, v_cnt = v_cnt - 1, 
          uvm_report_info ("VW_CIP", $sformatf ("v_cnt: %0d", v_cnt), UVM_FULL)
       )[*1:$] ##1 (end_sig && v_cnt >= 0) // Within a window of variable-delay check
      ) ;         
  endproperty : p_var_delay_window
  a_p_var_delay_window : assert property (p_var_delay_window)
  else begin : fail
    `uvm_error ("VW_CIP", 
      $sformatf("end_sig did not go high within %0d number of clocks after start_sig", var_del))
     `G2U_TURN_ABV_OFF(a_p_var_delay_window)
  end : fail

endchecker : vw_window_chk

checker vw_var_del_chk (
  clk, rst_n, has_check, start_sig, end_sig,
  int unsigned  var_del,
  string label = "vw_var_del_chk",
  string msg = "",
  string fname = `__FILE__,
  int unsigned line = `__LINE__
  ); 

    default clocking cb @(posedge clk);
    endclocking : cb
  default disable iff (!rst_n || !has_check);

 
  int unsigned v_cnt_del;
  string fail_msg;
  string def_msg = (msg == "") ?  
    $sformatf("Timing violation: end_sig did not go high after start_sig in num_clocks: ") :
    msg;

  `ifndef QUESTA
  always_comb begin : b1
    `g2u_display ($sformatf("%m VW: Dbg: var_del: %0d", var_del))
    fail_msg = $sformatf("%s %0d", def_msg, var_del);
  end : b1
  `endif

  property p_with_var_delay;
    int v_cnt;
    (start_sig, v_cnt = var_del,
          uvm_report_info("VW_CIP", $sformatf("v_cnt: %0d", v_cnt), UVM_FULL)
    )  |->  
      (
       (v_cnt > 0, v_cnt = v_cnt - 1, 
          uvm_report_info ("VW_CIP", $sformatf ("v_cnt: %0d", v_cnt), UVM_FULL)
       )[*1:$] ##1 (end_sig && v_cnt == 0) // Exact delay check
      ) ;         
  endproperty : p_with_var_delay
  ap_seq_with_var_delay : assert property (p_with_var_delay)
  else begin : fail
   uvm_report_error (label, fail_msg, UVM_NONE, fname, line);
   `G2U_TURN_ABV_OFF(ap_seq_with_var_delay)
  end : fail

  initial begin : p_count_delay

    forever begin : fe_1
     ##1;

    if (!rst_n) begin : rst_b1
      v_cnt_del = 0;
    end : rst_b1
    else begin : out_of_rst
      wait (start_sig === 1'b1);
      v_cnt_del = 0;
      ##1;
      fork 
        begin : end_sig_thread 
          wait (end_sig === 1'b1);
        end : end_sig_thread 
        begin : wdog_thread 
          forever begin : fe_2
            v_cnt_del++;
            ##1;
          end : fe_2
        end : wdog_thread 
      join_any 
      disable fork;

      uvm_report_info (label, $sformatf ("p_count_delay: Found end_sig after: %0d clocks", v_cnt_del), UVM_NONE, fname, line);
    end : out_of_rst
    end : fe_1
  end : p_count_delay

endchecker : vw_var_del_chk

checker vw_window_chk_min (
  clk, rst_n, start_sig, end_sig,
  int  min_del, int max_del); 

    default clocking cb @(posedge clk);
    endclocking : cb

  default disable iff (!rst_n);

 
  property p_var_delay_window;
    int unsigned v_cnt = 0;
    (start_sig, v_cnt = 0,
          uvm_report_info("VW_CIP", $sformatf("Starting v_cnt: %0d min_del: %0d max_del: %0d", v_cnt, min_del, max_del), UVM_LOW)
    )  |->  
      (
       ( (v_cnt < max_del), v_cnt = v_cnt + 1, 
          uvm_report_info ("VW_CIP", $sformatf ("v_cnt: %0d", v_cnt), UVM_LOW)
       )[*1:$] ##1 ( (end_sig), // && v_cnt > min_del && v_cnt < max_del), // Within a window of variable-delay check
          uvm_report_info ("VW_CIP", $sformatf ("end_sig: v_cnt: %0d", v_cnt), UVM_LOW))
      ) ;         
  endproperty : p_var_delay_window
  a_p_var_delay_window : assert property (p_var_delay_window)
  else begin : fail
    `uvm_error ("VW_CIP", 
      $sformatf("end_sig did not go high within %0d number of clocks after start_sig", max_del))
     `G2U_TURN_ABV_OFF(a_p_var_delay_window)
  end : fail

endchecker : vw_window_chk_min

`endif // VW_GO2UVM_CIP
