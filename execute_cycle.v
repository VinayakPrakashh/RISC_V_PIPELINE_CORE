module execute_cycle (
    input clk,rst,
    input [31:0] InstrE,RD1_E,RD2_E,PCE,ImmExtE,PCPlus4E,
    input [4:0] RdE,
    input  RegWriteE,MemWriteE,JumpE,Jalr,BranchE,ALUSrcE,
    input [2:0] ALUControlE,
    input [1:0] ResultSrcE,
    output [31:0] PCTargetE,WriteDataM,ALUResultM,PCPlus4M,InstrM,
    output [4:0] RdM,
    output RegWriteM,MemWriteM,
    output [1:0] ResultSrcM,
    output PCSrcE,JalrE
);
wire [31:0] SrcBE;
wire Takebranch,Zero;
wire [31:0] ALUResultE,PCTarget;

reg [31:0] ALUResultE_r,WriteDataE_r,PCTarget_r,PCPlus4E_r,InstrE_r;
reg [4:0] RdE_r;
reg RegWriteE_r,MemWriteE_r,ResultSrcE_r,JalrE_r;

mux2 srcmux(RD2_E,ImmExtE,ALUSrcE,SrcBE);
alu alu_main(RD1_E,SrcBE,ALUControlE,ALUResultE,Zero,InstrE[30],InstrE[12]);
branching_unit bu(ALUResultE[31],Zero,InstrE[14:12],Takebranch);
adder pctarget(PCE,ImmExtE,PCTarget);

assign PCSrcE = (Takebranch & BranchE) | JumpE;

always @(posedge clk or posedge rst) begin
    if(rst==1'b1) begin
        ALUResultE_r <= 0;
        WriteDataE_r <= 0;
        PCPlus4E_r <= 0;
        RdE_r <= 0;
        RegWriteE_r <= 0;
        MemWriteE_r <= 0;
        ResultSrcE_r <= 0;
        JalrE_r <= 0;
        InstrE_r <= 0;
        PCTarget_r <= 0;
    end
    else begin
        ALUResultE_r <= ALUResultE;
        WriteDataE_r <= RD2_E;
        PCPlus4E_r <= PCPlus4E;
        RdE_r <= RdE;
        RegWriteE_r <= RegWriteE;
        MemWriteE_r <= MemWriteE;
        ResultSrcE_r <= ResultSrcE;
        JalrE_r <= Jalr;
        InstrE_r <= InstrE;
        PCTarget_r <= PCTarget;
    end
end
assign ALUResultM = ALUResultE_r;
assign PCPlus4M = PCPlus4E_r;
assign WriteDataM = WriteDataE_r;
assign RdM = RdE_r;
assign RegWriteM = RegWriteE_r;
assign MemWriteM = MemWriteE_r;
assign ResultSrcM = ResultSrcE_r;
assign JalrE = JalrE_r;
assign InstrM = InstrE_r;
assign PCTargetE = PCTarget_r;

endmodule