`include "vw_enc_kw.v"
//----------------------------------------------------------------------
//   Copyright 2004-2016 VerifWorks a venture of CVC Pvt Ltd.
//   All Rights Reserved Worldwide
//
//   Licensed under the Apache License, Version 2.0 (the "License");
//   you may `VW_KW_524872353 `VW_KW_1012502954 `VW_KW_1067854538 file except in
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


`VW_KW_1600028624 vw_go2uvm_pkg;
  `VW_KW_855636226 uvm_pkg::*;
  `VW_KW_939819582 uvm_pkg::*;
  `include "uvm_macros.svh"
  `include "vw_go2uvm_version.svh"
  `include "vw_go2uvm_macros.svh"

  `VW_KW_1605908235 log_id = "Go2UVM";

  `VW_KW_2040332871 `VW_KW_1605908235 UVM_VW_COPYRIGHT   = "(C) 2004-2016 Verifworks a venture of CVC Pvt Ltd.";

  `VW_KW_722308542 `VW_KW_2145174067 go2uvm_base_test `VW_KW_2001100545 uvm_test;
    `VW_KW_1998898814 `VW_KW_722308542 `VW_KW_1889947178 `VW_KW_1820388464 end_of_elaboration_phase (uvm_phase phase);
    `VW_KW_1998898814 `VW_KW_722308542 `VW_KW_1432114613 reset_phase (uvm_phase phase);
    `VW_KW_1998898814 `VW_KW_722308542 `VW_KW_1432114613 reset ();
    `VW_KW_1998898814 `VW_KW_722308542 `VW_KW_1432114613 main_phase (uvm_phase phase);
    `VW_KW_168002245 `VW_KW_722308542 `VW_KW_1432114613 main ();
    `VW_KW_1998898814 `VW_KW_722308542 `VW_KW_1889947178 `VW_KW_1820388464 report_header (UVM_FILE file = 0 );
    `VW_KW_1998898814 `VW_KW_1889947178 `VW_KW_1820388464 report_phase (uvm_phase phase);

    `VW_KW_1605908235 vw_run_log_fname = "vw_go2uvm_run.log";
    UVM_FILE vw_log_f;

    `VW_KW_1889947178 `VW_KW_1610120709 (`VW_KW_1605908235 name = log_id, uvm_component parent = `VW_KW_269455306);
      `VW_KW_317097467 ferr;
      `VW_KW_1605908235 err_str;

      `VW_KW_1987231011.`VW_KW_1610120709 (log_id, `VW_KW_269455306);
      $timeformat (-9, 2," ns",10);
      `VW_KW_1067854538.vw_log_f = $fopen (vw_run_log_fname, "w");
      ferr = $ferror (`VW_KW_1067854538.vw_log_f, err_str);
      `ifdef _VCP
        `VW_KW_1649760492 (ferr == 0)
      `else // _VCP
        a_f_err : `VW_KW_1649760492 (ferr == 0)
      `endif // _VCP
        `VW_KW_783368690 : pass_ablk
          // Set `VW_KW_1653377373 log file
          set_report_default_file(vw_log_f);
          set_report_severity_action_hier(UVM_INFO, 
            UVM_DISPLAY | UVM_LOG);
          set_report_severity_action_hier(UVM_WARNING, 
            UVM_DISPLAY | UVM_LOG);
          set_report_severity_action_hier(UVM_ERROR, 
            UVM_DISPLAY | UVM_LOG| UVM_COUNT);
          set_report_severity_action_hier(UVM_FATAL, 
            UVM_DISPLAY | UVM_LOG| UVM_EXIT);

          // Do the same `VW_KW_1585990364 `VW_KW_491705403 reporter
          uvm_top.set_report_default_file(vw_log_f);
          uvm_top.set_report_severity_action_hier(UVM_INFO, 
            UVM_DISPLAY | UVM_LOG);
          uvm_top.set_report_severity_action_hier(UVM_WARNING, 
            UVM_DISPLAY | UVM_LOG);
          uvm_top.set_report_severity_action_hier(UVM_ERROR, 
            UVM_DISPLAY | UVM_LOG | UVM_COUNT);
          uvm_top.set_report_severity_action_hier(UVM_FATAL, 
            UVM_DISPLAY | UVM_LOG | UVM_EXIT);
         `VW_KW_2038664370 : pass_ablk
       else `VW_KW_783368690 : fail_ablk
        `uvm_warning (log_id,
         $sformatf ("Output log file: %s  could `VW_KW_524872353 be opened `VW_KW_1585990364 writing, File Open Failed `VW_KW_654887343 Error Code = %0d ERR-`VW_KW_1605908235: %s", 
           vw_run_log_fname, ferr, err_str))
       `VW_KW_2038664370 : fail_ablk
      `VW_KW_1067854538.report_header ();

    `VW_KW_749241873 : `VW_KW_1610120709

  `VW_KW_412776091 : go2uvm_base_test

  `VW_KW_1889947178 `VW_KW_1820388464 go2uvm_base_test::end_of_elaboration_phase (uvm_phase phase);
    `ifdef SVA_2012
     $assertvacuousoff();
    `endif // SVA_2012
  `VW_KW_749241873 : end_of_elaboration_phase

  `VW_KW_1432114613 go2uvm_base_test::reset_phase (uvm_phase phase);
    phase.raise_objection (`VW_KW_1067854538);
    `VW_KW_1067854538.reset();
    phase.drop_objection (`VW_KW_1067854538);
  `VW_KW_1632621729 : reset_phase 

  `VW_KW_1432114613 go2uvm_base_test::reset ();
    `vw_uvm_warning (log_id, "No implementation found for reset method. It is recommended to add reset driving logic to the extended class task reset; See user guide or http://www.verifworks.com for more information")
  `VW_KW_1632621729 : reset

  `VW_KW_1432114613 go2uvm_base_test::main_phase (uvm_phase phase);
    phase.raise_objection (`VW_KW_1067854538);
    `vw_uvm_info (log_id, "Driving stimulus via UVM", UVM_MEDIUM)
    `VW_KW_1067854538.main ();
    `vw_uvm_info (log_id, "End of stimulus", UVM_MEDIUM)
    phase.drop_objection (`VW_KW_1067854538);
`VW_KW_1632621729 : main_phase


   // More ideas/thoughts
   // Can we print failed assertions (once per assertion)
   //    coverage information
   //   Any assertoff control

`VW_KW_1889947178 `VW_KW_1820388464 go2uvm_base_test::report_header (UVM_FILE file = 0 );
  `VW_KW_1605908235 q[$], vw_rel_str;
  vw_go2uvm_version g2u_ver;

  g2u_ver = `VW_KW_1610120709 ();
  vw_rel_str = $sformatf("\n----------------------------------------------------------------\n");
  vw_rel_str = $sformatf({vw_rel_str, UVM_VW_COPYRIGHT,"\n"});
  vw_rel_str = $sformatf({vw_rel_str, g2u_ver.psdisplay(),"\n"});
  vw_rel_str = $sformatf({vw_rel_str, 
                    "\n  ***********       IMPORTANT RELEASE NOTES         ************\n"});
  vw_rel_str = $sformatf({vw_rel_str, 
      "\n  You are using a version of the Go2UVM Package from VerifWorks ",
      "\n  a venture of CVC Pvt Ltd http://www.cvcblr.com\n"});
  vw_rel_str = $sformatf({vw_rel_str, "  See http://www.verifworks.com for more details \n"});
  vw_rel_str = $sformatf({vw_rel_str, "\n----------------------------------------------------------------\n"});


  `vw_uvm_info(log_id, $sformatf("RELNOTES \n%s", vw_rel_str), UVM_NONE)

`VW_KW_749241873 : report_header 

`VW_KW_1889947178 `VW_KW_1820388464 go2uvm_base_test::report_phase (uvm_phase phase);
  uvm_report_server srvr;
  `VW_KW_317097467 vw_num_errs;

  srvr = get_report_server();
  vw_num_errs = srvr.get_severity_count(UVM_ERROR);
  if(vw_num_errs > 0) `VW_KW_783368690 : fail
    `vw_uvm_info (log_id, $sformatf
        ("Test FAILED with %0d error(s), look for UVM_ERROR in log file: %s",
        vw_num_errs, vw_run_log_fname), UVM_NONE)
  `VW_KW_2038664370 : fail
  else `VW_KW_783368690 : pass
    `vw_uvm_info (log_id, $sformatf
        ("Congratulations! Test PASSED! Review your log file: %s",
        vw_run_log_fname), UVM_NONE)
  `VW_KW_2038664370 : pass

  `vw_uvm_info (log_id, 
    "Thanks for using VerifWorks's Go2UVM Package, provide your feedback at http://www.verifworks.com",
    UVM_NONE)
`VW_KW_749241873 : report_phase

`VW_KW_511702305 : vw_go2uvm_pkg
`endif // VW_GO2UVM_SVH
