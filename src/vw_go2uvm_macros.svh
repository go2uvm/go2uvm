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



 // Protect against multiple inclusion of file
 //
`ifndef VW_GO2UVM_MACROS_SV
 `define VW_GO2UVM_MACROS_SV

`define g2u_display(MSG,VERBOSITY=UVM_MEDIUM) \
   begin \
     if (uvm_report_enabled(VERBOSITY,UVM_INFO,get_name())) \
       uvm_report_info (get_name(), MSG, VERBOSITY, `uvm_file, `uvm_line); \
   end

`define g2u_printf(FORMAT_MSG,VERBOSITY=UVM_MEDIUM) \
   begin \
     if (uvm_report_enabled(VERBOSITY,UVM_INFO,get_name())) \
       uvm_report_info (get_name(), $sformatf FORMAT_MSG, VERBOSITY, `uvm_file, `uvm_line); \
   end


`define g2u_error(MSG) \
   begin \
     if (uvm_report_enabled(UVM_NONE,UVM_ERROR,get_name())) \
       uvm_report_error (get_name(), MSG, UVM_NONE, `uvm_file, `uvm_line); \
   end

`define g2u_warning(MSG) \
   begin \
     if (uvm_report_enabled(UVM_NONE,UVM_WARNING,get_name())) \
       uvm_report_warning (get_name(), MSG, UVM_NONE, `uvm_file, `uvm_line); \
   end

`define g2u_fatal(MSG) \
   begin \
     if (uvm_report_enabled(UVM_NONE,UVM_FATAL,get_name())) \
       uvm_report_fatal (get_name(), MSG, UVM_NONE, `uvm_file, `uvm_line); \
   end

`define g2u_rand(XN) \
   begin \
     if (!XN.randomize()) begin \
       uvm_report_warning ("RNDFLD",  $sformatf ("Failed to randmoize transaction: %s ", XN.sprint()), \
        UVM_NONE, `uvm_file, `uvm_line); \
     end \
   end

`define g2u_rand_with(XN, CNST) \
   begin \
     if (!XN.randomize() with CNST) begin \
       uvm_report_warning ("RNDFLD",  $sformatf ("Failed to randmoize transaction: %s ", XN.sprint()), \
        UVM_NONE, `uvm_file, `uvm_line); \
     end \
   end


`define vw_uvm_warning(ID,MSG) \
   begin \
     if (uvm_report_enabled(UVM_NONE,UVM_WARNING,ID)) \
       uvm_report_warning (ID, MSG, UVM_NONE); \
   end

`define vw_uvm_error(ID,MSG) \
   begin \
     if (uvm_report_enabled(UVM_NONE,UVM_ERROR,ID)) \
       uvm_report_error (ID, MSG, UVM_NONE); \
   end

`define VW_G2U_SIG_MAX_W 32

`define G2U_TEST_BEGIN(TNAME) \
  class TNAME extends go2uvm_base_test; \
  `uvm_component_utils_begin(TNAME) \
  `uvm_component_utils_end \
  function new(string name = "go2uvm_test", uvm_component parent = null); \
    super.new(.name(name), .parent(parent)); \
  endfunction : new 


`define G2U_TEST_END \
  endclass

`define vw_uvm_info(ID,MSG,VERBOSITY) \
   begin \
     if (uvm_report_enabled(VERBOSITY,UVM_INFO,ID)) \
       uvm_report_info (ID, MSG, VERBOSITY); \
   end


    // Connect virtual interface to physical interface 
`define G2U_SET_VIF(VIF, IF_INST) \
    uvm_config_db#(virtual VIF)::set(    \
     .cntxt(null), .inst_name("*"),               \
     .field_name("vif"), .value(IF_INST)); 


  // Create a handle to the actual interface 
`define G2U_GET_VIF(VIF) \
  virtual VIF vif;  \
  function void build_phase(uvm_phase phase); \
    super.build_phase(phase); \
    if (!uvm_config_db#(virtual VIF)::get( \
      .cntxt(null), .inst_name("*"), \
      .field_name("vif"), .value(vif))) begin : no_vif \
        `g2u_fatal("Unable to connect virtual interface to physical interface, Make sure to use `G2U_SET_VIF macro in top module") \
    end : no_vif \
    else begin : vif_connected \
      `g2u_display("Successfully hooked up virtual interface") \
    end : vif_connected \
  endfunction : build_phase 


`define G2U_MSET_VIF(VIF, IF_INST) \
    uvm_config_db#(virtual VIF)::set(    \
     .cntxt(null), .inst_name("*"),               \
     .field_name(`"IF_INST`"), .value(IF_INST)); 




`define G2U_MGET_VIF(VIF, VIF_INST) \
    `g2u_display ( \
       $sformatf("Looking for a virtual interface of type: %s name: %s", \
        `"VIF`", `"VIF_INST`")) \
    if (!uvm_config_db#(virtual VIF)::get( \
      .cntxt(this), .inst_name(""), \
      .field_name(`"VIF_INST`"), .value(VIF_INST))) begin \
        `g2u_fatal("Unable to connect virtual interface to physical interface, Make sure to use `G2U_SET_VIF macro in top module") \
    end  \
    else begin \
      `g2u_display("Successfully hooked up virtual interface") \
    end 


`define G2U_TURN_ABV_OFF(abv) \
    begin \
      static string abv_name = "ABV"; \
      `uvm_warning("ASSERTIONS",  \
        $sformatf("Turning off %s after first failure", abv_name)) \
      $assertoff (1, abv);  \
   end



`define GO2UVM_DISP_ARG(arg) `"arg`"

`define GO2UVM_WAIT(END_SIG, WDOG_VAL = GO2UVM_WDOG_DEL_IN_NS) \
  fork \
  begin \
  string msg; \
  wait (END_SIG); \
  msg = $sformatf ("Wait seen in condition: %s ", `GO2UVM_DISP_ARG(END_SIG) ); \
  `g2u_display (msg); \
  end \
  begin \
  string msg; \
  #(WDOG_VAL * 1ns); \
  msg = $sformatf ("WDOG expired after waiting for: %0d %s %s", WDOG_VAL, "ns Wait condition: ", `GO2UVM_DISP_ARG(END_SIG) ); \
  `g2u_error (msg); \
  end \
  join_any \
  disable fork; 


`define GO2UVM_WAIT_EV(EV_SPEC, WDOG_VAL = GO2UVM_WDOG_DEL_IN_NS) \
  fork \
  begin \
  string msg; \
  @ (EV_SPEC); \
  msg = $sformatf ("Wait seen in condition: @(%s) ", `GO2UVM_DISP_ARG(EV_SPEC) ); \
  `g2u_display (msg); \
  end \
  begin \
  string msg; \
  #(WDOG_VAL * 1ns); \
  msg = $sformatf ("WDOG expired after waiting for: %0d %s @(%s)", WDOG_VAL, "ns Wait condition: ", `GO2UVM_DISP_ARG(EV_SPEC) ); \
  `g2u_error (msg); \
  end \
  join_any \
  disable fork; 




`define G2U_REG_DISPLAY(g2u_reg) \
    begin \
      uvm_reg_data_t mirr_val, des_val; \
      mirr_val = g2u_reg.get_mirrored_value(); \
      des_val = g2u_reg.get(); \
      `g2u_display($sformatf("%s: Mirrored_value: 0x%0x desired_value: 0x%0x", \
                 g2u_reg.get_name(), mirr_val, des_val)) \
   end

`define G2U_CAST(dst, src) \
  begin \
    bit ret_val; \
    ret_val = $cast (dst, src); \
    if (!ret_val) \
      `uvm_error ("G2U_CAST", "Unable to $cast dst to src, check datatype compatibility") \
  end

 `define G2U_VPL_INT(ARG_NAME) \
   begin \
     string fmt_str, str; \
     str = `GO2UVM_DISP_ARG (ARG_NAME); \
     fmt_str = {str, "=%0d"}; \
     void '($value$plusargs (fmt_str, ARG_NAME) ); \
     plus_args_in_code.push_back (str); \
     cov_clp_arg : cover (ARG_NAME); \
   end

`define G2U_VPL_STR(ARG_NAME) \
   begin \
     string fmt_str, str; \
     str = `GO2UVM_DISP_ARG (ARG_NAME); \
     fmt_str = {str, "=%0s"}; \
     void '($value$plusargs (fmt_str, ARG_NAME) ); \
     plus_args_in_code.push_back (str); \
   end



`endif // VW_GO2UVM_MACROS_SV
