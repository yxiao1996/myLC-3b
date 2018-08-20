`include "./reg/register.v"

module pc(clk, out, in, LDPC, reset);

    input         clk;
    input [15:0]  in;
    input         LDPC;
    input         reset;
    output [15:0] out;

    register16 PCreg(.clk(clk),
                     .out(out),
                     .in(in),
                     .write(LDPC),
                     .reset(reset));

endmodule