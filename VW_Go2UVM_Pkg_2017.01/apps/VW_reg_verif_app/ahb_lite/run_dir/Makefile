#* Copyright (c) 2004-2017 VerifWorks, Bangalore, India
#* http://www.verifworks.com 
#* Contact: support@verifworks.com 
#* 
#* This program is part of Go2UVM at www.go2uvm.org
#* Some portions of Go2UVM are free software.
#* You can redistribute it and/or modify  
#* it under the terms of the GNU Lesser General Public License as   
#* published by the Free Software Foundation, version 3.
#*
#* VerifWorks reserves the right to obfuscate part or full of the code
#* at any point in time. 
#* We also support a comemrical licensing option for an enhanced version
#* of Go2UVM, please contact us via support@verifworks.com
#
#* This program is distributed in the hope that it will be useful, but 
#* WITHOUT ANY WARRANTY; without even the implied warranty of 
#* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU 
#* Lesser General Lesser Public License for more details.
#*
#* You should have received a copy of the GNU Lesser General Public License
#* along with this program. If not, see <http://www.gnu.org/licenses/>.


# Generic Makefile for UVM build and run
# Developed and maintained by VerifWorks http://www.verifworks.com
# Windows (Cygwin) and Un*x Makefile 
# Copyright (C) 2014-2016 VerifWorks

# This program is free software; you can redistribute
# it and/or modify it under the terms of the APACHE 2.0 license

# Modify this to reflect your top module name
# You may also override it via command line i.e.
#   make cvc2 TOP=my_chip_uvm_tb_top

TOP = g2u_reg_tb_dut_top

# Modify this to reflect your test name
# You may also override it via command line i.e.
#   make cvc2 TEST=my_uvm_test

TEST = g2u_reg_hw_reset_test
# TEST = g2u_reg_bit_bash_test
# TEST = vlb_g2u_wr_rd_test

clean:
	rm -fr csrc* DVE* scsim* led* simv* ucli* inter*  work* *.cm *.daidir *.h vsim.wlf transcript INCA* *.log *.vstf *.key waves.shm dataset* *.cfg .athdl* *.txt* athdl_sv* *~* *.db* compile *.awc .simvision* cov_work*

cvc1:clean
	vcs -sverilog -debug_all -lca -ntb_opts uvm-1.1 -f flist -l go2uvm_comp.log -assert svaext -timescale=1ns/1ns
	./simv +UVM_TESTNAME=$(TEST) +UVM_VERBOSITY=UVM_HIGH -l go2uvm_run.log

cvc1_gui:clean
	vcs -sverilog -debug_all -lca -ntb_opts uvm-1.1 -f flist -l go2uvm_comp.log -assert svaext -timescale=1ns/1ns
	./simv +UVM_TESTNAME=$(TEST) +UVM_VERBOSITY=UVM_HIGH -l go2uvm_run.log -gui &

cvc2:clean
	vlib work
	vlog  +acc -sv -mfcu -timescale 1ns/1ns  -f flist -l go2uvm_comp.log
	vsim -c +access +rw $(TOP) +UVM_TESTNAME=$(TEST) +UVM_VERBOSITY=UVM_HIGH  -do "run -all;"|tee go2uvm_run.log
 

cvc2_gui:clean
	vlib work
	vlog  +acc -mfcu -sv -f flist  -l go2uvm_comp.log
	vsim +access +r $(TOP)  +UVM_TESTNAME=$(TEST) +UVM_VERBOSITY=UVM_HIGH  -do "run -all;" -l  go2uvm_run.log


cvc3:clean
	irun -access +rw -uvm -f flist +UVM_TESTNAME=$(TEST) +UVM_VERBOSITY=UVM_HIGH -l go2uvm_run.log 

cvc3_gui:clean
	irun -access +rw -uvm -f flist +UVM_TESTNAME=$(TEST) +UVM_VERBOSITY=UVM_HIGH -l go2uvm_run.log -gui &


gen_rvra_do:
	touch go2uvm_rvra.do
	echo "clear" > go2uvm_rvra.do
	echo "alib work" >> go2uvm_rvra.do
	echo "adel -all " >> go2uvm_rvra.do
	echo "transcript file go2uvm_comp.log" >> go2uvm_rvra.do
	echo "alog -dbg \$$UVMCOMP -msg 0 -error_limit 1 -f flist" >> go2uvm_rvra.do
	echo "transcript file go2uvm_run.log" >> go2uvm_rvra.do
	echo "asim +access +rw \$$UVMSIM $(TOP) +UVM_TESTNAME=$(TEST) +UVM_VERBOSITY=UVM_HIGH" >> go2uvm_rvra.do
	echo "run -all " >> go2uvm_rvra.do
	echo "exit " >> go2uvm_rvra.do

cvc4:clean gen_rvra_do
	vsim -c -do go2uvm_rvra.do

cvc4_gui:clean gen_rvra_do
	vsim -do go2uvm_rvra.do

