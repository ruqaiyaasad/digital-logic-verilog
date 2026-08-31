module ha_gate(sum, carry, a, b);

    input a, b;
    output sum, carry;

    xor (sum, a, b);
    and (carry, a, b);

endmodule


module ha_dataflow(sum, carry, a, b);

    input a, b;
    output sum, carry;

    assign sum   = a ^ b;
    assign carry = a & b;

endmodule


module fa_gate(sum, carry, cin, a, b);

    input a, b, cin;
    output sum, carry;

    wire t1, t2, t3;

    // First Half Adder
    ha_gate HA1(t1, t2, a, b);

    // Second Half Adder
    ha_gate HA2(sum, t3, t1, cin);

    // OR the two carry outputs
    or (carry, t2, t3);

endmodule


module fa_dataflow(sum, carry, cin, a, b);

    input a, b, cin;
    output sum, carry;

    assign sum   = a ^ b ^ cin;
    assign carry = (a & b) | (b & cin) | (a & cin);

endmodule


module testbench;

    reg A, B, Cin;

    wire hs_gate, hc_gate;
    wire hs_dataflow, hc_dataflow;

    wire fs_gate, fc_gate;
    wire fs_dataflow, fc_dataflow;

    ha_gate       HA_GATE      (hs_gate,      hc_gate,      A, B);
    ha_dataflow   HA_DATAFLOW  (hs_dataflow,  hc_dataflow,  A, B);
    fa_gate       FA_GATE      (fs_gate,      fc_gate,      Cin, A, B);
    fa_dataflow   FA_DATAFLOW  (fs_dataflow,  fc_dataflow,  Cin, A, B);

    initial begin
       

        A = 0; B = 0; Cin = 0;

        #10 A = 0; B = 0; Cin = 1;
        #10 A = 0; B = 1; Cin = 0;
        #10 A = 0; B = 1; Cin = 1;
        #10 A = 1; B = 0; Cin = 0;
        #10 A = 1; B = 0; Cin = 1;
        #10 A = 1; B = 1; Cin = 0;
        #10 A = 1; B = 1; Cin = 1;

        #10 $finish;
    end

endmodule
