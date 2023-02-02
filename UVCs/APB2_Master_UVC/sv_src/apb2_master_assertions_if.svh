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


`include "uvm_macros.svh"
import apb2_master_pkg::*; 
import vw_pip_pkg::*;

interface apb2_master_assertions_if (input logic pclk,
                                     input presetn,
                                     input pwrite,
                                     input penable,
                                     input [DATA_WIDTH-1:0] pwdata,
                                     input [ADDR_WIDTH-1:0] paddr,
                                     input [DATA_WIDTH-1:0] prdata,
                                     input pselx
                                    );

logic idle_state;
logic setup_state;
logic access_state;


assign idle_state = !pselx && !penable;
assign setup_state = pselx && !penable;
assign access_state = pselx && penable;

// Assert properties

//=======================================================================================

 default clocking clock @(posedge pclk); endclocking

 //======================================================================================

  //MASTER ASSERTIONS

 //======================================================================================

 // property : penable should appear exactly  one clock after psel
 property p_vw_psel_pen1 ; 
   disable iff(!presetn)
   (pselx && !penable) |=> penable; 
 endproperty : p_vw_psel_pen1

  a_p_vw_psel_pen1: assert property (p_vw_psel_pen1)

  `ifdef VW_PIP_SIM
     else 
       `uvm_error (vw_id,"p_vw_psel_pen1 : penable is not one after psel");
  `endif

  //=======================================================================================

  //property : paddr & pwrite should be stable during IDLE
  property p_vw_low_power ; 
    disable iff (!presetn)
    //( pre_state == IDLE ) |-> $stable (paddr);
    idle_state |-> $stable (paddr);
  endproperty : p_vw_low_power

  a_p_vw_low_power: assert property (p_vw_low_power )

  `ifdef VW_PIP_SIM
     else 
       `uvm_error (vw_id,"p_vw_low_power : paddr & pwrite is not stable");
  `endif

 //=======================================================================================
 //property : fsm can stay in active state for exactly one clock 

 property p_vw_active_one_clk ;  
   disable iff (!presetn)
   ##1 (pselx && penable) |=> ((pselx & !penable) || (!pselx && !penable));
 endproperty : p_vw_active_one_clk

  a_p_vw_active_one_clk: assert property ( p_vw_active_one_clk )

  `ifdef VW_PIP_SIM
     else
       `uvm_error(vw_id,"p_vw_active_one_clk : ENABLE state stayed morestable than one clock");		
  `endif

 //=======================================================================================
 //property : To ensure all pheripheral s/l are low when reset is low

 property p_vw_output_at_reset(out);
   ( !presetn ) |-> (out == 'b0);
 endproperty : p_vw_output_at_reset

 a_p_vw_rst_penable : assert property ( p_vw_output_at_reset(penable) )

  `ifdef VW_PIP_SIM
    else
      `uvm_error (vw_id,"p_vw_output_at_reset : penable is not low at reset");
  `endif

 a_p_vw_rst_pwrite : assert property ( p_vw_output_at_reset (pwrite) )

  `ifdef VW_PIP_SIM
    else
      `uvm_error (vw_id,"p_vw_output_at_reset : pwrite is not low at reset");
  `endif

 a_p_vw_rst_paddr : assert property ( p_vw_output_at_reset (paddr) )

  `ifdef VW_PIP_SIM
    else
      `uvm_error(vw_id,"p_vw_output_at_reset : paddr is not low at reset");
  `endif
 
 a_p_vw_rst_pwdata : assert property ( p_vw_output_at_reset (pwdata) )

  `ifdef VW_PIP_SIM
    else
      `uvm_error (vw_id,"p_vw_output_at_reset : pwdata is not low at reset");
  `endif


 //=======================================================================================
 //property : To ensure paddr,pwrite & pwdata to be hold b/w setup & enable state

 property p_vw_hold_from_setup_to_idle (hold); 
    disable iff (!presetn)
    access_state |=> $stable (hold);
 endproperty :  p_vw_hold_from_setup_to_idle

 a_p_vw_paddr: assert property ( p_vw_hold_from_setup_to_idle(paddr) )

  `ifdef VW_PIP_SIM
    else
      `uvm_error(vw_id,"p_vw_hold_from_setup_to_idle : paddr not holds");
  `endif

 a_p_vw_pwdata : assert property ( p_vw_hold_from_setup_to_idle(pwdata) )

  `ifdef VW_PIP_SIM
    else
      `uvm_error (vw_id,"p_vw_hold_from_setup_to_idle : pwdata not holds");
  `endif

 a_p_vw_pwrite : assert property ( p_vw_hold_from_setup_to_idle(pwrite) )

  `ifdef VW_PIP_SIM
    else
      `uvm_error (vw_id,"p_vw_hold_from_setup_to_idle : pwrite not holds");
  `endif

  //================================================================================

  //cvc added //
  // property //fsm can stay in enable state & setup state for only one clock
     
  property p_vw_setup_to_enable;	
    disable iff(!presetn)
    ##1 (penable) |=> !(penable); 	
  endproperty : p_vw_setup_to_enable
 
  a_p_vw_setup_to_enable : assert property (p_vw_setup_to_enable)

  `ifdef VW_PIP_SIM
    else
      `uvm_error (vw_id,"p_vw_setup_to_enable :setup to enable fails");
  `endif

 //================================================================================

  //SLAVE ASSERTIONS

 //================================================================================

  //property to ensure prdata is not an unknown value while read transfer

  `ifdef VW_PIP_SIM
    property p_vw_prdata_not_unknown_during_read;
      disable iff(!presetn)
      ((!presetn ##1 presetn) |-> !$isunknown( prdata));
    endproperty : p_vw_prdata_not_unknown_during_read

    a_p_vw_prdata_not_x_during_read : assert property ( p_vw_prdata_not_unknown_during_read )

    `ifdef VW_PIP_SIM
      else	
        `uvm_error (vw_id,"p_vw_prdata_not_unknown_during_read : prdata is invalid");
      `endif
    `endif //VW_PIP_SIM

  //================================================================================
  //To ensure rdata is low when reset is low

  property p_vw_prdata_at_reset;
    ( !presetn) |-> (prdata == 'd0);
  endproperty : p_vw_prdata_at_reset 

  a_p_vw_prdata_at_reset: assert property (p_vw_prdata_at_reset)

  `ifdef VW_PIP_SIM
    else	
      `uvm_error (vw_id,"p_vw_prdata_at_reset : prdata is not low at reset");
  `endif

  //================================================================================
 
endinterface : apb2_master_assertions_if
