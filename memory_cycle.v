module memory_cycle (
    input clk,rst,RegWriteM,MemWriteM,
    input [1:0] ResultSrcM,
    input [31:0] WriteDataM,ALUResultM,PCPlus4M,InstrM,
    input [4:0] RdM,
    output RegWriteW,
    output [1:0] ResultSrcW,
    output [31:0] ReadDataW,ALUResultW,PCPlus4W,
    output [4:0] RdW,
    input [31:0] AuLu_ResultM,
    output [31:0] AuLu_ResultW
    );
wire [31:0] ReadDataM;

reg [31:0] ReadDataW_r,ALUResultW_r,PCPlus4W_r,AuLu_ResultW_r;
reg [4:0] RdW_r;
reg RegWriteW_r;
reg [1:0] ResultSrcW_r;


data_mem dm(clk,MemWriteM,InstrM[14:12],ALUResultM,WriteDataM,ReadDataM);

always @(posedge clk or posedge rst) begin
    if(rst==1'b1)begin
        ReadDataW_r <= 32'b0;
        ALUResultW_r <= 32'b0;
        PCPlus4W_r <= 32'b0;
        RdW_r <= 5'b0;
        RegWriteW_r <= 1'b0;
        ResultSrcW_r <= 2'b00;
        AuLu_ResultW_r <= 32'b0;
    end
    else begin
        ReadDataW_r <= ReadDataM;
        ALUResultW_r <= ALUResultM;
        PCPlus4W_r <= PCPlus4M;
        RdW_r <= RdM;
        RegWriteW_r <= RegWriteM;
        ResultSrcW_r <= ResultSrcM;
        AuLu_ResultW_r <= AuLu_ResultM;
    end
end
assign ReadDataW = ReadDataW_r;
assign ALUResultW = ALUResultW_r;
assign PCPlus4W = PCPlus4W_r;
assign RdW = RdW_r;
assign RegWriteW = RegWriteW_r;
assign ResultSrcW = ResultSrcW_r;
assign AuLu_ResultW = AuLu_ResultW_r;

endmodule