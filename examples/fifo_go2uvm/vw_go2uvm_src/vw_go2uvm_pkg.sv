`include "vw_enc_kw.v"
//----------------------------------------------------------------------
//   Copyright 2004-2016 VerifWorks a venture of CVC Pvt Ltd.
//   All Rights Reserved Worldwide
//
//   Licensed under the Apache License, Version 2.0 (the "License");
//   you may not use this file except in
//   compliance with the License.  You may obtain a copy of
//   the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in
//   writing, software distributed under the License is
//   distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
//   CONDITIONS OF ANY KIND, either express or implied.  See
//   the License for the specific language governing
//   permissions and limitations under the License.
//----------------------------------------------------------------------

//----------------------------------------------------------------------
`ifndef VW_GO2UVM_SVH
`define VW_GO2UVM_SVH


package vw_go2uvm_pkg;
  import uvm_pkg::*;
  export uvm_pkg::*;
  `include "uvm_macros.svh"
  `include "vw_go2uvm_version.svh"
  `include "vw_go2uvm_macros.svh"

  string log_id = "Go2UVM";

  parameter string UVM_VW_COPYRIGHT   = "(C) 2004-2016 Verifworks a venture of CVC Pvt Ltd.";

  virtual class go2uvm_base_test extends uvm_test;
    extern virtual function void end_of_elaboration_phase (uvm_phase phase);
    extern virtual task reset_phase (uvm_phase phase);
    extern virtual task reset ();
    extern virtual task main_phase (uvm_phase phase);
    pure virtual task main ();
    extern virtual function void report_header (UVM_FILE file = 0 );
    extern function void report_phase (uvm_phase phase);

    string vw_run_log_fname = "vw_go2uvm_run.log";
    UVM_FILE vw_log_f;

    function new (string name = log_id, uvm_component parent = null);
      int ferr;
      string err_str;

      super.new (log_id, null);
      $timeformat (-9, 2," ns",10);
      this.vw_log_f = $fopen (vw_run_log_fname, "w");
      ferr = $ferror (this.vw_log_f, err_str);
      `ifdef _VCP
        assert (ferr == 0)
      `else // _VCP
        a_f_err : assert (ferr == 0)
      `endif // _VCP
        begin : pass_ablk
          // Set default log file
          set_report_default_file(vw_log_f);
          set_report_severity_action_hier(UVM_INFO, 
            UVM_DISPLAY | UVM_LOG);
          set_report_severity_action_hier(UVM_WARNING, 
            UVM_DISPLAY | UVM_LOG);
          set_report_severity_action_hier(UVM_ERROR, 
            UVM_DISPLAY | UVM_LOG| UVM_COUNT);
          set_report_severity_action_hier(UVM_FATAL, 
            UVM_DISPLAY | UVM_LOG| UVM_EXIT);

          // Do the same for global reporter
          uvm_top.set_report_default_file(vw_log_f);
          uvm_top.set_report_severity_action_hier(UVM_INFO, 
            UVM_DISPLAY | UVM_LOG);
          uvm_top.set_report_severity_action_hier(UVM_WARNING, 
            UVM_DISPLAY | UVM_LOG);
          uvm_top.set_report_severity_action_hier(UVM_ERROR, 
            UVM_DISPLAY | UVM_LOG | UVM_COUNT);
          uvm_top.set_report_severity_action_hier(UVM_FATAL, 
            UVM_DISPLAY | UVM_LOG | UVM_EXIT);
         end : pass_ablk
       else begin : fail_ablk
        `uvm_warning (log_id,
         $sformatf ("Output log file: %s  could not be opened for writing, File Open Failed with Error Code = %0d ERR-string: %s", 
           vw_run_log_fname, ferr, err_str))
       end : fail_ablk
      this.report_header ();

    endfunction : new

  endclass : go2uvm_base_test

  function void go2uvm_base_test::end_of_elaboration_phase (uvm_phase phase);
    `ifdef SVA_2012
     $assertvacuousoff();
    `endif // SVA_2012
  endfunction : end_of_elaboration_phase

  task go2uvm_base_test::reset_phase (uvm_phase phase);
    phase.raise_objection (this);
    this.reset();
    phase.drop_objection (this);
  endtask : reset_phase 

  task go2uvm_base_test::reset ();
    `vw_uvm_warning (log_id, "No implementation found for reset method. It is recommended to add reset driving logic to the extended class task reset; See user guide or http://www.verifworks.com for more information")
  endtask : reset

  task go2uvm_base_test::main_phase (uvm_phase phase);
    phase.raise_objection (this);
    `vw_uvm_info (log_id, "Driving stimulus via UVM", UVM_MEDIUM)
    this.main ();
    `vw_uvm_info (log_id, "End of stimulus", UVM_MEDIUM)
    phase.drop_objection (this);
endtask : main_phase


   // More ideas/thoughts
   // Can we print failed assertions (once per assertion)
   //    coverage information
   //   Any assertoff control

function void go2uvm_base_test::report_header (UVM_FILE file = 0 );
  string q[$], vw_rel_str;
  vw_go2uvm_version g2u_ver;

  g2u_ver = new ();
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

endfunction : report_header 

function void go2uvm_base_test::report_phase (uvm_phase phase);
  uvm_report_server srvr;
  int vw_num_errs;

  srvr = get_report_server();
  vw_num_errs = srvr.get_severity_count(UVM_ERROR);
  if(vw_num_errs > 0) begin : fail
    `vw_uvm_info (log_id, $sformatf
        ("Test FAILED with %0d error(s), look for UVM_ERROR in log file: %s",
        vw_num_errs, vw_run_log_fname), UVM_NONE)
  end : fail
  else begin : pass
    `vw_uvm_info (log_id, $sformatf
        ("Congratulations! Test PASSED! Review your log file: %s",
        vw_run_log_fname), UVM_NONE)
  end : pass

  `vw_uvm_info (log_id, 
    "Thanks for using VerifWorks's Go2UVM Package, provide your feedback at http://www.verifworks.com",
    UVM_NONE)
endfunction : report_phase

endpackage : vw_go2uvm_pkg
`endif // VW_GO2UVM_SVH
