module reset_ff #(parameter WIDTH = 32) (
    input       clk, rst,
    input       [WIDTH-1:0] d,
    output reg  [WIDTH-1:0] q,
    input       StallD
);

always @(posedge clk or posedge rst) begin
    if (rst) q <= 0;
    else if(!StallD)    q <= d;
end

endmodule