module fetch_cycle (
    input clk,rst,PCSrcE,
    input [31:0] PCTragetE,
    output [31:0] InstrD,PCD,PCPlus4D,
    input StallF,StallD,FlushD
);
wire [31:0] PC_F,PCF,PCPlus4F,InstrF;
reg [31:0] InstrF_reg,PCF_reg,PCPlus4F_reg;

mux2 pcmux(PCPlus4F,PCTragetE,PCSrcE,PC_F);
reset_ff PC(clk,rst,PC_F,PCF,StallD);
instr_mem im(PCF,InstrF);
adder pcadder(PCF,32'h4,PCPlus4F);

always @(posedge clk or posedge rst) begin
    if(rst==1'b1 | FlushD)begin
        InstrF_reg<=32'h0;
        PCF_reg<=32'h0;
        PCPlus4F_reg<=32'h0;
    end
    else if(!StallF) begin
        InstrF_reg<=InstrF;
        PCF_reg<=PCF;
        PCPlus4F_reg<=PCPlus4F;
    end
end

assign InstrD=(rst==1'b1)?32'h0:InstrF_reg;
assign PCD=(rst==1'b1)?32'h0:PCF_reg;
assign PCPlus4D=(rst==1'b1)?32'h0:PCPlus4F_reg;


endmodule
