/* 
* Copyright (c) 2004-2017 VerifWorks, Bangalore, India
* http://www.verifworks.com 
* Contact: support@verifworks.com 
* 
* This program is part of Go2UVM at www.go2uvm.org
* Some portions of Go2UVM are free software.
* You can redistribute it and/or modify  
* it under the terms of the GNU Lesser General Public License as   
* published by the Free Software Foundation, version 3.
*
* VerifWorks reserves the right to obfuscate part or full of the code
* at any point in time. 
* We also support a comemrical licensing option for an enhanced version
* of Go2UVM, please contact us via support@verifworks.com

* This program is distributed in the hope that it will be useful, but 
* WITHOUT ANY WARRANTY; without even the implied warranty of 
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU 
* Lesser General Lesser Public License for more details.
*
* You should have received a copy of the GNU Lesser General Public License
* along with this program. If not, see <http://www.gnu.org/licenses/>.
*/


// Generating Go2UVM Test for WaveDrom file: waves.wd
// ---------------------------------------------------------
// Automatically generated from VerifWorks's DVCreate-Go2UVM product
// Thanks for using VerifWorks products, see http://www.verifworks.com for more
import uvm_pkg::*;
`include "vw_go2uvm_macros.svh"
// Import Go2UVM Package 
import vw_go2uvm_pkg::*;
// Use the base class provided by the vw_go2uvm_pkg
`G2U_TEST_BEGIN(vw_wd_g2u_test) 
  // Create a handle to the actual interface
  virtual vw_wd_g2u_if vif; 

  function void build_phase(uvm_phase phase); 
    if (!uvm_config_db#(virtual vw_wd_g2u_if)::get( 
      .cntxt(null), .inst_name("*"), 
      .field_name("vif"), .value(vif))) begin : no_vif
        `g2u_fatal("Unable to connect virtual interface to physical interface, check uvm_config_db::set in top module") 
    end : no_vif 
    else begin : vif_connected 
      `g2u_display("Successfully hooked up virtual interface") 
    end : vif_connected 
  endfunction : build_phase 

  task reset;
    `g2u_display (log_id, "Start of reset", UVM_MEDIUM)
    `g2u_display (log_id, "Fill in your reset logic here ", UVM_MEDIUM)
    // this.vif.cb.rst_n <= 1'b0;
    // repeat (5) @ (this.vif.cb);
    // this.vif.cb.rst_n <= 1'b1;
    // repeat (1) @ (this.vif.cb);
    `g2u_display (log_id, "End of reset", UVM_MEDIUM)
  endtask : reset
  task drive_vlb_wr_rd_valid(); 
    `g2u_display("Driving signal: vlb_wr_rd_valid") 
    vif.vlb_wr_rd_valid <= 1'bx;
    @(vif.cb);
    vif.vlb_wr_rd_valid <= 1'bx;
    @(vif.cb);
    vif.vlb_wr_rd_valid <= 0;
    @(vif.cb);
    vif.vlb_wr_rd_valid <= 1;
    @(vif.cb);
    vif.vlb_wr_rd_valid <= 1;
    @(vif.cb);
    vif.vlb_wr_rd_valid <= 1'bz;
    @(vif.cb);
    vif.vlb_wr_rd_valid <= 1'bx;
    @(vif.cb);
    `g2u_display("End of stimulus for signal: vlb_wr_rd_valid") 
  endtask : drive_vlb_wr_rd_valid 

  task drive_vlb_wr_rd(); 
    `g2u_display("Driving signal: vlb_wr_rd") 
    vif.vlb_wr_rd <= 0;
    @(vif.cb);
    vif.vlb_wr_rd <= 0;
    @(vif.cb);
    vif.vlb_wr_rd <= 1;
    @(vif.cb);
    vif.vlb_wr_rd <= 1;
    @(vif.cb);
    vif.vlb_wr_rd <= 1;
    @(vif.cb);
    vif.vlb_wr_rd <= 0;
    @(vif.cb);
    vif.vlb_wr_rd <= 0;
    @(vif.cb);
    `g2u_display("End of stimulus for signal: vlb_wr_rd") 
  endtask : drive_vlb_wr_rd 

  task main ();
    `g2u_display (log_id, "Start of main", UVM_MEDIUM)
    fork 
     drive_vlb_wr_rd_valid(); 
     drive_vlb_wr_rd(); 
    join 
    // this.vif.cb.inp_1 <= 1'b0;
    // this.vif.cb.inp_2 <= 22;
    // repeat (5) @ (this.vif.cb);
    `g2u_display (log_id, "End of main", UVM_MEDIUM)
  endtask : main
`G2U_TEST_END 
