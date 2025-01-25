module hazard_unit (
    input rst,RegWriteM,RegWriteW,
    input [4:0]RdM,RdW,
    input [4:0] rs1_addr_E,rs2_addr_E,
    output [1:0] ForwardAE,ForwardBE,
    input [1:0] ResultSrcE,
    input [4:0] Rs1D,Rs2D,RdE,
    output StallF,StallD,FlushE,
    input PCSrcE,
    output FlushD
);

wire lwstall;

assign ForwardAE = (rst==1'b1)? 2'b00 : 
                   ((RegWriteM ==1'b1) && (RdM != 5'b00000) && (RdM == rs1_addr_E)) ? 2'b10 : 
                   ((RegWriteW ==1'b1) && (RdW != 5'b00000) && (RdW == rs1_addr_E)) ? 2'b01 : 2'b00;
assign ForwardBE = (rst==1'b1)? 2'b00 : 
                   ((RegWriteM ==1'b1) && (RdM != 5'b00000) && (RdM == rs2_addr_E)) ? 2'b10 : 
                   ((RegWriteW ==1'b1) && (RdW != 5'b00000) && (RdW == rs2_addr_E)) ? 2'b01 : 2'b00;

assign lwstall = (ResultSrcE ==2'b01) & ((Rs1D == RdE) | (Rs2D == RdE));

assign StallF = lwstall;
assign StallD = lwstall;
assign FlushE = lwstall | PCSrcE;
assign FlushD = PCSrcE;

endmodule