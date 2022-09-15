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

 
 import uvm_pkg::*;
  `include "uvm_macros.svh"

  import vlb_regs_pkg::*;

   //--------------------------------------------------------------------
   // vl_data
   //--------------------------------------------------------------------
   class vl_data extends uvm_reg;
      `uvm_object_utils(vl_data)

      rand uvm_reg_field data;

      //--------------------------------------------------------------------
      // new
      //--------------------------------------------------------------------
      function new(string name = "vl_data");
         super.new(name, 32, UVM_NO_COVERAGE);
      endfunction

      //--------------------------------------------------------------------
      // build
      //--------------------------------------------------------------------
      virtual function void build();
         this.data = uvm_reg_field::type_id::create("data");
         this.data.configure(this, 32, 0, "RW", 0, 0, 1, 1, 1);
      endfunction : build
   endclass : vl_data
 
   //--------------------------------------------------------------------
   // vl_ctrl
   //--------------------------------------------------------------------
   class vl_ctrl extends uvm_reg;
      `uvm_object_utils(vl_ctrl)

      rand uvm_reg_field ctrl;

      //--------------------------------------------------------------------
      // new
      //--------------------------------------------------------------------
      function new(string name = "vl_ctrl");
         super.new(name, 32, UVM_NO_COVERAGE);
      endfunction

      //--------------------------------------------------------------------
      // build
      //--------------------------------------------------------------------
      virtual function void build();
         this.ctrl = uvm_reg_field::type_id::create("ctrl");
         this.ctrl.configure(this, 32, 0, "RW", 0, 0, 1, 1, 1);
      endfunction : build
   endclass : vl_ctrl
 
   //--------------------------------------------------------------------
   // vl_volatile
   //--------------------------------------------------------------------
   class vl_volatile extends uvm_reg;
      `uvm_object_utils(vl_volatile)

      uvm_reg_field cntr;

      //--------------------------------------------------------------------
      // new
      //--------------------------------------------------------------------
      function new(string name = "vl_volatile");
         super.new(name, 32, UVM_NO_COVERAGE);
      endfunction

      //--------------------------------------------------------------------
      // build
      //--------------------------------------------------------------------
      virtual function void build();
         this.cntr = uvm_reg_field::type_id::create("cntr");
         this.cntr.configure(.parent(this), .size(32), 
                             .lsb_pos(0), 
                             .access("RO"), 
                             .volatile(1), 
                             .reset(VLB_VOL_RST_VAL), 
                             .has_reset(1), .is_rand(0), 
                             .individually_accessible(1));
      endfunction : build
   endclass : vl_volatile
 


  /* REGISTER MAP */
   //-------------------------------------------------------------------
   // vlb_reg_block
   //--------------------------------------------------------------------
   class vlb_reg_block extends uvm_reg_block;
      `uvm_object_utils(vlb_reg_block)

      rand vl_data vl_data_reg;
      rand vl_ctrl vl_ctrl_reg;
      vl_volatile vl_volatile_reg;

      uvm_reg_map vlb_map; // Block map


      //--------------------------------------------------------------------
      // new
      //--------------------------------------------------------------------
      function new(string name = "vlb_reg_block");
         super.new(name, build_coverage(UVM_CVR_ADDR_MAP));
      endfunction

      //--------------------------------------------------------------------
      // build
      //--------------------------------------------------------------------
      virtual function void build();
         string s;

         if(has_coverage(UVM_CVR_ADDR_MAP)) begin
           void'(set_coverage(UVM_CVR_ADDR_MAP));
         end

         
         vl_data_reg = vl_data::type_id::create("vl_data");
         vl_data_reg.configure(this, null, "");
         vl_data_reg.build();	 
         vl_data_reg.add_hdl_path_slice("vl_data", 0, 32);

         vl_ctrl_reg = vl_ctrl::type_id::create("vl_ctrl");
         vl_ctrl_reg.configure(this, null, "");
         vl_ctrl_reg.build();	 
         vl_ctrl_reg.add_hdl_path_slice("vl_ctrl", 0, 32);

         vl_volatile_reg = vl_volatile::type_id::create("vl_volatile");
         vl_volatile_reg.configure(this, null, "");
         vl_volatile_reg.build();	 
         vl_volatile_reg.add_hdl_path_slice("vl_volatile", 0, 32);


         vlb_map = create_map("vlb_map", 'h0, 4, UVM_LITTLE_ENDIAN);

         vlb_map.add_reg(vl_volatile_reg, VLB_VOLATILE_REG_ADDR, "RO");
         vlb_map.add_reg(vl_data_reg, VLB_DATA_REG_ADDR, "RW");
         vlb_map.add_reg(vl_ctrl_reg, VLB_CTRL_REG_ADDR, "RW");
         add_hdl_path("top.dut", "RTL");


         lock_model();
      endfunction : build


   endclass



