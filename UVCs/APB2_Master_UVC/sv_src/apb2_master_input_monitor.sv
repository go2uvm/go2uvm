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


task apb2_master_input_monitor::run_phase(uvm_phase phase);
  `g2u_display("Run Phase is Running ..",UVM_HIGH)
  begin:main
    `g2u_display(":Running ..")
    forever
      begin:loop_1
        @(this.vif.apb_monitor_cb);
        wait(this.vif.apb_monitor_cb.penable == 1'b1)
        x0 = apb2_master_xactn::type_id::create(.name("x0"),.parent(this));
        if(this.vif.apb_monitor_cb.pwrite == 1'b1)
          begin:write
            this.x0.kind = WR;
            this.x0.addr = this.vif.apb_monitor_cb.paddr;
            this.x0.data = this.vif.apb_monitor_cb.pwdata;
            `g2u_printf(("MONITOR_WRITE: %s", x0.sprint))
            this.in_aport.write(x0);
            @ ( this.vif.apb_monitor_cb );
            @ ( this.vif.apb_monitor_cb );
          end:write
        else  
          begin:read
            this.x0.kind = RD;
            this.x0.addr = this.vif.apb_monitor_cb.paddr;
            @ ( this.vif.apb_monitor_cb );
            @ ( this.vif.apb_monitor_cb );
            this.x0.data = this.vif.apb_monitor_cb.prdata;
            this.in_aport.write(x0);
            //writing to Analysis port
            `g2u_printf(("MONITOR_READ: %s", x0.sprint))
          end:read
      end:loop_1
  end:main

//  collect_data(); 
endtask : run_phase 
 
//task apb2_master_input_monitor::collect_data();
//endtask : collect_data
