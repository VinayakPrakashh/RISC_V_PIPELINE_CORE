module memory_cycle (
    input clk,rst,RegWriteM,MemWriteM,
    input [1:0] ResultSrcM,
    input [31:0] WriteDataM,ALUResultM,PCPlus4M,InstrM,
    input [4:0] RdM,
    output RegWriteW,
    output [1:0] ResultSrcW,
    output [31:0] ReadDataW,ALUResultW,PCPlus4W,
    output [4:0] RdW
);

endmodule

module data_mem #(
    parameter DATA_WIDTH = 32,ADDR_WIDTH = 32,MEM_SIZE = 64
) (
    input clk,wr_en,
    input [2:0] funct3,
    input [ADDR_WIDTH-1:0] wr_addr,
    input [DATA_WIDTH-1:0] wr_data,
    output reg [DATA_WIDTH-1:0] rd_data_mem
);