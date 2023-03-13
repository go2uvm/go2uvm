////////////////////////////////////////////////////////////
// ========== Copyright Header Begin =======================
// 
// Project: IVL_UVM
// File: ivl_uvm_types.svh
// Author(s): Srinivasan Venkataramanan 
// Modified from Accellera UVM 1.1d code base
//
// Copyright (c) VerifWorks, CVC, AsFigo 2016-2023 
// All Rights Reserved.
// Contact us via: support@verifworks.com
// 
////////////////////////////////////////////////////////////
//
//----------------------------------------------------------
//   Copyright 2007-2011 Mentor Graphics Corporation
//   Copyright 2007-2010 Cadence Design Systems, Inc. 
//   Copyright 2010 Synopsys, Inc.
//   All Rights Reserved Worldwide
//
//   Licensed under the Apache License, Version 2.0 (the
//   "License"); you may not use this file except in
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
//----------------------------------------------------------
// ========== Copyright Header End =========================


`ifndef __GO2UVM_VERILATOR_UVM_LITE__
`define __GO2UVM_VERILATOR_UVM_LITE__
  `define IVL_UVM_PKG

  `define IVL_UVM
  `define UVM_CMDLINE_NO_DPI
`timescale 1ns/1ns


package uvm_pkg;
  `include "base/uvm_object_globals.svh"



int uvm_info_counter;
int uvm_warn_counter;
int uvm_err_counter;
int uvm_fatal_counter;
int ivl_uvm_glb_verb;
bit report_summarize_done;

time ivl_uvm_glb_timeout;
int unsigned ivl_uvm_max_quit_count = '1;

string log_id = "IVL_GO2UVM";


  function int uvm_report_enabled(int verbosity, 
                          uvm_severity severity=UVM_INFO, string id="");
    if (get_report_verbosity_level(severity, id) < verbosity) begin
        // get_report_action(severity,id) == uvm_action'(UVM_NO_ACTION))  */
      return 0;
    end else begin
      return 1;
    end
  endfunction : uvm_report_enabled

  function void m_check_verbosity();
    string verb_string;
    int verb_count;
    int plusarg;
    int verbosity;

    verbosity = 10;

    verb_count = $value$plusargs("UVM_VERBOSITY=%s", verb_string);
    
   
    verbosity = int'(UVM_MEDIUM);

    if (verb_count) begin

      if (verb_string == "UVM_NONE" || verb_string == "NONE") begin
        verbosity = int'(UVM_NONE);
      end

      if (verb_string == "UVM_LOW" || verb_string == "LOW") begin
        verbosity = int'(UVM_LOW);
      end

      if (verb_string == "UVM_MEDIUM" || verb_string == "MEDIUM") begin
        verbosity = int'(UVM_MEDIUM);
      end

      if (verb_string == "UVM_HIGH" || verb_string == "HIGH") begin
        verbosity = int'(UVM_HIGH);
      end

      if (verb_string == "UVM_FULL" || verb_string == "FULL") begin
        verbosity = int'(UVM_FULL);
      end

      if (verb_string == "UVM_DEBUG" || verb_string == "DEBUG") begin
        verbosity = int'(UVM_DEBUG);
      end



  /*
      case(verb_string)
        "UVM_NONE"    : verbosity = UVM_NONE;
        "NONE"        : verbosity = UVM_NONE;
        "UVM_LOW"     : verbosity = UVM_LOW;
        "LOW"         : verbosity = UVM_LOW;
        "UVM_MEDIUM"  : verbosity = UVM_MEDIUM;
        "MEDIUM"      : verbosity = UVM_MEDIUM;
        "UVM_HIGH"    : verbosity = UVM_HIGH;
        "HIGH"        : verbosity = UVM_HIGH;
        "UVM_FULL"    : verbosity = UVM_FULL;
        "FULL"        : verbosity = UVM_FULL;
        "UVM_DEBUG"   : verbosity = UVM_DEBUG;
        "DEBUG"       : verbosity = UVM_DEBUG;
        default       : verbosity = UVM_MEDIUM;
      endcase
  */
    end

    ivl_uvm_glb_verb = verbosity;
  endfunction : m_check_verbosity

  // Function: get_report_verbosity_level
  //
  // Gets the verbosity level in effect for this object. Reports issued
  // with verbosity greater than this will be filtered out. The severity
  // and tag arguments check if the verbosity level has been modified for
  // specific severity/tag combinations.

  function int get_report_verbosity_level(uvm_severity severity=UVM_INFO, string id="");
    m_check_verbosity ();
    return ivl_uvm_glb_verb;
  endfunction : get_report_verbosity_level


  function string get_name ();
    return "IVL_GO2UVM";
  endfunction : get_name 

  typedef class uvm_report_object;

  class uvm_object_wrapper;
  endclass : uvm_object_wrapper
  
  class uvm_objection;
  endclass
  class uvm_printer;
  endclass
  class uvm_recorder;
  endclass
  class uvm_comparer;
  endclass
  class uvm_packer;
  endclass
  class uvm_copy_map;
  endclass
  
  // typedef bit uvm_bitstream_t;
  
  class uvm_status_container;
  endclass : uvm_status_container
  function void uvm_count_info();
    uvm_info_counter++;
  endfunction : uvm_count_info

  function void uvm_count_warn();
    uvm_warn_counter++;
  endfunction : uvm_count_warn

  function void uvm_count_err();
    uvm_err_counter++;
			// For debug $display ("UVM_MAX_QUIT_COUNT: %0d cur_num_err: %0d ",  ivl_uvm_max_quit_count, uvm_err_counter);
		if (uvm_err_counter >= ivl_uvm_max_quit_count) begin
      $display ( "%c[1;31m",27 ) ; // RED color
			$display ("Reached UVM_MAX_QUIT_COUNT: %0d cur_num_err: %0d, ending simulation",  ivl_uvm_max_quit_count, uvm_err_counter);
      $display ( "%c[0m",27 ) ;
      report_summarize ();
			$finish (2);
		end
  endfunction : uvm_count_err

  function void uvm_count_fatal();
    uvm_fatal_counter++;
  endfunction : uvm_count_fatal


  function void report_summarize ();
    int num_errs;

    if (!report_summarize_done) begin : do_it_only_once
      report_summarize_done = 1;
      $display("");
      $display("--- UVM Report Summary ---");
      $display("");
      $display("** Report counts by severity");
      $display ("UVM_INFO : %0d", uvm_info_counter);
      $display ("UVM_WARNING : %0d", uvm_warn_counter);
      $display ("UVM_ERROR : %0d", uvm_err_counter);
      $display ("UVM_FATAL : %0d", uvm_fatal_counter);
  
      num_errs = uvm_err_counter;
  
      if(num_errs > 0) begin : fail
        $display ( "%c[1;31m",27 ) ; // RED color
        $display ("Test FAILED with %0d error(s), look for UVM_ERROR in log file",
                   num_errs);
        $display ( "%c[0m",27 ) ;
      end : fail
      else begin : pass
        $display ( "%c[5;34m",27 ) ; // BLUE color
        $display ( "*** Congratulations! Test PASSED with NO UVM_ERRORs ***" ) ;
        $display ( "%c[0m",27 ) ;
      end : pass
  
      $display ("Thanks for using IVL_UVM Package");
    end : do_it_only_once

  endfunction : report_summarize

  function void uvm_report_info( string id,
                                  string message,
                                  int verbosity,
                                  string filename = "",
                                  int line = 0);
    string msg_str;

    `ifndef IVL_UVM 
        m_rh.report(UVM_INFO, get_full_name(), id, message, verbosity,
                filename, line, this);
    `else
      msg_str = ivl_uvm_compose_message(UVM_INFO, id, message, filename, line); 
      uvm_count_info(); 
      $display (msg_str);
    `endif // IVL_UVM 

  endfunction : uvm_report_info
  // Function: uvm_report_warning

  function void uvm_report_warning( string id,
                                            string message,
                                            int verbosity = UVM_MEDIUM,
                                            string filename = "",
                                            int line = 0);

    string msg_str;
    `ifndef IVL_UVM 
      m_rh.report(UVM_WARNING, get_full_name(), id, message, verbosity, 
                 filename, line, this);
    `else
      msg_str = ivl_uvm_compose_message(UVM_WARNING, id, message, filename, line); 
      uvm_count_warn(); 
      $display (msg_str);
    `endif // IVL_UVM 


  endfunction

  // Function: uvm_report_error

  function void uvm_report_error( string id,
                                          string message,
                                          int verbosity = UVM_LOW,
                                          string filename = "",
                                          int line = 0);
    string msg_str;
    `ifndef IVL_UVM 
      m_rh.report(UVM_ERROR, get_full_name(), id, message, verbosity, 
                 filename, line, this);
    `else
      msg_str = ivl_uvm_compose_message(UVM_ERROR, id, message, filename, line); 
      uvm_count_err (); 
      $display (msg_str);
    `endif // IVL_UVM 

  endfunction

  // Function: uvm_report_fatal
  //
  // These are the primary reporting methods in the UVM. Using these instead
  // of ~$display~ and other ad hoc approaches ensures consistent output and
  // central control over where output is directed and any actions that
  // result. All reporting methods have the same arguments, although each has
  // a different default verbosity:
  //
  //   id        - a unique id for the report or report group that can be used
  //               for identification and therefore targeted filtering. You can
  //               configure an individual report's actions and output file(s)
  //               using this id string.
  //
  //   message   - the message body, preformatted if necessary to a single
  //               string.
  //
  //   verbosity - the verbosity of the message, indicating its relative
  //               importance. If this number is less than or equal to the
  //               effective verbosity level, see <set_report_verbosity_level>,
  //               then the report is issued, subject to the configured action
  //               and file descriptor settings.  Verbosity is ignored for 
  //               warnings, errors, and fatals. However, if a warning, error
  //               or fatal is demoted to an info message using the
  //               <uvm_report_catcher>, then the verbosity is taken into
  //               account.
  //
  //   filename/line - (Optional) The location from which the report was issued.
  //               Use the predefined macros, `__FILE__ and `__LINE__.
  //               If specified, it is displayed in the output.

  function void uvm_report_fatal( string id,
                                          string message,
                                          int verbosity = UVM_NONE,
                                          string filename = "",
                                          int line = 0);
    string msg_str;
    `ifndef IVL_UVM 
      m_rh.report(UVM_FATAL, get_full_name(), id, message, verbosity, 
                 filename, line, this);
    `else
      msg_str = ivl_uvm_compose_message(UVM_FATAL, id, message, filename, line); 
      uvm_count_fatal (); 
      $display (msg_str);
      report_summarize ();
      $finish (2);
    `endif // IVL_UVM 

  endfunction : uvm_report_fatal

  function string get_uvm_severity_type_str (uvm_severity severity);
    string res;

    case (severity)
      0 : res = "UVM_INFO";
      1 : res = "UVM_WARNING";
      2 : res = "UVM_ERROR";
      3 : res = "UVM_FATAL";
    endcase 
    return (res);
  endfunction : get_uvm_severity_type_str 

  
function string ivl_uvm_compose_message(
      uvm_severity severity,
      string id,
      string message,
      string filename,
      int    line
      );
    string sv;
    string time_str;
    string line_str;
    string name;

    
    // sv = uvm_severity_type'(severity);
    sv = get_uvm_severity_type_str (severity);
    $swrite(time_str, "%0t", $realtime);
 
    case(1)
      (name == "" && filename == ""):
	       return {sv, " @ ", time_str, " [", id, "] ", message};
      (name != "" && filename == ""):
	       return {sv, " @ ", time_str, ": ", name, " [", id, "] ", message};
      (name == "" && filename != ""):
           begin
               $swrite(line_str, "%0d", line);
		 return {sv, " ",filename, "(", line_str, ")", " @ ", time_str, " [", id, "] ", message};
           end
      (name != "" && filename != ""):
           begin
               $swrite(line_str, "%0d", line);
	         return {sv, " ", filename, "(", line_str, ")", " @ ", time_str, ": ", name, " [", id, "] ", message};
           end
    endcase
  endfunction : ivl_uvm_compose_message

`define IVL_UVM_REF 

endpackage : uvm_pkg
import uvm_pkg::*;

`include "uvm_macros.svh"

`endif // __GO2UVM_VERILATOR_UVM_LITE__
