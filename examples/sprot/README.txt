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
Simply compile the package file vw_go2uvm-pkg.sv and derive your test from go2uvm_base_test

All traces shall be driven through a pre-define task named main()


Please provide feedback via support@verifworks.com

How to run the example?
------------------------
cd run_dir
make cdn --> To run in Cadence IUS
make questa  --> To run with Mentor's Questa
make rvra --> To run with Aldec's Riviera-Pro





