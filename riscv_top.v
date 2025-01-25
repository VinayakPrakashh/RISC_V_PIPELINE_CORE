module riscv_top (
    input clk,rst
);
wire [31:0] PCTargetE;
wire PCSrcE,Jalr;
wire  [31:0] InstrD,PCD,PCPlus4D,InstrE;

wire  [31:0] PCE,PCPlus4E,ImmExtE,RD1_E,RD2_E;
wire [4:0] RdE;
wire RegWriteE,MemWriteE,JumpE,BranchE,ALUSrcE;
wire [2:0] ALUControlE;
wire [1:0] ResultSrcE;

wire RegWriteM,MemWriteM;
wire [1:0] ResultSrcM;
wire [31:0] WriteDataM,ALUResultM,PCPlus4M,InstrM;
wire [4:0] RdM;
wire [4:0] Rd;

wire [1:0] ResultSrcW;
wire [31:0] ReadDataW,ALUResultW,PCPlus4W;
wire RegWriteW;
wire [4:0] RdW;

wire [31:0] ResultW,rs1,rs2;
wire RegWrite;
wire [31:0] RD1_D,RD2_D;
wire [4:0] rs1_addr_E,rs2_addr_E,Rs1D,Rs2D;
wire [1:0] ForwardAE,ForwardBE;
wire StallF,StallD,FlushE,FlushD;

fetch_cycle fc(clk,rst,PCSrcE,PCTargetE,InstrD,PCD,PCPlus4D,StallF,StallD,FlushD);

decode_cycle dc(clk,rst,InstrD,PCD,PCPlus4D,RD1_D,RD2_D,RD1_E,RD2_E,ImmExtE,PCE,PCPlus4E,InstrE,RdE,RegWriteE,MemWriteE,JumpE,Jalr,BranchE,ALUSrcE,ALUControlE,ResultSrcE,rs1,rs2,rs1_addr_E,rs2_addr_E,Rs1D,Rs2D,FlushE);
reg_file r1(clk,RegWriteW,rs1,rs2,RdW,ResultW,RD1_D,RD2_D);

execute_cycle ec(clk,rst,InstrE,RD1_E,RD2_E,PCE,ImmExtE,PCPlus4E,RdE,RegWriteE,MemWriteE,JumpE,Jalr,BranchE,ALUSrcE,ALUControlE,ResultSrcE,PCTargetE,WriteDataM,ALUResultM,PCPlus4M,InstrM,RdM,RegWriteM,MemWriteM,ResultSrcM,PCSrcE,JalrE,ForwardAE,ForwardBE,ResultW);

memory_cycle mc(clk,rst,RegWriteM,MemWriteM,ResultSrcM,WriteDataM,ALUResultM,PCPlus4M,InstrM,RdM,RegWriteW,ResultSrcW,ReadDataW,ALUResultW,PCPlus4W,RdW);

writeback_cycle wc(clk,rst,ResultSrcW,ReadDataW,ALUResultW,PCPlus4W,ResultW);

hazard_unit hu(rst,RegWriteM,RegWriteW,RdM,RdW,rs1_addr_E,rs2_addr_E,ForwardAE,ForwardBE,ResultSrcE,Rs1D,Rs2D,RdE,StallF,StallD,FlushE,PCSrcE,FlushD);

endmodule

