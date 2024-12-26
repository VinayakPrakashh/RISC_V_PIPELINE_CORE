module decode_cycle (
   input clk,rst,RegWriteW,
   input[4:0] RdW,
   input [31:0] InstrD,PCD,PCPlus4D,ResultW,
   output [31:0] RD1_E,RD2_E,ImmExtE,PCE,PCPlus4E,
   output [4:0] RdE,
   output RegWriteE,MemWriteE,JumpE,jalrE,BranchE,ALUSrcE,
   output [2:0] ALUControlE,
   output [1:0] ResultSrcE
);
wire [1:0] ImmSrcD,ResultSrcD;
wire [31:0] RD1_D,RD2_D,ImmExtD,rs1,rs2;
wire RegWriteD,MemWriteD,JumpD,jalrD,BranchD,ALUSrcD;
wire [2:0] ALUControlD;
wire [2:0] funct3;
wire funct7b5;
wire [6:0] op;

reg [31:0] RD1_D_r,RD2_D_r,PCD_r,PCPlus4D_r,ImmExtD_r;
reg RegWriteD_r,MemWriteD_r,JumpD_r,jalrD_r,BranchD_r,ALUSrcD_r;
reg [2:0] ALUControlD_r;
reg [1:0] ResultSrcD_r;
reg [4:0] RD_D_r;

controller c(op,funct3,funct7b5,ResultSrcD,MemWriteD,ALUSrcD,RegWriteD,JumpD,jalrD,BranchD,ImmSrcD,ALUControlD);
reg_file r1(clk,RegWriteW,rs1,rs2,RdW,ResultW,RD1_D,RD2_D);
imm_extend imm( InstrD[31:7], ImmSrcD,ImmExtD);

assign funct3 = InstrD[14:12];
assign funct7b5 = InstrD[30];
assign op = InstrD[6:0];
assign rs1 = InstrD[19:15];
assign rs2 = InstrD[24:20];
always @(posedge clk or posedge rst) begin
    if(rst) begin
        RD1_D_r <= 0;
        RD2_D_r <= 0;
        RD_D_r <= 0;
        PCD_r <= 0;
        PCPlus4D_r <= 0;
        ImmExtD_r <= 0;
        RegWriteD_r <= 0;
        MemWriteD_r <= 0;
        JumpD_r <= 0;
        jalrD_r <= 0;
        BranchD_r <= 0;
        ALUSrcD_r <= 0;
        ResultSrcD_r <= 0;
        ALUControlD_r <= 0;
    end
    else begin
        RD1_D_r <= RD1_D;
        RD2_D_r <= RD2_D;
        RD_D_r <= InstrD[11:7];
        PCD_r <= PCD;
        PCPlus4D_r <= PCPlus4D;
        ImmExtD_r <= ImmExtD;
        RegWriteD_r <= RegWriteD;
        MemWriteD_r <= MemWriteD;
        JumpD_r <= JumpD;
        jalrD_r <= jalrD;
        BranchD_r <= BranchD;
        ALUSrcD_r <= ALUSrcD;
        ResultSrcD_r <= ResultSrcD;
        ALUControlD_r <= ALUControlD;
    end
end
assign RD1_E = RD1_D_r;
assign RD2_E = RD2_D_r;
assign ImmExtE = ImmExtD_r;
assign PCE = PCD_r;
assign PCPlus4E = PCPlus4D_r;
assign RdE = RD_D_r;
assign RegWriteE = RegWriteD_r;
assign MemWriteE = MemWriteD_r;
assign JumpE = JumpD_r;
assign jalrE = jalrD_r;
assign BranchE = BranchD_r;
assign ALUSrcE = ALUSrcD_r;
assign ALUControlE = ALUControlD_r;
assign ResultSrcE = ResultSrcD_r;


endmodule