  function void apb2_master_agent::build_phase(uvm_phase phase);
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



    super.build_phase(.phase(phase));
    if(!uvm_config_db#(uvm_active_passive_enum)::get
         (.cntxt(this),
          .inst_name(""),
          .field_name("is_active"),
          .value(this.is_active))) begin : def_val_for_is_active
            `uvm_warning(get_name,$sformatf("No override for is_active: Using default is_active as: %s ",
                                        this.is_active.name));
       end : def_val_for_is_active



      `g2u_printf(("is_active is set to %s",this.is_active.name()))

       apb2_master_input_monitor_0=apb2_master_input_monitor::type_id::create(.name("apb2_master_input_monitor"), .parent(this));
//       apb2_master_output_monitor_0=apb2_master_output_monitor::type_id::create(.name("apb2_master_output_monitor"), .parent(this));

       apb2_master_scoreboard_0 = apb2_master_scoreboard::type_id::create(.name("apb2_master_scoreboard"), .parent(this));
//       apb2_master_fcov_0 = apb2_master_fcov::type_id::create(.name("apb2_master_fcov"), .parent(this));

       if (this.is_active == UVM_ACTIVE)
        begin
           apb2_master_driver_0=apb2_master_driver::type_id::create(.name("apb2_master_driver"), .parent(this));
           apb2_master_sequencer_0=apb2_master_sequencer::type_id::create(.name("apb2_master_sequencer"), .parent(this));
        end
  endfunction : build_phase

  function void apb2_master_agent::connect_phase(uvm_phase phase);

    if(!uvm_config_db#(virtual apb2_master_if)::get(this,
                                             "",
                                             "apb2_master_if_0",
                                             this.apb2_master_if_0))
        begin:no_vif
         `uvm_fatal("get_interface","no virtual interface available");
        end:no_vif
      else
        begin:vi_assigned
           `g2u_printf(("virtual interface connected"))
        end:vi_assigned


    apb2_master_input_monitor_0.vif = this.apb2_master_if_0;
//    apb2_master_output_monitor_0.vif = this.apb2_master_if_0;

    if (this.is_active == UVM_ACTIVE)
      begin
        this.apb2_master_driver_0.seq_item_port.connect(apb2_master_sequencer_0.seq_item_export);
        this.apb2_master_driver_0.vif = this.apb2_master_if_0;
      end

        this.apb2_master_input_monitor_0.in_aport.connect(this.apb2_master_scoreboard_0.in_afifo.analysis_export);
//        this.apb2_master_output_monitor_0.out_aport.connect(this.apb2_master_scoreboard_0.out_afifo.analysis_export);
//        this.apb2_master_output_monitor_0.out_aport.connect(this.apb2_master_fcov_0.analysis_export);

endfunction : connect_phase
