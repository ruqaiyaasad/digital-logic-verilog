
// 3x8 DECODER - GATE LEVEL

module decoder_gate(y0, y1, y2, y3, y4, y5, y6, y7, a, b, c);

    input  a, b, c;
    output y0, y1, y2, y3, y4, y5, y6, y7;

    wire a_n, b_n, c_n;

    not (a_n, a);
    not (b_n, b);
    not (c_n, c);

    and (y0, a_n, b_n, c_n);
    and (y1, a_n, b_n, c);
    and (y2, a_n, b, c_n);
    and (y3, a_n, b, c);
    and (y4, a, b_n, c_n);
    and (y5, a, b_n, c);
    and (y6, a, b, c_n);
    and (y7, a, b, c);

endmodule

// 3x8 DECODER _dataflow LEVEL
module decoder_dataflow(y0, y1, y2, y3, y4, y5, y6, y7, a, b, c);

    input  a, b, c;
    output y0, y1, y2, y3, y4, y5, y6, y7;

    assign y0 = ~a & ~b & ~c;
    assign y1 = ~a & ~b &  c;
    assign y2 = ~a &  b & ~c;
    assign y3 = ~a &  b &  c;
    assign y4 =  a & ~b & ~c;
    assign y5 =  a & ~b &  c;
    assign y6 =  a &  b & ~c;
    assign y7 =  a &  b &  c;

endmodule

module testbench();

    reg  a, b, c;

    wire g0, g1, g2, g3, g4, g5, g6, g7;
    wire d0, d1, d2, d3, d4, d5, d6, d7;

    decoder_gate     uut1(g0, g1, g2, g3, g4, g5, g6, g7, a, b, c);
    decoder_dataflow uut2(d0, d1, d2, d3, d4, d5, d6, d7, a, b, c);

    initial
    begin
        a = 0; b = 0; c = 0;
        #50 a = 0; b = 0; c = 1;
        #50 a = 0; b = 1; c = 0;
        #50 a = 0; b = 1; c = 1;
        #50 a = 1; b = 0; c = 0;
        #50 a = 1; b = 0; c = 1;
        #50 a = 1; b = 1; c = 0;
        #50 a = 1; b = 1; c = 1;
    end

endmodule
