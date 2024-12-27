module riscv_top (
    input clk,rst,RegWriteW,PCSrcE,
    input [31:0] PCTragetE,ResultW,
    input [4:0] RdW,
    output [31:0] PCE,PCPlus4E,ImmExtE,RD1_E,RD2_E,
    output [4:0] RdE,
    output RegWriteE,MemWriteE,JumpE,jalrE,BranchE,ALUSrcE,
    output [2:0] ALUControlE,
    output [1:0] ResultSrcE
);

wire [31:0] InstrD,PCD,PCPlus4D,InstrE;

fetch_cycle fc(clk,rst,PCSrcE,PCTragetE,InstrD,PCD,PCPlus4D);

decode_cycle dc(clk,rst,RegWriteW,RdW,InstrD,PCD,PCPlus4D,ResultW,RD1_E,RD2_E,ImmExtE,PCE,PCPlus4E,InstrE,RdE,RegWriteE,MemWriteE,JumpE,jalrE,BranchE,ALUSrcE,ALUControlE,ResultSrcE);

endmodule
