WARNS = -Wimplicit -Wportbind
VERSION = -g2005

all: testbench

execute_test:
	iverilog -o ex_test.out -I../ $(WARNS) $(VERSION) ex_test.v
	./ex_test.out

cpu_compile:
	echo Note: This only compiles for syntax checking.
	iverilog -o cpu.out $(WARNS) $(VERSION) cpu.v

testbench:
	iverilog -o testbench.out $(WARNS) $(VERSION) testbench.v
	./testbench.out

clean:
	rm *.out *.dump
