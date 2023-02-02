VCS ?= vcs

TOP = vw_go2uvm_sim_utils apb2_master_tb_dut_top
TEST = apb2_master_rand_test

clean:
	rm -fr csrc* DVE* scsim* led* simv* ucli* inter*  work* *.cm *.daidir *.h vsim.wlf transcript INCA* *.log *.vstf *.key waves.shm dataset* *.cfg .athdl* *.txt* athdl_sv* *~* *.db* compile *.awc .simvision*

cvc1:clean
	$(VCS) -timescale=1ns/1ns -sverilog -debug_all -lca -ntb_opts uvm-1.1 -f flist_uvm -l comp.log
	./simv +UVM_TESTNAME=apb2_master_rand_test +UVM_VERBOSITY=UVM_FULL -l apb2_master_vcs.log

cvc1_gui:clean
	./simv +UVM_TESTNAME=apb2_master_rand_test +UVM_VERBOSITY=UVM_HIGH -l apb2_master_vcs.log -gui &


cvc2:clean
	vlib work
	vlog +acc -sv -mfcu -f flist_uvm +define+VW_PIP_SIM
	vsim -c -assertdebug -novopt +UVM_TESTNAME=apb2_master_rand_test +UVM_VERBOSITY=UVM_HIGH apb2_master_tb_dut_top -do "run -a;quit" -l apb2_master_qsta.log


cvc2_gui:clean
	vlib work
	vlog +acc -sv -mfcu -f flist_uvm +define+VW_PIP_SIM+VERBOSE
	vsim -assertdebug -novopt +UVM_TESTNAME=apb2_master_rand_test +UVM_VERBOSITY=UVM_HIGH apb2_master_tb_dut_top -do "add wave sim:/apb2_master_tb_dut_top/apb2_master_if_0/*; run -a;coverage save -cvg fcover.ucdb"
	vcover report -html fcover.ucdb
	firefox covhtmlreport/index.html -l apb2_master_qsta.log

cvc3:clean
	irun -access +rw -uvm -f flist_uvm +UVM_TESTNAME=apb2_master_rand_test +UVM_VERBOSITY=UVM_HIGH -coverage all -l apb2_master_cad.log

cvc3_gui:clean
	irun -access +rw -uvm -f flist_uvm +UVM_TESTNAME=apb2_master_rand_test +UVM_VERBOSITY=UVM_HIGH -coverage all -l apb2_master_cad.log -gui &

gen_rvra_do:
	touch go2uvm_rvra.do
	echo "clear" > go2uvm_rvra.do
	echo "alib work" >> go2uvm_rvra.do
	echo "adel -all " >> go2uvm_rvra.do
	echo "transcript file go2uvm_comp.log" >> go2uvm_rvra.do
	echo "set VW_GO2UVM_HOME $(VW_GO2UVM_HOME)" >> go2uvm_rvra.do
	echo "alog -dbg \$$UVMCOMP -msg 0 -error_limit 1 -f flist" >> go2uvm_rvra.do
	echo "transcript file go2uvm_run.log" >> go2uvm_rvra.do
	echo "asim +access +rw \$$UVMSIM $(TOP) +UVM_TESTNAME=$(TEST) +UVM_VERBOSITY=UVM_HIGH" >> go2uvm_rvra.do
	echo "run -all " >> go2uvm_rvra.do
	echo "exit " >> go2uvm_rvra.do

cvc4:clean gen_rvra_do
	vsim -c -do go2uvm_rvra.do

cvc4_gui:clean gen_rvra_do
	vsim -do go2uvm_rvra.do

