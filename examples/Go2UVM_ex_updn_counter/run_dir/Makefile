questa: clean
	vlib work
	vlog -sv -f flist
	vsim -c go2uvm_count -do "run -all;quit"

rvra: clean
	vsim -c -do rvra_run.do
cdn:  clean
	irun -sv -uvm -f flist -incdir ../ref
clean:
	rm -fr work* compile qver* *.wlf *.log *.asdb *.cfg transc* INCA* irun*
