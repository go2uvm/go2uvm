// Copyright (c) 2004-2017 VerifWorks, Bangalore, India
// http://www.verifworks.com 
// Contact: support@verifworks.com 
// 
// This program is part of Go2UVM at www.go2uvm.org
// Some portions of Go2UVM are free software.
// You can redistribute it and/or modify  
// it under the terms of the GNU Lesser General Public License as   
// published by the Free Software Foundation, version 3.
//
// VerifWorks reserves the right to obfuscate part or full of the code
// at any point in time. 
// We also support a comemrical licensing option for an enhanced version
// of Go2UVM, please contact us via support@verifworks.com
//
// This program is distributed in the hope that it will be useful, but 
// WITHOUT ANY WARRANTY; without even the implied warranty of 
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU 
// Lesser General Lesser Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public License
// along with this program. If not, see <http://www.gnu.org/licenses/>.

Readme for VW_Go2UVM_PKG
******************************

Goal:
-----
To provide easy-to-use interface for SVA developers, testers with UVM enabled testbench

Implementation
-----------------
Provided pakcgae in a package vw_go2uvm_pkg

How to use it?
----------------
1. Compile the package file vw_go2uvm_pkg.sv 
2. Import vw_go2uvm_pkg::* in your test file
3. Declare your test using macro: `G2U_TEST_BEGIN

All traces shall be driven through a pre-define task named main()


Please provide feedback via support@verifworks.com

How to run the example?
------------------------
cd run_dir
make cvc1 ; For Synopsys VCS
make cvc2 ; For Mentor Questa
make cvc3 ; For Cadence IUS
make cvc4 ; For Aldec

