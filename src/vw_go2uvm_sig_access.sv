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



    // $signal_force("/testbench/uut/blk1/reset", "1", 0, 3, , 1);
  function void go2uvm_sig_access::g2u_force (string sig_name, 
    logic [`VW_G2U_SIG_MAX_W-1:0] sig_val, 
    bit verbose = 1,
    bit is_vhdl_sig = 0);

    int force_kind;
    int no_rel_time; 
    int no_cancel_period;

    reg [`VW_G2U_SIG_MAX_W-1:0] aldec_lv_src_sig;
    string sig_name_s;

    sig_name_s = sig_name;
    sig_val_s.itoa(sig_val);

    force_kind = 0;
    no_rel_time = 0; // No rel-time support, use g2u_force at right time 
    no_cancel_period = -1; // No cancel, use g2u_release instead

    `ifdef MODEL_TECH
      // For Mentor Questa/MODEL_TECH
      /*
      For the Verilog task, the value must be one of the following;
      0 — default, which is “freeze” for unresolved objects or “drive” 
          for resolved objects
      1 — deposit
      2 — drive
      3 — freeze
      */

      // $signal_force(<dest_object>, <value>, <rel_time>, 
      //               <force_type>, <cancel_period>,
      //               <verbose>)

      sig_val_s = {"10#",sig_val_s};
      $signal_force(sig_name, sig_val_s, no_rel_time, 
                    force_kind, no_cancel_period, verbose);

   `endif // MODEL_TECH

   `ifdef VCS
   `endif // VCS

   `ifdef INCA
      verbose_s = verbose ? "verbose" : "";
      sig_val_s.itoa(sig_val);
     /*
    $nc_force (“source”, “value”, “after_time”, “rel_time”, “repeat_time”,
         “cancel_time”, “verbose”);
    */
      if (verbose) begin : shout
        $nc_force(sig_name_s, sig_val_s, "verbose");
      end : shout
      else begin : quiet
        $nc_force(sig_name_s, sig_val_s);
      end : quiet

   `endif // INCA

    `ifdef _VCP
      // For Aldec Riviera-PRO
      /*
      For the Verilog task, the value must be one of the following;
      0 — default, which is “freeze” for unresolved objects or “drive” 
          for resolved objects
      1 — deposit
      2 — drive
      3 — freeze
      */

      // $signal_agent(<source>, <dest>, <verbose>)
      aldec_lv_src_sig = sig_val;

      sig_val_s = {"10#",sig_val_s};
      // $signal_agent(".aldec_lv_src_sig", sig_name_s, verbose);
      uvm_hdl_force (sig_name_s, sig_val);

   `endif // _VCP

  endfunction : g2u_force

  function void go2uvm_sig_access::g2u_deposit (string sig_name, 
    logic [`VW_G2U_SIG_MAX_W-1:0] sig_val, 
    bit verbose = 1,
    bit is_vhdl_sig = 0);

    int force_kind;
    int no_rel_time; 
    int no_cancel_period;
    string sig_val_s;
    string sig_name_s;

    sig_name_s = sig_name;

    sig_val_s.itoa(sig_val);
    sig_val_s = {"10#",sig_val_s};

    force_kind = 1;
    no_rel_time = 0; // No rel-time support, use g2u_force at right time 
    no_cancel_period = -1; // No cancel, use g2u_release instead

   `ifdef MODEL_TECH
      // For Mentor Questa/MODEL_TECH
      /*
      For the Verilog task, the value must be one of the following;
      0 — default, which is “freeze” for unresolved objects or “drive” 
          for resolved objects
      1 — deposit
      2 — drive
      3 — freeze
      */

      // $signal_force(<dest_object>, <value>, <rel_time>, 
      //               <force_type>, <cancel_period>,
      //               <verbose>)

      $signal_force(sig_name, sig_val_s, no_rel_time, 
                    force_kind, no_cancel_period, verbose);

   `endif // MODEL_TECH

   `ifdef VCS
   `endif // VCS

   `ifdef INCA
      verbose_s = verbose ? "verbose" : "";
      sig_val_s.itoa(sig_val);
     /*
    $nc_force (“source”, “value”, “after_time”, “rel_time”, “repeat_time”,
         “cancel_time”, “verbose”);
    */
      if (verbose) begin : shout
        $nc_deposit(sig_name_s, sig_val_s, "verbose");
      end : shout
      else begin : quiet
        $nc_deposit(sig_name_s, sig_val_s);
      end : quiet

   `endif // INCA

    uvm_hdl_deposit (sig_name_s, sig_val);

  endfunction : g2u_deposit



  function void go2uvm_sig_access::g2u_release (string sig_name, 
    bit verbose = 1,
    bit is_vhdl_sig = 0);

   `ifdef MODEL_TECH
      // $signal_release(<dest_object>, <verbose>)
      $signal_release(sig_name, verbose);
   `endif // MODEL_TECH

   `ifdef VCS
   `endif // VCS

   `ifdef INCA
   `endif // INCA

    uvm_hdl_release (sig_name);

  endfunction : g2u_release

