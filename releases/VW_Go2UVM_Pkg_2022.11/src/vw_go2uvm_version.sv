/* 
* Copyright (c) 2004-2017 VerifWorks, Bangalore, India
* http://www.verifworks.com 
* Contact: support@verifworks.com 
* 
* This program is part of Go2UVM at www.go2uvm.org
* Some portions of Go2UVM are free software.
* You can redistribute it under the terms of the 
* GNU Lesser General Public License as   
* published by the Free Software Foundation, version 3 and provided
* that this original copyright is retained intact
*
* VerifWorks reserves the right to obfuscate part or full of the code
* at any point in time. You are not allowed to decrypt or reverse-engineer
* this code without explicit, written permission from the original authors
* 
* We also support a commerical licensing option for an enhanced version
* of Go2UVM, please contact us via support@verifworks.com

* This program is distributed in the hope that it will be useful, but 
* WITHOUT ANY WARRANTY; without even the implied warranty of 
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU 
* Lesser General Lesser Public License for more details.
*
* You should have received a copy of the GNU Lesser General Public License
* along with this program. If not, see <http://www.gnu.org/licenses/>.
*/



 
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
 // ////////////////////////////////////////////
 // function : get_major_ver
 //
 // Returns the get_major_ver version number of the implemented VW_Go2UVM Standard Library. Should always
 // return 1.
 //
 function string vw_go2uvm_version::get_major_ver();
  get_major_ver = "1";
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
 function string vw_go2uvm_version::get_vw_g2u_ver();
  get_vw_g2u_ver = "2022.11";
 endfunction : get_vw_g2u_ver
 
 
 function string vw_go2uvm_version::get_vendor();
  get_vendor = "VerifWorks http://www.verifworks.com ";
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
  $sformat(psdisplay, "%s VW_Go2UVM Version %s.%s.%s (%s)",
  prefix, this.get_major_ver(), this.get_sub_ver(), this.get_vw_g2u_ver(),this.get_vendor());
 endfunction : psdisplay

