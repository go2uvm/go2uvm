module vw_go2uvm_sim_utils;

time sim_end_t;

final begin : end_f
  chk_premature_eot ();
  report_summarize ();
end : end_f

function void chk_premature_eot();
  sim_end_t = $time;
  if (!(sim_end_t > 0) ) begin : zero_time_end
    `uvm_error ("GO2UVM", 
      "Pre-mature end-of-sim at 0 time, ensure there are some objections raised and re-run");
  end : zero_time_end
endfunction : chk_premature_eot

`ifndef VERILATOR
function void report_summarize ();
  uvm_report_server srvr;           
  int vw_num_errs;

  srvr = uvm_coreservice_t::get().get_report_server();
  vw_num_errs = srvr.get_severity_count(UVM_FATAL);
  vw_num_errs += srvr.get_severity_count(UVM_ERROR);

  if(vw_num_errs > 0) begin : fail
    $display ( "%c[1;31m",27 ) ; // RED color
    $display ("Test FAILED with %0d error(s), look for UVM_ERROR in log file",
      vw_num_errs);
    $display ( "%c[0m",27 ) ;

  end : fail

  else begin : pass
    $display ( "%c[5;32m",27 ) ; // GREEN color
    $display ( "*** Congratulations! Test PASSED with NO UVM_ERRORs ***" ) ;
    $display ( "This test-seed run achieved %3.2f%% functional coverage", 
     $get_coverage());
    $display ( "%c[0m",27 ) ;
  end : pass

  `uvm_info ("GO2UVM", 
    "Thanks for using VerifWorks's Go2UVM Package, provide your feedback at http://www.verifworks.com",
    UVM_NONE)
  endfunction : report_summarize
`endif // VERILATOR

endmodule : vw_go2uvm_sim_utils

