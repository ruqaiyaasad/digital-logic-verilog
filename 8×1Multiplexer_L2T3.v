
// 8x1 MUX - GATE LEVEL
module mux_gate(y, d0, d1, d2, d3, d4, d5, d6, d7, s2, s1, s0);

    input  d0, d1, d2, d3, d4, d5, d6, d7;
    input  s2, s1, s0;
    output y;

    wire s2_n, s1_n, s0_n;
    wire t0, t1, t2, t3, t4, t5, t6, t7;

    not (s2_n, s2);
    not (s1_n, s1);
    not (s0_n, s0);

    and (t0, d0, s2_n, s1_n, s0_n);
    and (t1, d1, s2_n, s1_n, s0);
    and (t2, d2, s2_n, s1, s0_n);
    and (t3, d3, s2_n, s1, s0);
    and (t4, d4, s2, s1_n, s0_n);
    and (t5, d5, s2, s1_n, s0);
    and (t6, d6, s2, s1, s0_n);
    and (t7, d7, s2, s1, s0);

    or  (y, t0, t1, t2, t3, t4, t5, t6, t7);

endmodule


// 8x1 MUX - DATAFLOW LEVEL

module mux_dataflow(y, d0, d1, d2, d3, d4, d5, d6, d7, s2, s1, s0);

    input  d0, d1, d2, d3, d4, d5, d6, d7;
    input  s2, s1, s0;
    output y;

    assign y = (~s2 & ~s1 & ~s0 & d0) |
               (~s2 & ~s1 &  s0 & d1) |
               (~s2 &  s1 & ~s0 & d2) |
               (~s2 &  s1 &  s0 & d3) |
               ( s2 & ~s1 & ~s0 & d4) |
               ( s2 & ~s1 &  s0 & d5) |
               ( s2 &  s1 & ~s0 & d6) |
               ( s2 &  s1 &  s0 & d7);

endmodule

module testbench();

    reg  d0, d1, d2, d3, d4, d5, d6, d7;
    reg  s2, s1, s0;

    wire y_gate;
    wire y_dataflow;

    mux_gate     uut1(y_gate,     d0, d1, d2, d3, d4, d5, d6, d7, s2, s1, s0);
    mux_dataflow uut2(y_dataflow, d0, d1, d2, d3, d4, d5, d6, d7, s2, s1, s0);

    initial
    begin
        // Select d0 (s2 s1 s0 = 000)
        d0=1; d1=0; d2=0; d3=0; d4=0; d5=0; d6=0; d7=0;
        s2=0; s1=0; s0=0;

        // Select d1 (s2 s1 s0 = 001)
        #50 d0=0; d1=1; d2=0; d3=0; d4=0; d5=0; d6=0; d7=0;
            s2=0; s1=0; s0=1;

        // Select d2 (s2 s1 s0 = 010)
        #50 d0=0; d1=0; d2=1; d3=0; d4=0; d5=0; d6=0; d7=0;
            s2=0; s1=1; s0=0;

        // Select d3 (s2 s1 s0 = 011)
        #50 d0=0; d1=0; d2=0; d3=1; d4=0; d5=0; d6=0; d7=0;
            s2=0; s1=1; s0=1;

        // Select d4 (s2 s1 s0 = 100)
        #50 d0=0; d1=0; d2=0; d3=0; d4=1; d5=0; d6=0; d7=0;
            s2=1; s1=0; s0=0;

        // Select d5 (s2 s1 s0 = 101)
        #50 d0=0; d1=0; d2=0; d3=0; d4=0; d5=1; d6=0; d7=0;
            s2=1; s1=0; s0=1;

        // Select d6 (s2 s1 s0 = 110)
        #50 d0=0; d1=0; d2=0; d3=0; d4=0; d5=0; d6=1; d7=0;
            s2=1; s1=1; s0=0;

        // Select d7 (s2 s1 s0 = 111)
        #50 d0=0; d1=0; d2=0; d3=0; d4=0; d5=0; d6=0; d7=1;
            s2=1; s1=1; s0=1;
    end

endmodule
