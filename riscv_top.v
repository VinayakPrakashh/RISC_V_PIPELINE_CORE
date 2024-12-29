module riscv_top (
    input clk,rst,RegWrite,
    input [31:0] ResultW,
    output [1:0] ResultSrcW,
    output [31:0] ReadDataW,ALUResultW,PCPlus4W,
    output RegWriteW,
    output [4:0] RdW

);
wire [31:0] PCTargetE;
wire PCSrcE,Jalr;
wire [31:0] InstrD,PCD,PCPlus4D,InstrE;

wire [31:0] PCE,PCPlus4E,ImmExtE,RD1_E,RD2_E;
wire [4:0] RdE;
wire RegWriteE,MemWriteE,JumpE,BranchE,ALUSrcE;
wire [2:0] ALUControlE;
wire [1:0] ResultSrcE;

wire RegWriteM,MemWriteM;
wire [1:0] ResultSrcM;
wire [31:0] WriteDataM,ALUResultM,PCPlus4M,InstrM;
wire [4:0] RdM;
wire [4:0] Rd;

fetch_cycle fc(clk,rst,PCSrcE,PCTargetE,InstrD,PCD,PCPlus4D);

decode_cycle dc(clk,rst,RegWrite,Rd,InstrD,PCD,PCPlus4D,ResultW,RD1_E,RD2_E,ImmExtE,PCE,PCPlus4E,InstrE,RdE,RegWriteE,MemWriteE,JumpE,Jalr,BranchE,ALUSrcE,ALUControlE,ResultSrcE);

execute_cycle ec(clk,rst,InstrE,RD1_E,RD2_E,PCE,ImmExtE,PCPlus4E,RdE,RegWriteE,MemWriteE,JumpE,Jalr,BranchE,ALUSrcE,ALUControlE,ResultSrcE,PCTargetE,WriteDataM,ALUResultM,PCPlus4M,InstrM,RdM,RegWriteM,MemWriteM,ResultSrcM,PCSrcE,JalrE);

memory_cycle mc(clk,rst,RegWriteM,MemWriteM,ResultSrcM,WriteDataM,ALUResultM,PCPlus4M,InstrM,RdM,RegWriteW,ResultSrcW,ReadDataW,ALUResultW,PCPlus4W,RdW);

endmodule
