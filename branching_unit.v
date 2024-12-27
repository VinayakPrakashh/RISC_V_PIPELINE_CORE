module branching_unit (
    input ALUR31,Zero,
    input [2:0] funct3,
    output reg Takebranch
);
    always @(*) begin
        case(funct3)
		  3'b000: Takebranch =Zero;//beq
		  3'b001: Takebranch =!Zero;//bne
		  3'b111: Takebranch =!ALUR31;//bge
		  3'b101: Takebranch =!ALUR31;//bgeu
		  3'b100: Takebranch =ALUR31;//blt
		  3'b110: Takebranch =ALUR31;//bltu
          default:Takebranch = 0;
        endcase
    end
endmodule