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


Go2UVM approach to writing register wr-rd tests for RTL Designers
******************************************************************

Problem statement:
==================
RTL Designers need a simple way to write register access tests in UVM framework. 

Assumptions:
============

1. Register specificaiton is available as IP-XACT (IEEE std.) XML format. 
2. RTL designers have access to a tool that converts IP-XAACT/Reg Spec to UVM-Registers code 

3. RTL deisgners have simple BFM - a throw-away like code to mimic protocols. For complex trasnfers, a sophisticated VIP/UVC may be needed.

Approach:
=========
1. Generate UVM reg model from IP-XACT
2. Generate a template UVM tesbench/env through a tool/script (An open-source version may be made availabel soon for this via www.go2uvm.org)

3. The skeleton UVM structure has a dummy driver that calls "virtual_interface.write/read tasks"

4. User fills in write() and read() inside interface(s)
5. User writes a test in UVM framework

Demo:
=====

Design has 2 registers. Uses a simple bus named vlb (VLBus)

Dir: dut_src/

Dir: auto_gen_code/

  Contains generated files (generic, can work for any protocol, no fancy address adaptation (can be extended if needed) including go2uvm testbench and UVM-Registers

Dir: rtl_desigers_test_src/

RTL Designers are expected to create the files under this dir. See file:
   rtl_desigers_test_src/vlb_g2u_wr_rd_test.sv

How to run the demo:
====================
cd run_dir
make cvc1 (For VCS)
make cvc2 (For Questa)
make cvc3 (For IUS)
make cvc4 (For Aldec Riviera-Pro)




