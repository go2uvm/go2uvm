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


import uvm_pkg::*;
`include "uvm_macros.svh"
module  apb2_master_tb_dut_top();

`include "apb2_master_rand_test.svh"
`include "apb2_master_rand_test.sv"

//  parameter CLOCK_PERIOD = 10; // Assign clock Period 

  logic pclk;

  apb2_master_if apb2_master_if_0(.pclk (pclk) );//instantiate uvm interface

  vw_g2u_clk_gen #(.FREQUENCY_MHZ(125)) cgen_125
    (.clk(pclk));

    /*
 initial
  begin : cgen
    pclk = 0;
    forever #10 pclk <= ~pclk;
  end : cgen
*/

  //instantiate and connect dut to interface(s) here
  slave_apb DUT(.PCLK    (pclk),
                .PRESETn(apb2_master_if_0.presetn),
                .PSELx   (apb2_master_if_0.pselx),
                .PENABLE(apb2_master_if_0.penable),
                .PWRITE (apb2_master_if_0.pwrite),
                .PADDR  (apb2_master_if_0.paddr),
                .PWDATA (apb2_master_if_0.pwdata),
                .PRDATA (apb2_master_if_0.prdata)
               ); 
  initial
    begin
      uvm_config_db#(virtual apb2_master_if)::set(.cntxt(null),
                                           .inst_name("uvm_test_top.apb2_master_env.apb2_master_agent"),
                                           .field_name("apb2_master_if_0"),
                                           .value(apb2_master_if_0));

      run_test();
    end
endmodule
