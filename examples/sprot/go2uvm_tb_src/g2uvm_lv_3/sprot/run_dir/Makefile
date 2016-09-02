VCS ?= vcs

clean:
	rm -fr csrc* DVE* scsim* led* simv* ucli* inter*  work* *.cm *.daidir *.h vsim.wlf transcript INCA* *.log *.vstf *.key waves.shm dataset* *.cfg .athdl* *.txt* athdl_sv* *~* *.db* compile *.awc .simvision*

cvc1:clean
	$(VCS) -timescale=1ns/1ns -sverilog -debug_all -lca -ntb_opts uvm-1.1 -f flist_uvm -l comp.log
	./simv +UVM_TESTNAME=sprot_rand_test +UVM_VERBOSITY=UVM_FULL -l sprot_vcs.log

cvc1_gui:
	./simv +UVM_TESTNAME=sprot_rand_test +UVM_VERBOSITY=UVM_HIGH -l sprot_vcs.log -gui &


cvc2:clean
	vlib work
	vlog +acc -sv -mfcu -f flist_uvm 
	vsim -c -assertdebug -novopt +UVM_TESTNAME=sprot_rand_test +UVM_VERBOSITY=UVM_HIGH sprot_tb_dut_top -do "run -a;quit" -l sprot_qsta.log 


cvc2_gui:clean
	vlib work
	vlog +acc -sv -mfcu -f flist_uvm 
	vsim -assertdebug -novopt +UVM_TESTNAME=sprot_rand_test +UVM_VERBOSITY=UVM_HIGH sprot_tb_dut_top -do "add wave sim:/sprot_tb_dut_top/sprot_if_0/*; run -a;coverage save -cvg fcover.ucdb" 
	vcover report -html fcover.ucdb
	firefox covhtmlreport/index.html -l sprot_qsta.log

cvc3:clean
	irun -access +rw -uvm -f flist_uvm +UVM_TESTNAME=sprot_rand_test +UVM_VERBOSITY=UVM_HIGH -coverage all -l sprot_cad.log

cvc3_gui:clean
	irun -access +rw -uvm -f flist_uvm +UVM_TESTNAME=sprot_rand_test +UVM_VERBOSITY=UVM_HIGH -coverage all -l sprot_cad.log -gui &


cvc4:clean
	vsim -c -do rvra_run.do
	firefox fcover_report.html 

cvc4_gui:clean
	vsim -do rvra_run.do
