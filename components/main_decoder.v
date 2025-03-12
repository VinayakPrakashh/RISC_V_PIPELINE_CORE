module main_decoder (
    input  [6:0] op,
	 input  [2:0] funct3,
    output [1:0] ResultSrc,
    output       MemWrite, Branch, ALUSrc,
    output       RegWrite, Jump,jalr,
    output [2:0] ImmSrc,
    output [1:0] ALUOp
);
reg [13:0] controls;

always @(*) begin
    casez (op)
        // RegWrite_ImmSrc_ALUSrc_MemWrite_ResultSrc_ALUOp_Jump_jalr_Branch
        7'b0000011: controls = 13'b1_000_1_0_01_00_0_0_0; // lw
        7'b0100011: controls = 13'b0_001_1_1_00_00_0_0_0; // sw
        7'b0110011: controls = 13'b1_xxx_0_0_00_10_0_0_0; // R–type
        7'b1100011: controls = 13'b0_010_0_0_00_01_0_0_1; //branch
        7'b0010011: controls = 13'b1_000_1_0_00_10_0_0_0; // I–type ALU
		7'b0010111: controls = 13'b1_100_x_0_11_xx_0_0_0;  // auipc
        7'b0110111: controls = 13'b1_101_x_0_11_xx_0_0_0;  // lui
		7'b1100111: controls = 13'b1_000_1_0_10_10_1_1_0;  //jalr 
        7'b1101111: controls = 13'b1_011_0_0_10_00_1_0_0; // jal
        default:    controls = 13'bx_xxx_0_x_xx_xx_0_0_0; // ???
    endcase
end

assign {RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, ALUOp, Jump,jalr,Branch} = controls;
endmodule