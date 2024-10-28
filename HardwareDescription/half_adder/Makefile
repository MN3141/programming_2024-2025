MAIN=main.vhd
BENCH=main_test_bench.vhd

all:
	ghdl -a $(MAIN) $(BENCH)
	ghdl -e Half_Adder_TB
	ghdl -r Half_Adder_TB --vcd=main.vcd

clean:
	rm *.vcd *.cf