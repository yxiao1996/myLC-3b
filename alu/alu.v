`ifndef _ALU
`define _ALU
`include "./alu/adder.v"
`include "./alu/and.v"
`include "./alu/lshift.v"
`include "./alu/rshift.v"
`include "./alu/not.v"
`include "./alu/xor.v"
`include "./misc/mux.v"

module alu(in1, in2, op, out, zero, negative);

    output [15:0] out;
    input  [15:0] in1, in2;
    input  [2:0]  op;
    output        zero, negative;

    wire [15:0] 
        outAdd, outAnd, outNot, outXor,
        outLshf, outRshf; 
    
    assign negative = out[15];

    nor n1(zero, out[0],  out[1],  out[2],  out[3],
                 out[4],  out[5],  out[6],  out[7],
                 out[8],  out[9],  out[10], out[11],
                 out[12], out[13], out[14], out[15]);
    
    mux16x8 m1(outAdd, outAnd, outNot, outXor, outLshf, outRshf, 
               16'b0, 16'b0, 
               op, out);

    adder16 add1(in1, in2, outAdd);

    and16   and1(in1, in2, outAnd);

    not16   not1(in1, outNot);

    xor16   xor1(in1, in2, outXor);

    left_shift  lshf(in1, outLshf, 4'b1);

    right_shift rshf(in1, outRshf, 4'b1);

endmodule

`endif
