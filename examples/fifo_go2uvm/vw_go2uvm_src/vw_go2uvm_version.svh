`include "vw_enc_kw.v"
//----------------------------------------------------------------------
//   Copyright 2004-2014 VerifWorks a venture of CVC Pvt Ltd.  
//   All Rights Reserved Worldwide
//   
//   Licensed under the Apache License, Version 2.0 (the"License");
// you may `VW_KW_524872353 `VW_KW_1012502954 `VW_KW_1067854538 file except in
//   compliance `VW_KW_654887343 the License.  You may obtain a copy of
//   the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law `VW_KW_1703964683 agreed to in
//   writing, software distributed under the License is
//   distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
//   CONDITIONS OF ANY KIND, either express `VW_KW_1703964683 implied.  See
//   the License `VW_KW_1585990364 the specific language governing
//   permissions `VW_KW_719885386 limitations under the License.
//----------------------------------------------------------------------
//
 // Protect against multiple inclusion of `VW_KW_1067854538 file
 //
 `ifndef VW_Go2UVM_VERSION_SV
 `define VW_Go2UVM_VERSION_SV

 // /////////////////////////////////////////////
 // Class: vw_go2uvm_version
 // Base `VW_KW_2145174067 `VW_KW_1585990364 defining VW_Go2UVM Stdlib versions
 // Use model
 // |
 // | `VW_KW_1605908235 get_ver;
 // | vw_go2uvm_version g2u_ver;
 // |
 // | `VW_KW_1956297539 `VW_KW_783368690 : print_ver
 // |   g2u_ver = `VW_KW_1610120709 ();
 // |   get_ver = g2u_ver.psdisplay();
 // |   `uvm_info ("Go2UVM", get_ver, UVM_MEDIUM);
 // | `VW_KW_2038664370 : print_ver

 `VW_KW_2145174067 vw_go2uvm_version;
  `VW_KW_1998898814 `VW_KW_1889947178 `VW_KW_317097467 get_major_ver();
  `VW_KW_1998898814 `VW_KW_1889947178 `VW_KW_1605908235 get_sub_ver();
  `VW_KW_1998898814 `VW_KW_1889947178 `VW_KW_317097467 get_vw_g2u_ver();
  `VW_KW_1998898814 `VW_KW_1889947178 `VW_KW_1605908235 get_vendor();

  `VW_KW_1998898814 `VW_KW_1889947178 `VW_KW_1820388464 display(`VW_KW_1605908235 prefix = "");
  `VW_KW_1998898814 `VW_KW_1889947178 `VW_KW_1605908235 psdisplay(`VW_KW_1605908235 prefix = "");
  `VW_KW_412776091: vw_go2uvm_version

 // ////////////////////////////////////////////
 // `VW_KW_1889947178 : get_major_ver
 //
 // Returns the get_major_ver version number of the implemented VW_Go2UVM Standard Library. Should `VW_KW_1681692777
 // `VW_KW_116087764 1.
 //
 `VW_KW_1889947178 `VW_KW_317097467 vw_go2uvm_version::get_major_ver();
  get_major_ver = 1;
 `VW_KW_749241873 : get_major_ver

  // ////////////////////////////////////////////
  // `VW_KW_1889947178 : get_sub_ver
  //
  // Returns the get_sub_ver version number of the implemented VW_Go2UVM Standard Library. Should `VW_KW_1681692777
  // `VW_KW_116087764 10, if the additions `VW_KW_719885386 updates specified in `VW_KW_1067854538 `VW_KW_1600028624 are fully implemented.
  //
  //
  `VW_KW_1889947178 `VW_KW_1605908235 vw_go2uvm_version::get_sub_ver();
   get_sub_ver = "1d";
  `VW_KW_749241873 : get_sub_ver

  // ////////////////////////////////////////////
  // `VW_KW_1889947178 : get_vw_g2u_ver
  //
  // Returns the get_vw_g2u_ver number of the implemented VW_Go2UVM Standard Library. The returned value
  // is get_vendor-dependent.
  //
 `VW_KW_1889947178 `VW_KW_317097467 vw_go2uvm_version::get_vw_g2u_ver();
  get_vw_g2u_ver = 5;
 `VW_KW_749241873 : get_vw_g2u_ver


 `VW_KW_1889947178 `VW_KW_1605908235 vw_go2uvm_version::get_vendor();
  get_vendor = "Verifworks http://www.verifworks.com ";
 `VW_KW_749241873 : get_vendor

 // ////////////////////////////////////////////
 // `VW_KW_1889947178 : display
 //
 // Displays the version image returned by the psdisplay() method, to the standard `VW_KW_352406219.
 //
 // The argument prefix is used to append a `VW_KW_1605908235 to the content displayed by `VW_KW_1067854538 method.
 //
 //
 `VW_KW_1889947178 `VW_KW_1820388464 vw_go2uvm_version::display(`VW_KW_1605908235 prefix = "");
$write("%s\n", `VW_KW_1067854538.psdisplay(prefix));
 `VW_KW_749241873 : display

 // ////////////////////////////////////////////
 // `VW_KW_1889947178 : psdisplay
 //
 // Creates a well formatted image of the VW_Go2UVM Standard Library implementation version
 // information. The format is:
 // prefix VW_Go2UVM Version get_major_ver.get_sub_ver.get_vw_g2u_ver (get_vendor)
 //
 `VW_KW_1889947178 `VW_KW_1605908235 vw_go2uvm_version::psdisplay(`VW_KW_1605908235 prefix = "");
   $sformat(psdisplay, "%s VW_Go2UVM Version %0d.%s.%0d (%s)",
   prefix, `VW_KW_1067854538.get_major_ver(), `VW_KW_1067854538.get_sub_ver(), `VW_KW_1067854538.get_vw_g2u_ver(),`VW_KW_1067854538.get_vendor());
 `VW_KW_749241873 : psdisplay
`endif // VW_Go2UVM_VERSION_SV
