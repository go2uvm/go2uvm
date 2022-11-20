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



package spdif_pkg_uvm;
   import uvm_pkg::*;

   `include "uvm_macros.svh"

  class SPDIF_Rx_Version_reg extends uvm_reg;
      `uvm_object_utils (SPDIF_Rx_Version_reg)

      rand uvm_reg_field Unused1;
      rand uvm_reg_field CAPNO;
      rand uvm_reg_field Unused2;
      rand uvm_reg_field ADRW;
      rand uvm_reg_field DATW;
      rand uvm_reg_field VER;

      function new(string name = "SPDIF_Rx_Version_reg");
         super.new(name,32,UVM_NO_COVERAGE);
      endfunction : new

      virtual function void build();

         this.Unused1 = uvm_reg_field::type_id::create("Unused1");
         this.CAPNO = uvm_reg_field::type_id::create("CAPNO");
         this.Unused2 = uvm_reg_field::type_id::create("Unused2");
         this.ADRW = uvm_reg_field::type_id::create("ADRW");
         this.DATW = uvm_reg_field::type_id::create("DATW");
         this.VER = uvm_reg_field::type_id::create("VER");
         this.Unused1.configure (this, 12,20,"RO",0,12'b000000000000,0,1,1);
         this.CAPNO.configure (this, 4,16,"RO",0,16'b0000000000000000,0,1,1);
         this.Unused2.configure (this, 4,12,"RO",0,4'b0000,0,1,1);
         this.ADRW.configure (this, 7,5,"RO",0,7'b0000000,0,1,1);
         this.DATW.configure (this, 1,4,"RO",0,1'b0,0,1,1);
         this.VER.configure (this, 4,0,"RO",0,4'b0000,0,1,1);
      endfunction : build
   endclass



  class SPDIF_Rx_Config_reg extends uvm_reg;
      `uvm_object_utils (SPDIF_Rx_Config_reg)

      rand uvm_reg_field Unused1;
      rand uvm_reg_field BLKEN;
      rand uvm_reg_field MODE;
      rand uvm_reg_field PAREN;
      rand uvm_reg_field STATEN;
      rand uvm_reg_field USEREN;
      rand uvm_reg_field VALEN;
      rand uvm_reg_field Unused2;
      rand uvm_reg_field VALID;
      rand uvm_reg_field CHAS;
      rand uvm_reg_field RINTEN;
      rand uvm_reg_field SAMPLE;
      rand uvm_reg_field RXEN;

      function new(string name = "SPDIF_Rx_Config_reg");
         super.new(name,32,UVM_NO_COVERAGE);
      endfunction : new

      virtual function void build();

         this.Unused1 = uvm_reg_field::type_id::create("Unused1");
         this.BLKEN = uvm_reg_field::type_id::create("BLKEN");
         this.MODE = uvm_reg_field::type_id::create("MODE");
         this.PAREN = uvm_reg_field::type_id::create("PAREN");
         this.STATEN = uvm_reg_field::type_id::create("STATEN");
         this.USEREN = uvm_reg_field::type_id::create("USEREN");
         this.VALEN = uvm_reg_field::type_id::create("VALEN");
         this.Unused2 = uvm_reg_field::type_id::create("Unused2");
         this.VALID = uvm_reg_field::type_id::create("VALID");
         this.CHAS = uvm_reg_field::type_id::create("CHAS");
         this.RINTEN = uvm_reg_field::type_id::create("RINTEN");
         this.SAMPLE = uvm_reg_field::type_id::create("SAMPLE");
         this.RXEN = uvm_reg_field::type_id::create("RXEN");
         this.Unused1.configure (this, 7,25,"RO",0,7'b0000000,0,1,1);
         this.BLKEN.configure (this, 1,24,"RW",0,1'b0,0,1,1);
         this.MODE.configure (this, 4,20,"RW",0,4'b0000,0,1,1);
         this.PAREN.configure (this, 1,19,"RW",0,1'b0,0,1,1);
         this.STATEN.configure (this, 1,18,"RW",0,1'b0,0,1,1);
         this.USEREN.configure (this, 1,17,"RW",0,1'b0,0,1,1);
         this.VALEN.configure (this, 1,16,"RW",0,1'b0,0,1,1);
         this.Unused2.configure (this, 11,5,"RO",0,11'b00000000000,0,1,1);
         this.VALID.configure (this, 1,4,"RW",0,1'b0,0,1,1);
         this.CHAS.configure (this, 1,3,"RW",0,1'b0,0,1,1);
         this.RINTEN.configure (this, 1,2,"RW",0,1'b0,0,1,1);
         this.SAMPLE.configure (this, 1,1,"RW",0,1'b0,0,1,1);
         this.RXEN.configure (this, 1,0,"RW",0,1'b0,0,1,1);
      endfunction : build
   endclass



  class SPDIF_Rx_Status_reg extends uvm_reg;
      `uvm_object_utils (SPDIF_Rx_Status_reg)

      rand uvm_reg_field Unused1;
      rand uvm_reg_field Unused2;
      rand uvm_reg_field COPY;
      rand uvm_reg_field EMPH;
      rand uvm_reg_field AUDIO;
      rand uvm_reg_field PRO;
      rand uvm_reg_field LOCK;

      function new(string name = "SPDIF_Rx_Status_reg");
         super.new(name,32,UVM_NO_COVERAGE);
      endfunction : new

      virtual function void build();

         this.Unused1 = uvm_reg_field::type_id::create("Unused1");
         this.Unused2 = uvm_reg_field::type_id::create("Unused2");
         this.COPY = uvm_reg_field::type_id::create("COPY");
         this.EMPH = uvm_reg_field::type_id::create("EMPH");
         this.AUDIO = uvm_reg_field::type_id::create("AUDIO");
         this.PRO = uvm_reg_field::type_id::create("PRO");
         this.LOCK = uvm_reg_field::type_id::create("LOCK");
         this.Unused1.configure (this, 16,16,"RO",0,16'b0000000000000000,0,1,1);
         this.Unused2.configure (this, 9,7,"RO",0,9'b000000000,0,1,1);
         this.COPY.configure (this, 1,6,"RO",0,1'b0,0,1,1);
         this.EMPH.configure (this, 3,3,"RO",0,3'b000,0,1,1);
         this.AUDIO.configure (this, 1,2,"RO",0,1'b0,0,1,1);
         this.PRO.configure (this, 1,1,"RO",0,1'b0,0,1,1);
         this.LOCK.configure (this, 1,0,"RO",0,1'b0,0,1,1);
      endfunction : build
   endclass



  class SPDIF_Rx_Int_Mask_reg extends uvm_reg;
      `uvm_object_utils (SPDIF_Rx_Int_Mask_reg)

      rand uvm_reg_field Unused1;
      rand uvm_reg_field CAP7;
      rand uvm_reg_field CAP6;
      rand uvm_reg_field CAP5;
      rand uvm_reg_field CAP4;
      rand uvm_reg_field CAP3;
      rand uvm_reg_field CAP2;
      rand uvm_reg_field CAP1;
      rand uvm_reg_field CAP0;
      rand uvm_reg_field Unused2;
      rand uvm_reg_field PARITYB;
      rand uvm_reg_field PARITYA;
      rand uvm_reg_field HSBF;
      rand uvm_reg_field LSBF;
      rand uvm_reg_field LOCK;

      function new(string name = "SPDIF_Rx_Int_Mask_reg");
         super.new(name,32,UVM_NO_COVERAGE);
      endfunction : new

      virtual function void build();

         this.Unused1 = uvm_reg_field::type_id::create("Unused1");
         this.CAP7 = uvm_reg_field::type_id::create("CAP7");
         this.CAP6 = uvm_reg_field::type_id::create("CAP6");
         this.CAP5 = uvm_reg_field::type_id::create("CAP5");
         this.CAP4 = uvm_reg_field::type_id::create("CAP4");
         this.CAP3 = uvm_reg_field::type_id::create("CAP3");
         this.CAP2 = uvm_reg_field::type_id::create("CAP2");
         this.CAP1 = uvm_reg_field::type_id::create("CAP1");
         this.CAP0 = uvm_reg_field::type_id::create("CAP0");
         this.Unused2 = uvm_reg_field::type_id::create("Unused2");
         this.PARITYB = uvm_reg_field::type_id::create("PARITYB");
         this.PARITYA = uvm_reg_field::type_id::create("PARITYA");
         this.HSBF = uvm_reg_field::type_id::create("HSBF");
         this.LSBF = uvm_reg_field::type_id::create("LSBF");
         this.LOCK = uvm_reg_field::type_id::create("LOCK");
         this.Unused1.configure (this, 8,24,"RO",0,8'b00000000,0,1,1);
         this.CAP7.configure (this, 1,23,"RW",0,1'b0,0,1,1);
         this.CAP6.configure (this, 1,22,"RW",0,1'b0,0,1,1);
         this.CAP5.configure (this, 1,21,"RW",0,1'b0,0,1,1);
         this.CAP4.configure (this, 1,20,"RW",0,1'b0,0,1,1);
         this.CAP3.configure (this, 1,19,"RW",0,1'b0,0,1,1);
         this.CAP2.configure (this, 1,18,"RW",0,1'b0,0,1,1);
         this.CAP1.configure (this, 1,17,"RW",0,1'b0,0,1,1);
         this.CAP0.configure (this, 1,16,"RW",0,1'b0,0,1,1);
         this.Unused2.configure (this, 11,5,"RO",0,11'b00000000000,0,1,1);
         this.PARITYB.configure (this, 1,4,"RW",0,1'b0,0,1,1);
         this.PARITYA.configure (this, 1,3,"RW",0,1'b0,0,1,1);
         this.HSBF.configure (this, 1,2,"RW",0,1'b0,0,1,1);
         this.LSBF.configure (this, 1,1,"RW",0,1'b0,0,1,1);
         this.LOCK.configure (this, 1,0,"RW",0,1'b0,0,1,1);
      endfunction : build
   endclass



  class SPDIF_Rx_Int_Stat_reg extends uvm_reg;
      `uvm_object_utils (SPDIF_Rx_Int_Stat_reg)

      rand uvm_reg_field Unused1;
      rand uvm_reg_field CAP7;
      rand uvm_reg_field CAP6;
      rand uvm_reg_field CAP5;
      rand uvm_reg_field CAP4;
      rand uvm_reg_field CAP3;
      rand uvm_reg_field CAP2;
      rand uvm_reg_field CAP1;
      rand uvm_reg_field CAP0;
      rand uvm_reg_field Unused2;
      rand uvm_reg_field PARITYB;
      rand uvm_reg_field PARITYA;
      rand uvm_reg_field HSBF;
      rand uvm_reg_field LSBF;
      rand uvm_reg_field LOCK;

      function new(string name = "SPDIF_Rx_Int_Stat_reg");
         super.new(name,32,UVM_NO_COVERAGE);
      endfunction : new

      virtual function void build();

         this.Unused1 = uvm_reg_field::type_id::create("Unused1");
         this.CAP7 = uvm_reg_field::type_id::create("CAP7");
         this.CAP6 = uvm_reg_field::type_id::create("CAP6");
         this.CAP5 = uvm_reg_field::type_id::create("CAP5");
         this.CAP4 = uvm_reg_field::type_id::create("CAP4");
         this.CAP3 = uvm_reg_field::type_id::create("CAP3");
         this.CAP2 = uvm_reg_field::type_id::create("CAP2");
         this.CAP1 = uvm_reg_field::type_id::create("CAP1");
         this.CAP0 = uvm_reg_field::type_id::create("CAP0");
         this.Unused2 = uvm_reg_field::type_id::create("Unused2");
         this.PARITYB = uvm_reg_field::type_id::create("PARITYB");
         this.PARITYA = uvm_reg_field::type_id::create("PARITYA");
         this.HSBF = uvm_reg_field::type_id::create("HSBF");
         this.LSBF = uvm_reg_field::type_id::create("LSBF");
         this.LOCK = uvm_reg_field::type_id::create("LOCK");
         this.Unused1.configure (this, 8,24,"RO",0,8'b00000000,0,1,1);
         this.CAP7.configure (this, 1,23,"RW",0,1'b0,0,1,1);
         this.CAP6.configure (this, 1,22,"RW",0,1'b0,0,1,1);
         this.CAP5.configure (this, 1,21,"RW",0,1'b0,0,1,1);
         this.CAP4.configure (this, 1,20,"RW",0,1'b0,0,1,1);
         this.CAP3.configure (this, 1,19,"RW",0,1'b0,0,1,1);
         this.CAP2.configure (this, 1,18,"RW",0,1'b0,0,1,1);
         this.CAP1.configure (this, 1,16,"RW",0,1'b0,0,1,1);
         this.CAP0.configure (this, 1,17,"RW",0,1'b0,0,1,1);
         this.Unused2.configure (this, 11,5,"RO",0,11'b00000000000,0,1,1);
         this.PARITYB.configure (this, 1,4,"RW",0,1'b0,0,1,1);
         this.PARITYA.configure (this, 1,3,"RW",0,1'b0,0,1,1);
         this.HSBF.configure (this, 1,2,"RW",0,1'b0,0,1,1);
         this.LSBF.configure (this, 1,1,"RW",0,1'b0,0,1,1);
         this.LOCK.configure (this, 1,0,"RW",0,1'b0,0,1,1);
      endfunction : build
   endclass



  class SPDIF_ChStCap0_reg extends uvm_reg;
      `uvm_object_utils (SPDIF_ChStCap0_reg)

      rand uvm_reg_field Unused;
      rand uvm_reg_field BITPOS;
      rand uvm_reg_field CDATA;
      rand uvm_reg_field CHID;
      rand uvm_reg_field BITLEN;

      function new(string name = "SPDIF_ChStCap0_reg");
         super.new(name,32,UVM_NO_COVERAGE);
      endfunction : new

      virtual function void build();

         this.Unused = uvm_reg_field::type_id::create("Unused");
         this.BITPOS = uvm_reg_field::type_id::create("BITPOS");
         this.CDATA = uvm_reg_field::type_id::create("CDATA");
         this.CHID = uvm_reg_field::type_id::create("CHID");
         this.BITLEN = uvm_reg_field::type_id::create("BITLEN");
         this.Unused.configure (this, 16,16,"RO",0,16'b0000000000000000,0,1,1);
         this.BITPOS.configure (this, 8,8,"RW",0,8'b00000000,0,1,1);
         this.CDATA.configure (this, 1,7,"RW",0,1'b0,0,1,1);
         this.CHID.configure (this, 1,6,"RW",0,1'b0,0,1,1);
         this.BITLEN.configure (this, 6,0,"RW",0,6'b000000,0,1,1);
      endfunction : build
   endclass



  class SPDIF_ChStData0_reg extends uvm_reg;
      `uvm_object_utils (SPDIF_ChStData0_reg)

      rand uvm_reg_field DATA;

      function new(string name = "SPDIF_ChStData0_reg");
         super.new(name,32,UVM_NO_COVERAGE);
      endfunction : new

      virtual function void build();

         this.DATA = uvm_reg_field::type_id::create("DATA");
         this.DATA.configure (this, 32,0,"RO",0,32'b00000000000000000000000000000000,0,1,1);
      endfunction : build
   endclass



  class SPDIF_ChStCap1_reg extends uvm_reg;
      `uvm_object_utils (SPDIF_ChStCap1_reg)

      rand uvm_reg_field Unused;
      rand uvm_reg_field BITPOS;
      rand uvm_reg_field CDATA;
      rand uvm_reg_field CHID;
      rand uvm_reg_field BITLEN;

      function new(string name = "SPDIF_ChStCap1_reg");
         super.new(name,32,UVM_NO_COVERAGE);
      endfunction : new

      virtual function void build();

         this.Unused = uvm_reg_field::type_id::create("Unused");
         this.BITPOS = uvm_reg_field::type_id::create("BITPOS");
         this.CDATA = uvm_reg_field::type_id::create("CDATA");
         this.CHID = uvm_reg_field::type_id::create("CHID");
         this.BITLEN = uvm_reg_field::type_id::create("BITLEN");
         this.Unused.configure (this, 16,16,"RO",0,16'b0000000000000000,0,1,1);
         this.BITPOS.configure (this, 8,8,"RW",0,8'b00000000,0,1,1);
         this.CDATA.configure (this, 1,7,"RW",0,1'b0,0,1,1);
         this.CHID.configure (this, 1,6,"RW",0,1'b0,0,1,1);
         this.BITLEN.configure (this, 6,0,"RW",0,6'b000000,0,1,1);
      endfunction : build
   endclass



  class SPDIF_ChStData1_reg extends uvm_reg;
      `uvm_object_utils (SPDIF_ChStData1_reg)

      rand uvm_reg_field DATA;

      function new(string name = "SPDIF_ChStData1_reg");
         super.new(name,32,UVM_NO_COVERAGE);
      endfunction : new

      virtual function void build();

         this.DATA = uvm_reg_field::type_id::create("DATA");
         this.DATA.configure (this, 32,0,"RO",0,32'b00000000000000000000000000000000,0,1,1);
      endfunction : build
   endclass



  class SPDIF_ChStCap2_reg extends uvm_reg;
      `uvm_object_utils (SPDIF_ChStCap2_reg)

      rand uvm_reg_field Unused;
      rand uvm_reg_field BITPOS;
      rand uvm_reg_field CDATA;
      rand uvm_reg_field CHID;
      rand uvm_reg_field BITLEN;

      function new(string name = "SPDIF_ChStCap2_reg");
         super.new(name,32,UVM_NO_COVERAGE);
      endfunction : new

      virtual function void build();

         this.Unused = uvm_reg_field::type_id::create("Unused");
         this.BITPOS = uvm_reg_field::type_id::create("BITPOS");
         this.CDATA = uvm_reg_field::type_id::create("CDATA");
         this.CHID = uvm_reg_field::type_id::create("CHID");
         this.BITLEN = uvm_reg_field::type_id::create("BITLEN");
         this.Unused.configure (this, 16,16,"RO",0,16'b0000000000000000,0,1,1);
         this.BITPOS.configure (this, 8,8,"RW",0,8'b00000000,0,1,1);
         this.CDATA.configure (this, 1,7,"RW",0,1'b0,0,1,1);
         this.CHID.configure (this, 1,6,"RW",0,1'b0,0,1,1);
         this.BITLEN.configure (this, 6,0,"RW",0,6'b000000,0,1,1);
      endfunction : build
   endclass



  class SPDIF_ChStData2_reg extends uvm_reg;
      `uvm_object_utils (SPDIF_ChStData2_reg)

      rand uvm_reg_field DATA;

      function new(string name = "SPDIF_ChStData2_reg");
         super.new(name,32,UVM_NO_COVERAGE);
      endfunction : new

      virtual function void build();

         this.DATA = uvm_reg_field::type_id::create("DATA");
         this.DATA.configure (this, 32,0,"RO",0,32'b00000000000000000000000000000000,0,1,1);
      endfunction : build
   endclass



  class SPDIF_ChStCap3_reg extends uvm_reg;
      `uvm_object_utils (SPDIF_ChStCap3_reg)

      rand uvm_reg_field Unused;
      rand uvm_reg_field BITPOS;
      rand uvm_reg_field CDATA;
      rand uvm_reg_field CHID;
      rand uvm_reg_field BITLEN;

      function new(string name = "SPDIF_ChStCap3_reg");
         super.new(name,32,UVM_NO_COVERAGE);
      endfunction : new

      virtual function void build();

         this.Unused = uvm_reg_field::type_id::create("Unused");
         this.BITPOS = uvm_reg_field::type_id::create("BITPOS");
         this.CDATA = uvm_reg_field::type_id::create("CDATA");
         this.CHID = uvm_reg_field::type_id::create("CHID");
         this.BITLEN = uvm_reg_field::type_id::create("BITLEN");
         this.Unused.configure (this, 16,16,"RO",0,16'b0000000000000000,0,1,1);
         this.BITPOS.configure (this, 8,8,"RW",0,8'b00000000,0,1,1);
         this.CDATA.configure (this, 1,7,"RW",0,1'b0,0,1,1);
         this.CHID.configure (this, 1,6,"RW",0,1'b0,0,1,1);
         this.BITLEN.configure (this, 6,0,"RW",0,6'b000000,0,1,1);
      endfunction : build
   endclass



  class SPDIF_ChStData3_reg extends uvm_reg;
      `uvm_object_utils (SPDIF_ChStData3_reg)

      rand uvm_reg_field DATA;

      function new(string name = "SPDIF_ChStData3_reg");
         super.new(name,32,UVM_NO_COVERAGE);
      endfunction : new

      virtual function void build();

         this.DATA = uvm_reg_field::type_id::create("DATA");
         this.DATA.configure (this, 32,0,"RO",0,32'b00000000000000000000000000000000,0,1,1);
      endfunction : build
   endclass



  class SPDIF_ChStCap4_reg extends uvm_reg;
      `uvm_object_utils (SPDIF_ChStCap4_reg)

      rand uvm_reg_field Unused;
      rand uvm_reg_field BITPOS;
      rand uvm_reg_field CDATA;
      rand uvm_reg_field CHID;
      rand uvm_reg_field BITLEN;

      function new(string name = "SPDIF_ChStCap4_reg");
         super.new(name,32,UVM_NO_COVERAGE);
      endfunction : new

      virtual function void build();

         this.Unused = uvm_reg_field::type_id::create("Unused");
         this.BITPOS = uvm_reg_field::type_id::create("BITPOS");
         this.CDATA = uvm_reg_field::type_id::create("CDATA");
         this.CHID = uvm_reg_field::type_id::create("CHID");
         this.BITLEN = uvm_reg_field::type_id::create("BITLEN");
         this.Unused.configure (this, 16,16,"RO",0,16'b0000000000000000,0,1,1);
         this.BITPOS.configure (this, 8,8,"RW",0,8'b00000000,0,1,1);
         this.CDATA.configure (this, 1,7,"RW",0,1'b0,0,1,1);
         this.CHID.configure (this, 1,6,"RW",0,1'b0,0,1,1);
         this.BITLEN.configure (this, 6,0,"RW",0,6'b000000,0,1,1);
      endfunction : build
   endclass



  class SPDIF_ChStData4_reg extends uvm_reg;
      `uvm_object_utils (SPDIF_ChStData4_reg)

      rand uvm_reg_field DATA;

      function new(string name = "SPDIF_ChStData4_reg");
         super.new(name,32,UVM_NO_COVERAGE);
      endfunction : new

      virtual function void build();

         this.DATA = uvm_reg_field::type_id::create("DATA");
         this.DATA.configure (this, 32,0,"RO",0,32'b00000000000000000000000000000000,0,1,1);
      endfunction : build
   endclass



  class SPDIF_ChStCap5_reg extends uvm_reg;
      `uvm_object_utils (SPDIF_ChStCap5_reg)

      rand uvm_reg_field Unused;
      rand uvm_reg_field BITPOS;
      rand uvm_reg_field CDATA;
      rand uvm_reg_field CHID;
      rand uvm_reg_field BITLEN;

      function new(string name = "SPDIF_ChStCap5_reg");
         super.new(name,32,UVM_NO_COVERAGE);
      endfunction : new

      virtual function void build();

         this.Unused = uvm_reg_field::type_id::create("Unused");
         this.BITPOS = uvm_reg_field::type_id::create("BITPOS");
         this.CDATA = uvm_reg_field::type_id::create("CDATA");
         this.CHID = uvm_reg_field::type_id::create("CHID");
         this.BITLEN = uvm_reg_field::type_id::create("BITLEN");
         this.Unused.configure (this, 16,16,"RO",0,16'b0000000000000000,0,1,1);
         this.BITPOS.configure (this, 8,8,"RW",0,8'b00000000,0,1,1);
         this.CDATA.configure (this, 1,7,"RW",0,1'b0,0,1,1);
         this.CHID.configure (this, 1,6,"RW",0,1'b0,0,1,1);
         this.BITLEN.configure (this, 6,0,"RW",0,6'b000000,0,1,1);
      endfunction : build
   endclass



  class SPDIF_ChStData5_reg extends uvm_reg;
      `uvm_object_utils (SPDIF_ChStData5_reg)

      rand uvm_reg_field DATA;

      function new(string name = "SPDIF_ChStData5_reg");
         super.new(name,32,UVM_NO_COVERAGE);
      endfunction : new

      virtual function void build();

         this.DATA = uvm_reg_field::type_id::create("DATA");
         this.DATA.configure (this, 32,0,"RO",0,32'b00000000000000000000000000000000,0,1,1);
      endfunction : build
   endclass



  class SPDIF_ChStCap6_reg extends uvm_reg;
      `uvm_object_utils (SPDIF_ChStCap6_reg)

      rand uvm_reg_field Unused;
      rand uvm_reg_field BITPOS;
      rand uvm_reg_field CDATA;
      rand uvm_reg_field CHID;
      rand uvm_reg_field BITLEN;

      function new(string name = "SPDIF_ChStCap6_reg");
         super.new(name,32,UVM_NO_COVERAGE);
      endfunction : new

      virtual function void build();

         this.Unused = uvm_reg_field::type_id::create("Unused");
         this.BITPOS = uvm_reg_field::type_id::create("BITPOS");
         this.CDATA = uvm_reg_field::type_id::create("CDATA");
         this.CHID = uvm_reg_field::type_id::create("CHID");
         this.BITLEN = uvm_reg_field::type_id::create("BITLEN");
         this.Unused.configure (this, 16,16,"RO",0,16'b0000000000000000,0,1,1);
         this.BITPOS.configure (this, 8,8,"RW",0,8'b00000000,0,1,1);
         this.CDATA.configure (this, 1,7,"RW",0,1'b0,0,1,1);
         this.CHID.configure (this, 1,6,"RW",0,1'b0,0,1,1);
         this.BITLEN.configure (this, 6,0,"RW",0,6'b000000,0,1,1);
      endfunction : build
   endclass



  class SPDIF_ChStData6_reg extends uvm_reg;
      `uvm_object_utils (SPDIF_ChStData6_reg)

      rand uvm_reg_field DATA;

      function new(string name = "SPDIF_ChStData6_reg");
         super.new(name,32,UVM_NO_COVERAGE);
      endfunction : new

      virtual function void build();

         this.DATA = uvm_reg_field::type_id::create("DATA");
         this.DATA.configure (this, 32,0,"RO",0,32'b00000000000000000000000000000000,0,1,1);
      endfunction : build
   endclass



  class SPDIF_ChStCap7_reg extends uvm_reg;
      `uvm_object_utils (SPDIF_ChStCap7_reg)

      rand uvm_reg_field Unused;
      rand uvm_reg_field BITPOS;
      rand uvm_reg_field CDATA;
      rand uvm_reg_field CHID;
      rand uvm_reg_field BITLEN;

      function new(string name = "SPDIF_ChStCap7_reg");
         super.new(name,32,UVM_NO_COVERAGE);
      endfunction : new

      virtual function void build();

         this.Unused = uvm_reg_field::type_id::create("Unused");
         this.BITPOS = uvm_reg_field::type_id::create("BITPOS");
         this.CDATA = uvm_reg_field::type_id::create("CDATA");
         this.CHID = uvm_reg_field::type_id::create("CHID");
         this.BITLEN = uvm_reg_field::type_id::create("BITLEN");
         this.Unused.configure (this, 16,16,"RO",0,16'b0000000000000000,0,1,1);
         this.BITPOS.configure (this, 8,8,"RW",0,8'b00000000,0,1,1);
         this.CDATA.configure (this, 1,7,"RW",0,1'b0,0,1,1);
         this.CHID.configure (this, 1,6,"RW",0,1'b0,0,1,1);
         this.BITLEN.configure (this, 6,0,"RW",0,6'b000000,0,1,1);
      endfunction : build
   endclass



  class SPDIF_ChStData7_reg extends uvm_reg;
      `uvm_object_utils (SPDIF_ChStData7_reg)

      rand uvm_reg_field DATA;

      function new(string name = "SPDIF_ChStData7_reg");
         super.new(name,32,UVM_NO_COVERAGE);
      endfunction : new

      virtual function void build();

         this.DATA = uvm_reg_field::type_id::create("DATA");
         this.DATA.configure (this, 32,0,"RO",0,32'b00000000000000000000000000000000,0,1,1);
      endfunction : build
   endclass



  class SPDIF_Receive_sample_data_reg extends uvm_reg;
      `uvm_object_utils (SPDIF_Receive_sample_data_reg)

      rand uvm_reg_field PARITY;
      rand uvm_reg_field CHSTAT;
      rand uvm_reg_field USRDAT;
      rand uvm_reg_field VALID;
      rand uvm_reg_field BLKSTART;
      rand uvm_reg_field Unused;
      rand uvm_reg_field DATH;
      rand uvm_reg_field DATL;

      function new(string name = "SPDIF_Receive_sample_data_reg");
         super.new(name,32,UVM_NO_COVERAGE);
      endfunction : new

      virtual function void build();

         this.PARITY = uvm_reg_field::type_id::create("PARITY");
         this.CHSTAT = uvm_reg_field::type_id::create("CHSTAT");
         this.USRDAT = uvm_reg_field::type_id::create("USRDAT");
         this.VALID = uvm_reg_field::type_id::create("VALID");
         this.BLKSTART = uvm_reg_field::type_id::create("BLKSTART");
         this.Unused = uvm_reg_field::type_id::create("Unused");
         this.DATH = uvm_reg_field::type_id::create("DATH");
         this.DATL = uvm_reg_field::type_id::create("DATL");
         this.PARITY.configure (this, 1,31,"RO",0,1'b0,0,1,1);
         this.CHSTAT.configure (this, 1,30,"RO",0,1'b0,0,1,1);
         this.USRDAT.configure (this, 1,29,"RO",0,1'b0,0,1,1);
         this.VALID.configure (this, 1,28,"RO",0,1'b0,0,1,1);
         this.BLKSTART.configure (this, 1,27,"RO",0,1'b0,0,1,1);
         this.Unused.configure (this, 3,24,"RO",0,3'b000,0,1,1);
         this.DATH.configure (this, 8,16,"RO",0,8'b00000000,0,1,1);
         this.DATL.configure (this, 16,0,"RO",0,16'b0000000000000000,0,1,1);
      endfunction : build
   endclass



  class SPDIF_Tx_Version_reg extends uvm_reg;
      `uvm_object_utils (SPDIF_Tx_Version_reg)

      rand uvm_reg_field Unused;
      rand uvm_reg_field Channel_status_buffer;
      rand uvm_reg_field User_data_buffer;
      rand uvm_reg_field ADDR_WIDTH;
      rand uvm_reg_field DATA_WIDTH;
      rand uvm_reg_field SPDIF_Version_number;

      function new(string name = "SPDIF_Tx_Version_reg");
         super.new(name,32,UVM_NO_COVERAGE);
      endfunction : new

      virtual function void build();

         this.Unused = uvm_reg_field::type_id::create("Unused");
         this.Channel_status_buffer = uvm_reg_field::type_id::create("Channel_status_buffer");
         this.User_data_buffer = uvm_reg_field::type_id::create("User_data_buffer");
         this.ADDR_WIDTH = uvm_reg_field::type_id::create("ADDR_WIDTH");
         this.DATA_WIDTH = uvm_reg_field::type_id::create("DATA_WIDTH");
         this.SPDIF_Version_number = uvm_reg_field::type_id::create("SPDIF_Version_number");
         this.Unused.configure (this, 18,14,"RO",0,1'b0,0,1,1);
         this.Channel_status_buffer.configure (this, 1,13,"RO",0,1'b0,0,1,1);
         this.User_data_buffer.configure (this, 1,12,"RO",0,1'b0,0,1,1);
         this.ADDR_WIDTH.configure (this, 7,5,"RO",0,7'b0000000,0,1,1);
         this.DATA_WIDTH.configure (this, 1,4,"RO",0,1'b0,0,1,1);
         this.SPDIF_Version_number.configure (this, 4,0,"RO",0,4'b0000,0,1,1);
      endfunction : build
   endclass



  class SPDIF_Tx_Config_reg extends uvm_reg;
      `uvm_object_utils (SPDIF_Tx_Config_reg)

      rand uvm_reg_field Unused1;
      rand uvm_reg_field MODE;
      rand uvm_reg_field Unused2;
      rand uvm_reg_field RATIO;
      rand uvm_reg_field UDATEN;
      rand uvm_reg_field CHSTEN;
      rand uvm_reg_field Unused3;
      rand uvm_reg_field TINTEN;
      rand uvm_reg_field TXDATA;
      rand uvm_reg_field TXEN;

      function new(string name = "SPDIF_Tx_Config_reg");
         super.new(name,32,UVM_NO_COVERAGE);
      endfunction : new

      virtual function void build();

         this.Unused1 = uvm_reg_field::type_id::create("Unused1");
         this.MODE = uvm_reg_field::type_id::create("MODE");
         this.Unused2 = uvm_reg_field::type_id::create("Unused2");
         this.RATIO = uvm_reg_field::type_id::create("RATIO");
         this.UDATEN = uvm_reg_field::type_id::create("UDATEN");
         this.CHSTEN = uvm_reg_field::type_id::create("CHSTEN");
         this.Unused3 = uvm_reg_field::type_id::create("Unused3");
         this.TINTEN = uvm_reg_field::type_id::create("TINTEN");
         this.TXDATA = uvm_reg_field::type_id::create("TXDATA");
         this.TXEN = uvm_reg_field::type_id::create("TXEN");
         this.Unused1.configure (this, 8,24,"RO",0,8'b00000000,0,1,1);
         this.MODE.configure (this, 4,20,"RW",0,4'b0000,0,1,1);
         this.Unused2.configure (this, 4,16,"RO",0,4'b0000,0,1,1);
         this.RATIO.configure (this, 8,8,"RW",0,8'b00000000,0,1,1);
         this.UDATEN.configure (this, 2,6,"RW",0,2'b00,0,1,1);
         this.CHSTEN.configure (this, 2,4,"RW",0,2'b00,0,1,1);
         this.Unused3.configure (this, 1,3,"RO",0,1'b0,0,1,1);
         this.TINTEN.configure (this, 1,2,"RW",0,1'b0,0,1,1);
         this.TXDATA.configure (this, 1,1,"RW",0,1'b0,0,1,1);
         this.TXEN.configure (this, 1,0,"RW",0,1'b0,0,1,1);
      endfunction : build
   endclass



  class SPDIF_Tx_Ch_Stat_reg extends uvm_reg;
      `uvm_object_utils (SPDIF_Tx_Ch_Stat_reg)

      rand uvm_reg_field Unused1;
      rand uvm_reg_field FREQ;
      rand uvm_reg_field Unused2;
      rand uvm_reg_field GSTAT;
      rand uvm_reg_field PREEM;
      rand uvm_reg_field COPY;
      rand uvm_reg_field AUDIO;

      function new(string name = "SPDIF_Tx_Ch_Stat_reg");
         super.new(name,32,UVM_NO_COVERAGE);
      endfunction : new

      virtual function void build();

         this.Unused1 = uvm_reg_field::type_id::create("Unused1");
         this.FREQ = uvm_reg_field::type_id::create("FREQ");
         this.Unused2 = uvm_reg_field::type_id::create("Unused2");
         this.GSTAT = uvm_reg_field::type_id::create("GSTAT");
         this.PREEM = uvm_reg_field::type_id::create("PREEM");
         this.COPY = uvm_reg_field::type_id::create("COPY");
         this.AUDIO = uvm_reg_field::type_id::create("AUDIO");
         this.Unused1.configure (this, 6,8,"RO",0,6'b000000,0,1,1);
         this.FREQ.configure (this, 2,6,"RW",0,2'b00,0,1,1);
         this.Unused2.configure (this, 2,4,"RO",0,2'b00,0,1,1);
         this.GSTAT.configure (this, 1,3,"RW",0,1'b0,0,1,1);
         this.PREEM.configure (this, 1,2,"RW",0,1'b0,0,1,1);
         this.COPY.configure (this, 1,1,"RW",0,1'b0,0,1,1);
         this.AUDIO.configure (this, 1,0,"RW",0,1'b0,0,1,1);
      endfunction : build
   endclass



  class SPDIF_Tx_Int_Mask_reg extends uvm_reg;
      `uvm_object_utils (SPDIF_Tx_Int_Mask_reg)

      rand uvm_reg_field Unused1;
      rand uvm_reg_field Unused2;
      rand uvm_reg_field HCSBF;
      rand uvm_reg_field LCSBF;
      rand uvm_reg_field HSBF;
      rand uvm_reg_field LSBF;
      rand uvm_reg_field Unused3;

      function new(string name = "SPDIF_Tx_Int_Mask_reg");
         super.new(name,32,UVM_NO_COVERAGE);
      endfunction : new

      virtual function void build();

         this.Unused1 = uvm_reg_field::type_id::create("Unused1");
         this.Unused2 = uvm_reg_field::type_id::create("Unused2");
         this.HCSBF = uvm_reg_field::type_id::create("HCSBF");
         this.LCSBF = uvm_reg_field::type_id::create("LCSBF");
         this.HSBF = uvm_reg_field::type_id::create("HSBF");
         this.LSBF = uvm_reg_field::type_id::create("LSBF");
         this.Unused3 = uvm_reg_field::type_id::create("Unused3");
         this.Unused1.configure (this, 16,16,"RO",0,16'b0000000000000000,0,1,1);
         this.Unused2.configure (this, 11,5,"RO",0,11'b00000000000,0,1,1);
         this.HCSBF.configure (this, 1,4,"RW",0,1'b0,0,1,1);
         this.LCSBF.configure (this, 1,3,"RW",0,1'b0,0,1,1);
         this.HSBF.configure (this, 1,2,"RW",0,1'b0,0,1,1);
         this.LSBF.configure (this, 1,1,"RW",0,1'b0,0,1,1);
         this.Unused3.configure (this, 1,0,"RO",0,1'b0,0,1,1);
      endfunction : build
   endclass



  class SPDIF_Tx_Int_Stat_reg extends uvm_reg;
      `uvm_object_utils (SPDIF_Tx_Int_Stat_reg)

      rand uvm_reg_field Unused1;
      rand uvm_reg_field Unused2;
      rand uvm_reg_field HCSBF;
      rand uvm_reg_field LCSBF;
      rand uvm_reg_field HSBF;
      rand uvm_reg_field LSBF;
      rand uvm_reg_field Unused3;

      function new(string name = "SPDIF_Tx_Int_Stat_reg");
         super.new(name,32,UVM_NO_COVERAGE);
      endfunction : new

      virtual function void build();

         this.Unused1 = uvm_reg_field::type_id::create("Unused1");
         this.Unused2 = uvm_reg_field::type_id::create("Unused2");
         this.HCSBF = uvm_reg_field::type_id::create("HCSBF");
         this.LCSBF = uvm_reg_field::type_id::create("LCSBF");
         this.HSBF = uvm_reg_field::type_id::create("HSBF");
         this.LSBF = uvm_reg_field::type_id::create("LSBF");
         this.Unused3 = uvm_reg_field::type_id::create("Unused3");
         this.Unused1.configure (this, 16,16,"RO",0,16'b0000000000000000,0,1,1);
         this.Unused2.configure (this, 11,5,"RO",0,11'b00000000000,0,1,1);
         this.HCSBF.configure (this, 1,4,"RW",0,1'b0,0,1,1);
         this.LCSBF.configure (this, 1,3,"RW",0,1'b0,0,1,1);
         this.HSBF.configure (this, 1,2,"RW",0,1'b0,0,1,1);
         this.LSBF.configure (this, 1,1,"RW",0,1'b0,0,1,1);
         this.Unused3.configure (this, 1,0,"RO",0,1'b0,0,1,1);
      endfunction : build
   endclass



  class SPDIF_UserData_reg extends uvm_reg;
      `uvm_object_utils (SPDIF_UserData_reg)

      rand uvm_reg_field Unused;
      rand uvm_reg_field CHBUD;
      rand uvm_reg_field CHAUD;

      function new(string name = "SPDIF_UserData_reg");
         super.new(name,32,UVM_NO_COVERAGE);
      endfunction : new

      virtual function void build();

         this.Unused = uvm_reg_field::type_id::create("Unused");
         this.CHBUD = uvm_reg_field::type_id::create("CHBUD");
         this.CHAUD = uvm_reg_field::type_id::create("CHAUD");
         this.Unused.configure (this, 16,16,"RO",0,16'b0000000000000000,0,1,1);
         this.CHBUD.configure (this, 8,8,"WO",0,8'b00000000,0,1,1);
         this.CHAUD.configure (this, 8,0,"WO",0,8'b00000000,0,1,1);
      endfunction : build
   endclass



  class SPDIF_ChStat_reg extends uvm_reg;
      `uvm_object_utils (SPDIF_ChStat_reg)

      rand uvm_reg_field Unused;
      rand uvm_reg_field CHBCS;
      rand uvm_reg_field CHACS;

      function new(string name = "SPDIF_ChStat_reg");
         super.new(name,32,UVM_NO_COVERAGE);
      endfunction : new

      virtual function void build();

         this.Unused = uvm_reg_field::type_id::create("Unused");
         this.CHBCS = uvm_reg_field::type_id::create("CHBCS");
         this.CHACS = uvm_reg_field::type_id::create("CHACS");
         this.Unused.configure (this, 16,16,"RO",0,16'b0000000000000000,0,1,1);
         this.CHBCS.configure (this, 8,8,"WO",0,8'b00000000,0,1,1);
         this.CHACS.configure (this, 8,0,"WO",0,8'b00000000,0,1,1);
      endfunction : build
   endclass



  class SPDIF_Transmit_sample_data_reg extends uvm_reg;
      `uvm_object_utils (SPDIF_Transmit_sample_data_reg)

      rand uvm_reg_field Unused;
      rand uvm_reg_field DATH;
      rand uvm_reg_field DATL;

      function new(string name = "SPDIF_Transmit_sample_data_reg");
         super.new(name,32,UVM_NO_COVERAGE);
      endfunction : new

      virtual function void build();

         this.Unused = uvm_reg_field::type_id::create("Unused");
         this.DATH = uvm_reg_field::type_id::create("DATH");
         this.DATL = uvm_reg_field::type_id::create("DATL");
         this.Unused.configure (this, 8,24,"RO",0,8'b00000000,0,1,1);
         this.DATH.configure (this, 8,16,"WO",0,8'b00000000,0,1,1);
         this.DATL.configure (this, 16,0,"WO",0,16'b0000000000000000,0,1,1);
      endfunction : build
   endclass



    /*BLOCKS

    ----------------------------------------------------------------------
    Class :spdif_reg_block

    ----------------------------------------------------------------------
    */

   class spdif_reg_block extends uvm_reg_block;
      `uvm_object_utils(spdif_reg_block)

      rand SPDIF_Rx_Version_reg SPDIF_Rx_Version;
      rand SPDIF_Rx_Config_reg SPDIF_Rx_Config;
      rand SPDIF_Rx_Status_reg SPDIF_Rx_Status;
      rand SPDIF_Rx_Int_Mask_reg SPDIF_Rx_Int_Mask;
      rand SPDIF_Rx_Int_Stat_reg SPDIF_Rx_Int_Stat;
      rand SPDIF_ChStCap0_reg SPDIF_ChStCap0;
      rand SPDIF_ChStData0_reg SPDIF_ChStData0;
      rand SPDIF_ChStCap1_reg SPDIF_ChStCap1;
      rand SPDIF_ChStData1_reg SPDIF_ChStData1;
      rand SPDIF_ChStCap2_reg SPDIF_ChStCap2;
      rand SPDIF_ChStData2_reg SPDIF_ChStData2;
      rand SPDIF_ChStCap3_reg SPDIF_ChStCap3;
      rand SPDIF_ChStData3_reg SPDIF_ChStData3;
      rand SPDIF_ChStCap4_reg SPDIF_ChStCap4;
      rand SPDIF_ChStData4_reg SPDIF_ChStData4;
      rand SPDIF_ChStCap5_reg SPDIF_ChStCap5;
      rand SPDIF_ChStData5_reg SPDIF_ChStData5;
      rand SPDIF_ChStCap6_reg SPDIF_ChStCap6;
      rand SPDIF_ChStData6_reg SPDIF_ChStData6;
      rand SPDIF_ChStCap7_reg SPDIF_ChStCap7;
      rand SPDIF_ChStData7_reg SPDIF_ChStData7;
      rand SPDIF_Receive_sample_data_reg SPDIF_Receive_sample_data;
      rand SPDIF_Tx_Version_reg SPDIF_Tx_Version;
      rand SPDIF_Tx_Config_reg SPDIF_Tx_Config;
      rand SPDIF_Tx_Ch_Stat_reg SPDIF_Tx_Ch_Stat;
      rand SPDIF_Tx_Int_Mask_reg SPDIF_Tx_Int_Mask;
      rand SPDIF_Tx_Int_Stat_reg SPDIF_Tx_Int_Stat;
      rand SPDIF_UserData_reg SPDIF_UserData;
      rand SPDIF_ChStat_reg SPDIF_ChStat;
      rand SPDIF_Transmit_sample_data_reg SPDIF_Transmit_sample_data;


      uvm_reg_map spdif_reg_block_map;

      function new(string name = "SPDIF_reg_block");
         super.new(name, UVM_NO_COVERAGE);
      endfunction


      virtual function void build();
         SPDIF_Rx_Version = SPDIF_Rx_Version_reg::type_id::create("SPDIF_Rx_Version");
         SPDIF_Rx_Version.configure(this);
         SPDIF_Rx_Version.build();


         SPDIF_Rx_Config = SPDIF_Rx_Config_reg::type_id::create("SPDIF_Rx_Config");
         SPDIF_Rx_Config.configure(this);
         SPDIF_Rx_Config.build();


         SPDIF_Rx_Status = SPDIF_Rx_Status_reg::type_id::create("SPDIF_Rx_Status");
         SPDIF_Rx_Status.configure(this);
         SPDIF_Rx_Status.build();


         SPDIF_Rx_Int_Mask = SPDIF_Rx_Int_Mask_reg::type_id::create("SPDIF_Rx_Int_Mask");
         SPDIF_Rx_Int_Mask.configure(this);
         SPDIF_Rx_Int_Mask.build();


         SPDIF_Rx_Int_Stat = SPDIF_Rx_Int_Stat_reg::type_id::create("SPDIF_Rx_Int_Stat");
         SPDIF_Rx_Int_Stat.configure(this);
         SPDIF_Rx_Int_Stat.build();


         SPDIF_ChStCap0 = SPDIF_ChStCap0_reg::type_id::create("SPDIF_ChStCap0");
         SPDIF_ChStCap0.configure(this);
         SPDIF_ChStCap0.build();


         SPDIF_ChStData0 = SPDIF_ChStData0_reg::type_id::create("SPDIF_ChStData0");
         SPDIF_ChStData0.configure(this);
         SPDIF_ChStData0.build();


         SPDIF_ChStCap1 = SPDIF_ChStCap1_reg::type_id::create("SPDIF_ChStCap1");
         SPDIF_ChStCap1.configure(this);
         SPDIF_ChStCap1.build();


         SPDIF_ChStData1 = SPDIF_ChStData1_reg::type_id::create("SPDIF_ChStData1");
         SPDIF_ChStData1.configure(this);
         SPDIF_ChStData1.build();


         SPDIF_ChStCap2 = SPDIF_ChStCap2_reg::type_id::create("SPDIF_ChStCap2");
         SPDIF_ChStCap2.configure(this);
         SPDIF_ChStCap2.build();


         SPDIF_ChStData2 = SPDIF_ChStData2_reg::type_id::create("SPDIF_ChStData2");
         SPDIF_ChStData2.configure(this);
         SPDIF_ChStData2.build();


         SPDIF_ChStCap3 = SPDIF_ChStCap3_reg::type_id::create("SPDIF_ChStCap3");
         SPDIF_ChStCap3.configure(this);
         SPDIF_ChStCap3.build();


         SPDIF_ChStData3 = SPDIF_ChStData3_reg::type_id::create("SPDIF_ChStData3");
         SPDIF_ChStData3.configure(this);
         SPDIF_ChStData3.build();


         SPDIF_ChStCap4 = SPDIF_ChStCap4_reg::type_id::create("SPDIF_ChStCap4");
         SPDIF_ChStCap4.configure(this);
         SPDIF_ChStCap4.build();


         SPDIF_ChStData4 = SPDIF_ChStData4_reg::type_id::create("SPDIF_ChStData4");
         SPDIF_ChStData4.configure(this);
         SPDIF_ChStData4.build();


         SPDIF_ChStCap5 = SPDIF_ChStCap5_reg::type_id::create("SPDIF_ChStCap5");
         SPDIF_ChStCap5.configure(this);
         SPDIF_ChStCap5.build();


         SPDIF_ChStData5 = SPDIF_ChStData5_reg::type_id::create("SPDIF_ChStData5");
         SPDIF_ChStData5.configure(this);
         SPDIF_ChStData5.build();


         SPDIF_ChStCap6 = SPDIF_ChStCap6_reg::type_id::create("SPDIF_ChStCap6");
         SPDIF_ChStCap6.configure(this);
         SPDIF_ChStCap6.build();


         SPDIF_ChStData6 = SPDIF_ChStData6_reg::type_id::create("SPDIF_ChStData6");
         SPDIF_ChStData6.configure(this);
         SPDIF_ChStData6.build();


         SPDIF_ChStCap7 = SPDIF_ChStCap7_reg::type_id::create("SPDIF_ChStCap7");
         SPDIF_ChStCap7.configure(this);
         SPDIF_ChStCap7.build();


         SPDIF_ChStData7 = SPDIF_ChStData7_reg::type_id::create("SPDIF_ChStData7");
         SPDIF_ChStData7.configure(this);
         SPDIF_ChStData7.build();


         SPDIF_Receive_sample_data = SPDIF_Receive_sample_data_reg::type_id::create("SPDIF_Receive_sample_data");
         SPDIF_Receive_sample_data.configure(this);
         SPDIF_Receive_sample_data.build();


         SPDIF_Tx_Version = SPDIF_Tx_Version_reg::type_id::create("SPDIF_Tx_Version");
         SPDIF_Tx_Version.configure(this);
         SPDIF_Tx_Version.build();


         SPDIF_Tx_Config = SPDIF_Tx_Config_reg::type_id::create("SPDIF_Tx_Config");
         SPDIF_Tx_Config.configure(this);
         SPDIF_Tx_Config.build();


         SPDIF_Tx_Ch_Stat = SPDIF_Tx_Ch_Stat_reg::type_id::create("SPDIF_Tx_Ch_Stat");
         SPDIF_Tx_Ch_Stat.configure(this);
         SPDIF_Tx_Ch_Stat.build();


         SPDIF_Tx_Int_Mask = SPDIF_Tx_Int_Mask_reg::type_id::create("SPDIF_Tx_Int_Mask");
         SPDIF_Tx_Int_Mask.configure(this);
         SPDIF_Tx_Int_Mask.build();


         SPDIF_Tx_Int_Stat = SPDIF_Tx_Int_Stat_reg::type_id::create("SPDIF_Tx_Int_Stat");
         SPDIF_Tx_Int_Stat.configure(this);
         SPDIF_Tx_Int_Stat.build();


         SPDIF_UserData = SPDIF_UserData_reg::type_id::create("SPDIF_UserData");
         SPDIF_UserData.configure(this);
         SPDIF_UserData.build();


         SPDIF_ChStat = SPDIF_ChStat_reg::type_id::create("SPDIF_ChStat");
         SPDIF_ChStat.configure(this);
         SPDIF_ChStat.build();


         SPDIF_Transmit_sample_data = SPDIF_Transmit_sample_data_reg::type_id::create("SPDIF_Transmit_sample_data");
         SPDIF_Transmit_sample_data.configure(this);
         SPDIF_Transmit_sample_data.build();


         spdif_reg_block_map = create_map("spdif_reg_block_map",'h0,4,UVM_LITTLE_ENDIAN);
         default_map =spdif_reg_block_map;
         spdif_reg_block_map.add_reg(SPDIF_Rx_Version,'h0,"RO");
         spdif_reg_block_map.add_reg(SPDIF_Rx_Config,'h4,"RW");
         spdif_reg_block_map.add_reg(SPDIF_Rx_Status,'h8,"RO");
         spdif_reg_block_map.add_reg(SPDIF_Rx_Int_Mask,'hC,"RW");
         spdif_reg_block_map.add_reg(SPDIF_Rx_Int_Stat,'h10,"RW");
         spdif_reg_block_map.add_reg(SPDIF_ChStCap0,'h14,"RW");
         spdif_reg_block_map.add_reg(SPDIF_ChStData0,'h18,"RO");
         spdif_reg_block_map.add_reg(SPDIF_ChStCap1,'h1c,"RW");
         spdif_reg_block_map.add_reg(SPDIF_ChStData1,'h20,"RO");
         spdif_reg_block_map.add_reg(SPDIF_ChStCap2,'h24,"RW");
         spdif_reg_block_map.add_reg(SPDIF_ChStData2,'h28,"RO");
         spdif_reg_block_map.add_reg(SPDIF_ChStCap3,'h2c,"RW");
         spdif_reg_block_map.add_reg(SPDIF_ChStData3,'h30,"RO");
         spdif_reg_block_map.add_reg(SPDIF_ChStCap4,'h34,"RW");
         spdif_reg_block_map.add_reg(SPDIF_ChStData4,'h38,"RO");
         spdif_reg_block_map.add_reg(SPDIF_ChStCap5,'h3c,"RW");
         spdif_reg_block_map.add_reg(SPDIF_ChStData5,'h40,"RO");
         spdif_reg_block_map.add_reg(SPDIF_ChStCap6,'h44,"RW");
         spdif_reg_block_map.add_reg(SPDIF_ChStData6,'h48,"RO");
         spdif_reg_block_map.add_reg(SPDIF_ChStCap7,'h4c,"RW");
         spdif_reg_block_map.add_reg(SPDIF_ChStData7,'h50,"RO");
         spdif_reg_block_map.add_reg(SPDIF_Receive_sample_data,'h54,"RO");
         spdif_reg_block_map.add_reg(SPDIF_Tx_Version,'h58,"RO");
         spdif_reg_block_map.add_reg(SPDIF_Tx_Config,'h5c,"RW");
         spdif_reg_block_map.add_reg(SPDIF_Tx_Ch_Stat,'h60,"RW");
         spdif_reg_block_map.add_reg(SPDIF_Tx_Int_Mask,'h64,"RW");
         spdif_reg_block_map.add_reg(SPDIF_Tx_Int_Stat,'h68,"RW");
         spdif_reg_block_map.add_reg(SPDIF_UserData,'h6c,"RW");
         spdif_reg_block_map.add_reg(SPDIF_ChStat,'h70,"RW");
         spdif_reg_block_map.add_reg(SPDIF_Transmit_sample_data,'h74,"RW");

         lock_model();
      endfunction
   endclass

endpackage
