module branch_predictor (
    input  clk,
    input  reset,
    input  branch_taken,
    output reg predict_taken
);

    reg [1:0] state; // 2-bit saturating counter

    // State encoding
    localparam STRONG_NOT_TAKEN = 2'b00;
    localparam WEAK_NOT_TAKEN   = 2'b01;
    localparam WEAK_TAKEN       = 2'b10;
    localparam STRONG_TAKEN     = 2'b11;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= WEAK_NOT_TAKEN;
        end else begin
            case (state)
                STRONG_NOT_TAKEN: state <= branch_taken ? WEAK_NOT_TAKEN : STRONG_NOT_TAKEN;
                WEAK_NOT_TAKEN:   state <= branch_taken ? WEAK_TAKEN : STRONG_NOT_TAKEN;
                WEAK_TAKEN:       state <= branch_taken ? STRONG_TAKEN : WEAK_NOT_TAKEN;
                STRONG_TAKEN:     state <= branch_taken ? STRONG_TAKEN : WEAK_TAKEN;
            endcase
        end
    end

    always @(*) begin
        case (state)
            STRONG_NOT_TAKEN, WEAK_NOT_TAKEN: predict_taken = 0;
            WEAK_TAKEN, STRONG_TAKEN:         predict_taken = 1;
        endcase
    end

endmodule