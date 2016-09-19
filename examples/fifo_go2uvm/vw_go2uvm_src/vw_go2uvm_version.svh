`include "vw_enc_kw.v"
//----------------------------------------------------------------------
//   Copyright 2004-2014 VerifWorks a venture of CVC Pvt Ltd.  
//   All Rights Reserved Worldwide
//   
//   Licensed under the Apache License, Version 2.0 (the"License");
// you may not use this file except in
//   compliance with the License.  You may obtain a copy of
//   the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in
//   writing, software distributed under the License is
//   distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
//   CONDITIONS OF ANY KIND, either express or implied.  See
//   the License for the specific language governing
//   permissions and limitations under the License.
//----------------------------------------------------------------------
//
 // Protect against multiple inclusion of this file
 //
 `ifndef VW_Go2UVM_VERSION_SV
 `define VW_Go2UVM_VERSION_SV

 // /////////////////////////////////////////////
 // Class: vw_go2uvm_version
 // Base class for defining VW_Go2UVM Stdlib versions
 // Use model
 // |
 // | string get_ver;
 // | vw_go2uvm_version g2u_ver;
 // |
 // | initial begin : print_ver
 // |   g2u_ver = new ();
 // |   get_ver = g2u_ver.psdisplay();
 // |   `uvm_info ("Go2UVM", get_ver, UVM_MEDIUM);
 // | end : print_ver

 class vw_go2uvm_version;
  extern function int get_major_ver();
  extern function string get_sub_ver();
  extern function int get_vw_g2u_ver();
  extern function string get_vendor();

  extern function void display(string prefix = "");
  extern function string psdisplay(string prefix = "");
  endclass: vw_go2uvm_version

 // ////////////////////////////////////////////
 // function : get_major_ver
 //
 // Returns the get_major_ver version number of the implemented VW_Go2UVM Standard Library. Should always
 // return 1.
 //
 function int vw_go2uvm_version::get_major_ver();
  get_major_ver = 1;
 endfunction : get_major_ver

  // ////////////////////////////////////////////
  // function : get_sub_ver
  //
  // Returns the get_sub_ver version number of the implemented VW_Go2UVM Standard Library. Should always
  // return 10, if the additions and updates specified in this package are fully implemented.
  //
  //
  function string vw_go2uvm_version::get_sub_ver();
   get_sub_ver = "1d";
  endfunction : get_sub_ver

  // ////////////////////////////////////////////
  // function : get_vw_g2u_ver
  //
  // Returns the get_vw_g2u_ver number of the implemented VW_Go2UVM Standard Library. The returned value
  // is get_vendor-dependent.
  //
 function int vw_go2uvm_version::get_vw_g2u_ver();
  get_vw_g2u_ver = 5;
 endfunction : get_vw_g2u_ver


 function string vw_go2uvm_version::get_vendor();
  get_vendor = "Verifworks http://www.verifworks.com ";
 endfunction : get_vendor

 // ////////////////////////////////////////////
 // function : display
 //
 // Displays the version image returned by the psdisplay() method, to the standard output.
 //
 // The argument prefix is used to append a string to the content displayed by this method.
 //
 //
 function void vw_go2uvm_version::display(string prefix = "");
$write("%s\n", this.psdisplay(prefix));
 endfunction : display

 // ////////////////////////////////////////////
 // function : psdisplay
 //
 // Creates a well formatted image of the VW_Go2UVM Standard Library implementation version
 // information. The format is:
 // prefix VW_Go2UVM Version get_major_ver.get_sub_ver.get_vw_g2u_ver (get_vendor)
 //
 function string vw_go2uvm_version::psdisplay(string prefix = "");
   $sformat(psdisplay, "%s VW_Go2UVM Version %0d.%s.%0d (%s)",
   prefix, this.get_major_ver(), this.get_sub_ver(), this.get_vw_g2u_ver(),this.get_vendor());
 endfunction : psdisplay
`endif // VW_Go2UVM_VERSION_SV
