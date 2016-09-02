cdn: clean
	irun -sv -uvm -f flist
questa: clean
	qverilog -mfcu -f flist

rvra: clean
	vsim -c -do rvra_run.do

clean:
	rm -fr work* compile qver* *.wlf *.log *.asdb *.cfg transc* INCA* irun*
