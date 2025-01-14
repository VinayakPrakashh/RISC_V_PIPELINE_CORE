module writeback_cycle (
   input clk,rst,
    input [1:0] ResultSrcW,
    input [31:0] ReadDataW,ALUResultW,PCPlus4W,
    output [31:0] ResultW
);
mux4 resultmux(ALUResultW,ReadDataW,PCPlus4W,32'b0,ResultSrcW,ResultW);
endmodule
module writeback_cycle (
   input clk,rst,RegWriteW,
    input [1:0] ResultSrcW,
    input [31:0] ReadDataW,ALUResultW,PCPlus4W,
    input [4:0] RdW,
    output [31:0] Result,
    output RegWrite,
    output [4:0] Rd
);
wire [31:0] ResultW;

reg [31:0] Result_r;
reg RegWrite_r;
reg [4:0] Rd_r;


mux4 resultmux(ALUResultW,ReadDataW,PCPlus4W,32'b0,ResultSrcW,ResultW);
always @(posedge clk or posedge rst) begin
    if (rst==1'b1) begin
        Result_r<=32'h0;
        RegWrite_r<=1'b0;
        Rd_r<=5'b0;
    end
    else begin
        Result_r<=ResultW;
        RegWrite_r<=RegWriteW;
        Rd_r<=RdW;
    end


end
assign Result=Result_r;
assign RegWrite=RegWrite_r;
assign Rd=Rd_r;
endmodule