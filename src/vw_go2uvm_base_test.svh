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




virtual class go2uvm_base_test extends uvm_test;
  `ifdef INCA
  timeunit 1ns;
  timeprecision 1ns;
  `endif // INCA

    string vw_run_log_fname = "vw_go2uvm_run.log";
    UVM_FILE vw_log_f;
    string log_id;

    extern function new (string name = "go2uvm_test", 
                         uvm_component parent = null);
    extern virtual function void build_phase (uvm_phase phase);
    extern virtual function void end_of_elaboration_phase (uvm_phase phase);
    extern virtual task reset_phase (uvm_phase phase);
    extern virtual task reset ();
    extern virtual task main_phase (uvm_phase phase);
    pure virtual task main ();
    extern virtual function void report_header (UVM_FILE file = 0 );

endclass : go2uvm_base_test
  
