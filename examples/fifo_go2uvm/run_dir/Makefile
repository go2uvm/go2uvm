TOP = go2uvm_fifo
TEST = 
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
	vsim -c +access +rw $(TOP) +UVM_TESTNAME=$(TEST) +UVM_VERBOSITY=UVM_HIGH  -novopt -do "run -all;"|tee go2uvm_comp_run.log
 

cvc2_gui:clean
	vlib work
	vlog  +acc -mfcu -sv -f flist  -l go2uvm_comp.log
	vsim +access +r $(TOP)  -novopt +UVM_TESTNAME=$(TEST) +UVM_VERBOSITY=UVM_HIGH  -do "run -all;" -l  go2uvm_run.log


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

