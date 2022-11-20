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



 // Protect against multiple inclusion of this file
 //
 
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
  extern function string get_major_ver();
  extern function string get_sub_ver();
  extern function string get_vw_g2u_ver();
  extern function string get_vendor();
 
  extern function void display(string prefix = "");
  extern function string psdisplay(string prefix = "");
endclass: vw_go2uvm_version
 
