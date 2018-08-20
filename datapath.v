`include "./reg/reg_file.v"
`include "./reg/register.v"
`include "./control/pc.v"
`include "./memory/mem16.v"
`include "./alu/alu.v"
`include "./misc/npzLogic.v"

module datapath(clk, reset,
                aluop,
                IR,
                LDCC, LDIR, LDREG, LDPC, LDMAR, LDMDR, MEMEN,
                N, P, Z, R);

    input  clk;
    input  reset;
    input  [2:0] aluop;
    input  LDCC, LDIR, LDREG;
    input  LDPC, LDMAR, LDMDR;
    input  MEMEN;
    output N, P, Z;
    output R;
    output [15:0] IR;

    wire [15:0] aluIn1, aluIn2, aluOut;
    wire        wireN, wireP, wireZ;
    wire [15:0] outIR;
    wire [15:0] wireRegIn, wireRegOut1, wireRegOut2;
    wire [15:0] wirePCIn, wirePCOut;
    wire [15:0] wireMemAddr, wireMemOut;
    wire [15:0] wireMDR, wireMAR;

    register16 PC(.clk(clk),
                  .reset(reset),
                  .in(wirePCIn),
                  .out(wirePCOut),
                  .write(LDPC));

    alu PCAdder(.in1(wirePCOut),
                .in2(16'd2),
                .op(3'b0),
                .out(wirePCIn),
                .zero(zero),
                .negative(negative));

    latch16 MAR(.in(wirePCOut),
                .out(wireMemAddr),
                .write(LDMAR));

    latch16 MDR(.in(outIR),
                .out(wireMDR),
                .write(LDMDR));

    latch16 instReg(.in(wireMDR),
                    .out(IR),
                    .write(LDIR));

    mem16 memory(.outir(outIR),
                 .out(wireMemOut),
                 .address(wireMemAddr),
                 .write(MEMEN),
                 .clk(clk),
                 .reset(reset),
                 .in(wireRegOut1),
                 .ir14(IR[14]),
                 .R(R));

    reg_file regFile(.clk(clk),
                     .reset(reset),
                     .write(LDREG),
                     .out1(wireRegOut1),
                     .out2(wireRegOut2),
                     .in(wireRegIn),
                     .readAddr1(IR[11:9]),
                     .readAddr2(IR[2:0]),
                     .writeAddr(IR[11:9]));

    alu ALU(.in1(aluIn1),
            .in2(aluIn2),
            .op(aluop),
            .out(aluOut),
            .zero(zero),
            .negative(negative));

    npzLogic NPZ(.in(aluOut),
                 .N(wireN), .P(wireP), .Z(wireZ));    

    register1b regN(.clk(clk),
                    .out(N),
                    .in(wireN),
                    .write(LDCC),
                    .reset(reset));

    register1b regP(.clk(clk),
                    .out(P),
                    .in(wireP),
                    .write(LDCC),
                    .reset(reset));
    
    register1b regZ(.clk(clk),
                    .out(Z),
                    .in(wireZ),
                    .write(LDCC),
                    .reset(reset));

endmodule