module riscv_top (
    input clk,rst,RegWriteW,
    input [31:0] ResultW,
    input [4:0] RdW,
    output RegWriteM,MemWriteM,ResultSrcM,
    output [31:0] WriteDataM,ALUResultM,PCPlus4M,InstrM,
    output [4:0] RdM
);
wire [31:0] PCTargetE;

wire PCSrcE,Jalr;
wire [31:0] InstrD,PCD,PCPlus4D,InstrE;
wire [31:0] PCE,PCPlus4E,ImmExtE,RD1_E,RD2_E;
wire [4:0] RdE;
wire RegWriteE,MemWriteE,JumpE,BranchE,ALUSrcE;
wire [2:0] ALUControlE;
wire [1:0] ResultSrcE;

fetch_cycle fc(clk,rst,PCSrcE,PCTargetE,InstrD,PCD,PCPlus4D);

decode_cycle dc(clk,rst,RegWriteW,RdW,InstrD,PCD,PCPlus4D,ResultW,RD1_E,RD2_E,ImmExtE,PCE,PCPlus4E,InstrE,RdE,RegWriteE,MemWriteE,JumpE,Jalr,BranchE,ALUSrcE,ALUControlE,ResultSrcE);

execute_cycle ec(clk,rst,InstrE,RD1_E,RD2_E,PCE,ImmExtE,PCPlus4E,RdE,RegWriteE,MemWriteE,JumpE,Jalr,BranchE,ALUSrcE,ALUControlE,ResultSrcE,PCTargetE,WriteDataM,ALUResultM,PCPlus4M,InstrM,RdM,RegWriteM,MemWriteM,ResultSrcM,PCSrcE,JalrE);

endmodule
