// Copyright (c) 2004-2017 VerifWorks, Bangalore, India
// http://www.verifworks.com 
// Contact: support@verifworks.com 
// 
// This program is part of Go2UVM at www.go2uvm.org
// Some portions of Go2UVM are free software.
// You can redistribute it and/or modify  
// it under the terms of the GNU Lesser General Public License as   
// published by the Free Software Foundation, version 3.
//
// VerifWorks reserves the right to obfuscate part or full of the code
// at any point in time. 
// We also support a comemrical licensing option for an enhanced version
// of Go2UVM, please contact us via support@verifworks.com
//
// This program is distributed in the hope that it will be useful, but 
// WITHOUT ANY WARRANTY; without even the implied warranty of 
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU 
// Lesser General Lesser Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public License
// along with this program. If not, see <http://www.gnu.org/licenses/>.

module vlb_g2u_tb_dut_top();

`include "vlb_g2u_inc.svh"
// `include "vlb_g2u_testlist.svi"

//  parameter CLOCK_PERIOD = 10; // Assign clock Period 

  logic clk;

  vlb_g2u_if vlb_g2u_if_0(.clk (clk) ); //instantiate uvc interface
// SPDIF recevier in 32bit mode with two capture registers
   rx_spdif 
      # (32,
         8,            // 128 byte sample buffer
         2,            // two capture regs.
         33)           // 33 MHz
      rx_spdif_dut_0(
         .wb_clk_i   => wb_clk_o,
         .wb_rst_i   => wb_rst_o,
         .wb_sel_i   => wb_sel_o,
         .wb_stb_i   => wb_stb_32bit_rx,
         .wb_we_i    => wb_we_o,
         .wb_cyc_i   => wb_cyc_o,
         .wb_bte_i   => wb_bte_o,
         .wb_cti_i   => wb_cti_o,
         .wb_adr_i   => wb_adr_o(7 downto 0),
         .wb_dat_i   => wb_dat_o(31 downto 0),
         .wb_ack_o   => rx_ack,
         .wb_dat_o   => rx_dat_i,
         .rx_int_o   => rx_int_o);


 initial
  begin : cgen
    clk = 0;
    forever #10 clk <= ~clk; 
  end : cgen

  //instantiate and connect dut to interface(s) here
  
  initial
    begin
      uvm_config_db#(virtual vlb_g2u_if)::set(.cntxt(null),
                                          .inst_name("uvm_test_top.vlb_g2u_env_0.vlb_g2u_agent_0"),
                                          .field_name("vif"),
                                          .value(vlb_g2u_if_0));
    
      run_test();
    end
endmodule
