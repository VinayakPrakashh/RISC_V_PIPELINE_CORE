module writeback_cycle (
   input clk,rst,
    input [1:0] ResultSrcW,
    input [31:0] ReadDataW,ALUResultW,PCPlus4W,
    output [31:0] ResultW,
    input [31:0] AuLu_ResultW
);
mux4 resultmux(ALUResultW,ReadDataW,PCPlus4W,AuLu_ResultW,ResultSrcW,ResultW);
endmodule