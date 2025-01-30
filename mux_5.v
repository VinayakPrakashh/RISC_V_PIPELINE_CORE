module mux2_5 (
    input       [4:0] d0, d1,
    input       sel,
    output      [4:0] y
);

assign y = sel ? d1 : d0;

endmodule