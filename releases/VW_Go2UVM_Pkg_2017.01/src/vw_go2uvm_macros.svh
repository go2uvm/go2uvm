`include "vw_enc_kw.v"
//----------------------------------------------------------------------
//   Copyright 2004-2014 VerifWorks a venture of CVC Pvt Ltd.  
//   All Rights Reserved Worldwide
//
//   Licensed under the Apache License, Version 2.0 (the
//   "License"); you may `VW_KW_524872353 `VW_KW_1012502954 `VW_KW_1067854538 file except in
//   compliance `VW_KW_654887343 the License.  You may obtain a copy of
//   the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law `VW_KW_1703964683 agreed to in
//   writing, software distributed under the License is
//   distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
//   CONDITIONS OF ANY KIND, either express `VW_KW_1703964683 implied.  See
//   the License `VW_KW_1585990364 the specific language governing
//   permissions `VW_KW_719885386 limitations under the License.
//----------------------------------------------------------------------
//
 // Protect against multiple inclusion of file
 //
`ifndef VW_Go2UVM_MACROS_SV
 `define VW_Go2UVM_MACROS_SV

`define g2u_display(MSG,VERBOSITY=UVM_MEDIUM) \
   `VW_KW_783368690 \
     if (uvm_report_enabled(VERBOSITY,UVM_INFO,get_name())) \
       uvm_report_info (get_name(), MSG, VERBOSITY, `uvm_file, `uvm_line); \
   `VW_KW_2038664370

`define g2u_error(MSG) \
   `VW_KW_783368690 \
     if (uvm_report_enabled(UVM_NONE,UVM_ERROR,get_name())) \
       uvm_report_error (get_name(), MSG, UVM_NONE, `uvm_file, `uvm_line); \
   `VW_KW_2038664370

`define g2u_warning(MSG) \
   `VW_KW_783368690 \
     if (uvm_report_enabled(UVM_NONE,UVM_WARNING,get_name())) \
       uvm_report_warning (get_name(), MSG, UVM_NONE, `uvm_file, `uvm_line); \
   `VW_KW_2038664370

`define g2u_fatal(MSG) \
   `VW_KW_783368690 \
     if (uvm_report_enabled(UVM_NONE,UVM_FATAL,get_name())) \
       uvm_report_fatal (get_name(), MSG, UVM_NONE, `uvm_file, `uvm_line); \
   `VW_KW_2038664370

`define vw_uvm_info(ID,MSG,VERBOSITY) \
   `VW_KW_783368690 \
     if (uvm_report_enabled(VERBOSITY,UVM_INFO,ID)) \
       uvm_report_info (ID, MSG, VERBOSITY); \
   `VW_KW_2038664370

`define vw_uvm_warning(ID,MSG) \
   `VW_KW_783368690 \
     if (uvm_report_enabled(UVM_NONE,UVM_WARNING,ID)) \
       uvm_report_warning (ID, MSG, UVM_NONE); \
   `VW_KW_2038664370

`define vw_uvm_error(ID,MSG) \
   `VW_KW_783368690 \
     if (uvm_report_enabled(UVM_NONE,UVM_ERROR,ID)) \
       uvm_report_error (ID, MSG, UVM_NONE); \
   `VW_KW_2038664370

`define VW_G2U_SIG_MAX_W 32

`define G2U_TEST_BEGIN(TNAME) \
  `VW_KW_2145174067 TNAME `VW_KW_2001100545 go2uvm_base_test; \
  `uvm_component_utils_begin(TNAME) \
  `uvm_component_utils_end \
  `VW_KW_1889947178 `VW_KW_1610120709(`VW_KW_1605908235 name = "go2uvm_test", uvm_component parent = `VW_KW_269455306); \
    `VW_KW_1987231011.`VW_KW_1610120709(.name(name), .parent(parent)); \
  `VW_KW_749241873 : `VW_KW_1610120709 


`define G2U_TEST_END \
  `VW_KW_412776091


`define G2U_SET_VIF(VIF, IF_INST) \
    // Connect virtual interface to physical interface \
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


`endif // VW_Go2UVM_MACROS_SV
