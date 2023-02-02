/* 
* Copyright (c) 2004-2023 CVC, VerifWorks, London-UK & Bangalore, India
* http://www.verifworks.com 
* Contact: support@verifworks.com 
* 
* This program is part of Go2UVM at https://github.com/go2uvm/go2uvm
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


`ifndef G2U_APB2_MASTER_PKG__
`define G2U_APB2_MASTER_PKG__

import uvm_pkg::*;
`include "uvm_macros.svh"

import vw_go2uvm_pkg::*;
`include "vw_go2uvm_macros.svh"

package apb2_master_pkg;

  parameter ADDR_WIDTH = 8;
  parameter DATA_WIDTH = 8;
  typedef enum { RD, WR } apb_kind_e;

  
  // Headers/prototypes
  `include "apb2_master_xactn.svh" 
  `include "apb2_master_sequencer.svh" 
  `include "apb2_master_input_monitor.svh" 
  //`include "apb2_master_output_monitor.svh"
  //`include "apb2_master_fcov.svh"
  `include "apb2_master_scoreboard.svh"
  `include "apb2_master_driver.svh"
  `include "apb2_master_agent.svh"
  `include "apb2_master_env.svh"
  `include "apb2_master_base_test.svh" 

  // Implementation
  `include "apb2_master_input_monitor.sv" 
  //`include "apb2_master_output_monitor.sv"
  //`include "apb2_master_fcov.sv"
  `include "apb2_master_scoreboard.sv"
  `include "apb2_master_driver.sv"
  `include "apb2_master_agent.sv"
  `include "apb2_master_env.sv"
  `include "apb2_master_seq_lib.sv"
  `include "apb2_master_base_test.sv" 

endpackage : apb2_master_pkg
`endif //  G2U_APB2_MASTER_PKG__

