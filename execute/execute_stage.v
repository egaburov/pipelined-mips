`ifndef MIPS_H
`include "../mips.h"
`endif

`ifndef EXECUTE_STAGE
`define EXECUTE_STAGE

// This module encapsulates the entire execute stage.
module execute_stage(clk, FlushE, RegWriteD, MemtoRegD, MemWriteD, ALUControlD,
	ALUSrcD, RegDstD, RD1, RD2, RsD, RtD, RdD, SignImmD,
	RegWriteE, MemtoRegE, MemWriteE, ALUControlE, ALUSrcE, RegDstE,
	RD1E, RD2E, RsE, RtE, RdE, SignImmE);

	// The clock.
	input wire clk;

	// The flag from the Hazard Unit raised when this pipeline stage should be
	// flushed.
	input wire FlushE;

	/*** The following inputs are fed from the Decode pipeline stage ***/

	// The control signal denoting whether a register is written to.
	input wire RegWriteD;

	// The control signal denoting whether data is being written from
	// memory to a register.
	input wire MemtoRegD;

	// The control signal denoting whether main memory is being written to.
	input wire MemWriteD;

	// The four-bit ALU op denoting which operation the ALU should perform.
	input wire [3:0] ALUControlD;

	// The control signal denoting whether the ALU input is an immediate value.
	input wire ALUSrcD;

	// The control signal denoting whether the write reg is rd (R-type instr).
	input wire RegDstD;

	// The data read from the first source register (rs).
	input wire [31:0] RD1;

	// The data read from the second source register (rt).
	input wire [31:0] RD2;

	// The first source register.
	input wire [4:0] RsD;

	// The second source register.
	input wire [4:0] RtD;

	// The destination register.
	input wire [4:0] RdD;

	// The sign-extended immediate value.
	input wire [31:0] SignImmD;

	/*** The following outputs are generated by the Execute pipeline stage ***/

	// The control signal denoting whether a register is written to.
	output reg RegWriteE;

	// The control signal denoting whether data is being written from
	// memory to a register.
	output reg MemtoRegE;

	// The control signal denoting whether main memory is being written to.
	output reg MemWriteE;

	// The four-bit ALU op denoting which operation the ALU should perform.
	output reg [3:0] ALUControlE;

	// The control signal denoting whether the ALU input is an immediate value.
	output reg ALUSrcE;

	// The control signal denoting whether the write reg is rd (R-type instr).
	output reg RegDstE;

	// The data read from the first source register (rs).
	output reg [31:0] RD1E;

	// The data read from the second source register (rt).
	output reg [31:0] RD2E;

	// The first source register.
	output reg [4:0] RsE;

	// The second source register.
	output reg [4:0] RtE;

	// The destination register.
	output reg [4:0] RdE;

	// The sign-extended immediate value.
	output reg [31:0] SignImmE;

	// One of five pipeline stages that is synchronized with the rising edge of
	// the clock.
	always @(posedge clk)
	begin
		// If the flush signal is raised by the Hazard Unit, reset all outputs.
		if (FlushE)
		begin
			RegWriteE <= 0;
			MemtoRegE <= 0;
			MemWriteE <= 0;
			ALUControlE <= `ALU_undef;
			ALUSrcE <= 0;
			RegDstE <= 0;
			RD1E <= 0;
			RD2E <= 0;
			RsE <= 0;
			RtE <= 0;
			RdE <= 0;
			SignImmE <= 0;
		end
		// Else propagate the values from the Decode stage further along the
		// pipeline.
		else
		begin
			RegWriteE <= RegWriteD;
			MemtoRegE <= MemtoRegD;
			MemWriteE <= MemWriteD;
			ALUControlE <= ALUControlD;
			ALUSrcE <= ALUSrcD;
			RegDstE <= RegDstD;
			RD1E <= RD1;
			RD2E <= RD2;
			RsE <= RsD;
			RtE <= RtD;
			RdE <= RdD;
			SignImmE <= SignImmD;
		end
	end

endmodule
`endif
