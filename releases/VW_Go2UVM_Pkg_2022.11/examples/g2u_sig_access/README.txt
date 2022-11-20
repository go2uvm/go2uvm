Readme for VW_Go2UVM_PKG - Sig Access utility
******************************

Goal:
-----
To provide easy-to-use UVM for RTL Designers and DV engineers. Specifically
this utility is intended to provide targeted force/deposit/release/value
features from a typical UVM sequence or test.


Implementation
-----------------
Provided pakcgae in a package vw_go2uvm_pkg

How to use it?
----------------
Simply compile the package file vw_go2uvm-pkg.sv and derive your test from go2uvm_base_test

All traces shall be driven through a pre-define task named main()


Please provide feedback via support@verifworks.com

Example for g2u_force usage
----------------------------

Goal: Force a signal inside DUT from a UVM test. Since SV restrcits
hierarchical accesses from inside a package (and there are signals in a mixed
language HDL designs not covered by Verilog's force), we need a VPI/PLI route.

See file: ../go2uvm_tb_src/sprot_go2uvm_test.sv
    Line: 39 g2u_force

How to run the example?
------------------------
cd run_dir
make cvc1 --> To run in Synopsys VCS
make cvc2 --> To run with Mentor's Questa
make cvc3 --> To run in Cadence IUS
make cvc4 --> To run with Aldec's Riviera-Pro





