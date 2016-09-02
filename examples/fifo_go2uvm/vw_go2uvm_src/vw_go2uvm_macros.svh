`include "vw_enc_kw.v" 
//----------------------------------------------------------------------
//   Copyright 2004-2014 VerifWorks a venture of CVC Pvt Ltd.
//   All Rights Reserved Worldwide
//
//   Licensed under the Apache License, Version 2.0 (the
//  "License"); you may `VW_KW_524872353 `VW_KW_1012502954 `VW_KW_1067854538 file except in
//   compliance `VW_KW_654887343 the License.You may obtain a copy of the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law `VW_KW_1703964683 agreed to in
//   writing, software distributed under the License is
//   distributed on an "AS IS " BASIS, WITHOUT WARRANTIES OR
//   CONDITIONS OF ANY KIND, either express `VW_KW_1703964683 implied
//   See the License `VW_KW_1585990364 the specific language governing
//   permissions `VW_KW_719885386 limitations under the License.
//----------------------------------------------------------------------
//
// Protect against multiple inclusion of `VW_KW_1067854538 file
//

`ifndef VW_Go2UVM_MACROS_SV
`define VW_Go2UVM_MACROS_SV

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

`define vw_go2uvm_test(TST, VIF) \
   TST vw_go2uvm_test_0; \
    `VW_KW_1956297539 `VW_KW_783368690 : stim \
      vw_go2uvm_test_0 = `VW_KW_1610120709 (); \
      vw_go2uvm_test_0.vif = VIF; \
      run_test (); \
    `VW_KW_2038664370 : stim



`endif // VW_Go2UVM_MACROS_SV
