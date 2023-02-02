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


task apb2_master_scoreboard::run_phase(uvm_phase phase);
  `g2u_display("Start of Run phase ..")
   forever
     begin
       this.in_afifo.get(trans);
       `g2u_display ("Found 1 xactn from monitor ",UVM_HIGH)
       trans.print();
       if(this.trans.kind==WR)
         begin:si_write
            apb_mem[trans.addr]=trans.data;
            if(imax<=trans.addr)
               imax=trans.addr;
         end:si_write
       if(this.trans.kind==RD)
         begin:si_rd
           for(i=0; i<=imax; i=i+1)
           begin:loop_1
             if(i==trans.addr )
               begin:read
                 k=1;
                 `g2u_printf (("Reading from written Address: 0x%0h", trans.addr))
                 if(apb_mem[i]==trans.data)
                   begin:if_1
                   `g2u_printf (("Data matches, result:PASS"))
                   pass_count++;
                 end:if_1
               else
                 begin :else_1
                  `uvm_error(get_name(),
                    $sformatf("Data does not match: addr: 0x%0h exp_data: 0x%0h act_data: 0x%0h", trans.addr, apb_mem[i], trans.data));
                   fail_count++;
                 end :else_1
               end:read
           end:loop_1	
           if(k==0)
             begin:invl 
               `uvm_warning(get_name(),$sformatf(":Reading from unwritten Address"));
               invl_count++;
             end:invl 
           k=0;
    end:si_rd
  end
endtask : run_phase
