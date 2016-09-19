`include "vw_enc_kw.v" 
//----------------------------------------------------------------------
//   Copyright 2004-2014 VerifWorks a venture of CVC Pvt Ltd.
//   All Rights Reserved Worldwide
//
//   Licensed under the Apache License, Version 2.0 (the
//  "License"); you may not use this file except in
//   compliance with the License.You may obtain a copy of the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in
//   writing, software distributed under the License is
//   distributed on an "AS IS " BASIS, WITHOUT WARRANTIES OR
//   CONDITIONS OF ANY KIND, either express or implied
//   See the License for the specific language governing
//   permissions and limitations under the License.
//----------------------------------------------------------------------
//
// Protect against multiple inclusion of this file
//

`ifndef VW_Go2UVM_MACROS_SV
`define VW_Go2UVM_MACROS_SV

`define vw_uvm_info(ID,MSG,VERBOSITY) \
   begin \
     if (uvm_report_enabled(VERBOSITY,UVM_INFO,ID)) \
       uvm_report_info (ID, MSG, VERBOSITY); \
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

`define vw_go2uvm_test(TST, VIF) \
   TST vw_go2uvm_test_0; \
    initial begin : stim \
      vw_go2uvm_test_0 = new (); \
      vw_go2uvm_test_0.vif = VIF; \
      run_test (); \
    end : stim



`endif // VW_Go2UVM_MACROS_SV
