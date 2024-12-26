module decode_cycle (
   input clk,rst,RegWriteW,
   input[4:0] RdW,
   input [31:0] InstrD,PCD,PCPlus4D,ResultW,
   output [31:0] RD1_E,RD2_E,ImmExtE,PCE,PCPlus4E,
   output [4:0] RdE
);
wire [1:0] ImmSrcD;
wire [31:0] RD1_D,RD2_D,ImmExtD;

reg [31:0] RD1_D_r,RD2_D_r,RD_D_r,PCD_r,PCPlus4D_r,ImmExtD_r;

reg_file r1(clk,RegWriteW,InstrD[19:15],InstrD[24:20],RdW,ResultW,RD1_D,RD2_D);
imm_extend imm( InstrD[31:7], ImmSrcD,ImmExtD);

always @(posedge clk or posedge rst) begin
    if(rst) begin
        RD1_D_r <= 0;
        RD2_D_r <= 0;
        RD_D_r <= 0;
        PCD_r <= 0;
        PCPlus4D_r <= 0;
        ImmExtD_r <= 0;
    end
    else begin
        RD1_D_r <= RD1_D;
        RD2_D_r <= RD2_D;
        RD_D_r <= InstrD[11:7];
        PCD_r <= PCD;
        PCPlus4D_r <= PCPlus4D;
        ImmExtD_r <= ImmExtD;
    end
end
assign RD1_E = RD1_D_r;
assign RD2_E = RD2_D_r;
assign ImmExtE = ImmExtD_r;
assign PCE = PCD_r;
assign PCPlus4E = PCPlus4D_r;
assign RdE = RD_D_r;

endmodule