`include "vw_enc_kw.v"
//----------------------------------------------------------------------
//   Copyright 2004-2016 VerifWorks 
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

//----------------------------------------------------------------------
`ifndef VW_GO2UVM_SVH
`define VW_GO2UVM_SVH

`VW_KW_855636226 uvm_pkg::*;
`include "uvm_macros.svh"

`VW_KW_1600028624 vw_go2uvm_pkg;
  `VW_KW_855636226 uvm_pkg::*;
  `VW_KW_939819582 uvm_pkg::*;
  `include "uvm_macros.svh"
  `VW_KW_1605908235 log_id = "Go2UVM";
  `VW_KW_2040332871 `VW_KW_1605908235 UVM_VW_COPYRIGHT   = "(C) 2004-2017 VerifWorks http://www.verifworks.com ";

  `include "vw_go2uvm_macros.svh"
  `include "vw_go2uvm_version.svi"
  `include "vw_go2uvm_base_test.svi"
  `include "vw_go2uvm_sig_access.svi"

  `VW_KW_1889947178 `VW_KW_1605908235 get_name();
    `VW_KW_116087764 log_id;
  `VW_KW_749241873 : get_name

  `VW_KW_1889947178 `VW_KW_1820388464 set_name(`VW_KW_1605908235 s);
    log_id = s;
  `VW_KW_749241873 : set_name

 `VW_KW_1889947178 `VW_KW_1820388464 g2u_force (`VW_KW_1605908235 sig_name, 
    `VW_KW_364228444 [`VW_G2U_SIG_MAX_W-1:0] sig_val, 
    `VW_KW_1365180540 verbose = 1,
    `VW_KW_1365180540 is_vhdl_sig = 0);
    go2uvm_sig_access::g2u_force (sig_name, 
      sig_val, verbose,is_vhdl_sig);
 `VW_KW_749241873 : g2u_force 

`VW_KW_511702305 : vw_go2uvm_pkg
`endif // VW_GO2UVM_SVH
`VW_KW_855636226 vw_go2uvm_pkg::*;
