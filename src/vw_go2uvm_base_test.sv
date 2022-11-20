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




function go2uvm_base_test::new (string name = "go2uvm_test", 
                                uvm_component parent = null);
      int ferr;
      string err_str;
      uvm_report_handler local_m_rh;

      super.new (name, parent);
      $timeformat (-9, 2, " ns", 10);
      this.log_id = get_name();

    /*
      For now Makefile handles log file naming

      this.vw_log_f = $fopen (vw_run_log_fname, "w");
      ferr = $ferror (this.vw_log_f, err_str);
      a_f_err : assert (ferr == 0) 
        begin : pass_ablk
          // Set default log file
          set_report_default_file(this.vw_log_f);
          set_report_severity_action_hier(UVM_INFO, 
            UVM_DISPLAY | UVM_LOG);
          set_report_severity_action_hier(UVM_WARNING, 
            UVM_DISPLAY | UVM_LOG);
          set_report_severity_action_hier(UVM_ERROR, 
            UVM_DISPLAY | UVM_LOG| UVM_COUNT);
          set_report_severity_action_hier(UVM_FATAL, 
            UVM_DISPLAY | UVM_LOG| UVM_EXIT);

          // Do the same for global reporter
          uvm_top.set_report_default_file(this.vw_log_f);
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
      local_m_rh = this.get_report_handler();
      local_m_rh.report_header(this.vw_log_f);
      */
    endfunction : new

function void go2uvm_base_test::build_phase (uvm_phase phase);
  super.build_phase (phase); 
endfunction : build_phase 


function void go2uvm_base_test::end_of_elaboration_phase (uvm_phase phase);
  super.end_of_elaboration_phase(phase); 
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
      "\n  You are using a version of the Go2UVM Package from VerifWorks \n"});
  vw_rel_str = $sformatf({vw_rel_str, "  See http://www.verifworks.com for more details \n"});
  vw_rel_str = $sformatf({vw_rel_str, "\n----------------------------------------------------------------\n"});


  `vw_uvm_info(log_id, $sformatf("RELNOTES \n%s", vw_rel_str), UVM_NONE)

endfunction : report_header 

