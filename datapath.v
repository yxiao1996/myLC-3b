`include "./reg/reg_file.v"
`include "./reg/register.v"
`include "./control/pc.v"
`include "./memory/mem16.v"
`include "./alu/alu.v"
`include "./misc/npzLogic.v"
`include "./misc/gate.v"

module datapath(clk, reset,
                aluop,
                IR,
                LDCC, LDIR, LDREG, LDPC, LDMAR, LDMDR, MEMEN,
                GatePC, GateMDR, GateALU, GateMARMUX,
                MuxALU, MuxAddr2, MuxAddr1, MuxPC,
                N, P, Z, R);

    input  clk;
    input  reset;
    input  [2:0] aluop;
    input  LDCC, LDIR, LDREG;
    input  LDPC, LDMAR, LDMDR;
    input  GatePC, GateMDR, GateALU, GateMARMUX;
    input  MuxALU, MuxAddr1; 
    input  [1:0] MuxAddr2, MuxPC;
    input  MEMEN;
    output N, P, Z;
    output R;
    output [15:0] IR;

    wire [15:0] aluIn1, aluIn2, aluOut;
    wire        wireN, wireP, wireZ;
    wire [15:0] outIR;
    wire [15:0] wireRegIn, wireRegOut1, wireRegOut2;
    wire [15:0] wirePCIn, wirePCOut, wirePCAdderOut;
    wire [15:0] wireMemAddr, wireMemOut;
    wire [15:0] wireMDR, wireMAR, wireMARMUX, wireALUMUX;
    wire [15:0] wireIMM5SEXT, wireIMM6SEXT;
    wire [15:0] wireAddr1, wireAddr2;
    wire [15:0] bus;

    register16 PC(.clk(clk),
                  .reset(reset),
                  .in(wirePCIn),
                  .out(wirePCOut),
                  .write(LDPC));

    alu PCAdder(.in1(wirePCOut),
                .in2(16'd2),
                .op(3'b0),
                .out(wirePCAdderOut),
                .zero(zero),
                .negative(negative));

    mux16x2 PCMux(.data0(wirePCAdderOut),
                  .data1(bus),
                  .data2(wireMARMUX),
                  .data3(16'b0),
                  .out(wirePCIn),
                  .selectinput(MuxPC));

    gate16 gatePC(wirePCOut,   // in
                  bus,         // out
                  GatePC);     // ctrl

    latch16 MAR(.in(bus),
                .out(wireMemAddr),
                .write(LDMAR));

    sext6 Sext6(.in(IR[5:0]),
                .out(wireIMM6SEXT));

    sext5 Sext5(.in(IR[4:0]),
                .out(wireIMM5SEXT));

    mux16x2 Addr2Mux(.data0(16'b0),
                     .data1(16'b0),
                     .data2(wireIMM6SEXT),
                     .data3(16'b0),
                     .out(wireAddr2),
                     .selectinput(MuxAddr2));

    mux16x1 Addr1Mux(.data0(wirePCOut),
                     .data1(wireRegOut1),
                     .out(wireAddr1),
                     .selectinput(MuxAddr1));

    alu AddrAdder(.in1(wireAddr1),
                  .in2(wireAddr2),
                  .op(3'b000),
                  .out(wireMARMUX),
                  .zero(zero),
                  .negative(negative));

    gate16 gateMARMUX(.in(wireMARMUX),
                      .out(bus),
                      .enable(GateMARMUX));

    latch16 MDR(.in(outIR),
                .out(wireMDR),
                .write(LDMDR));

    gate16 gateMDR(.in(outIR),
                   .out(bus),
                   .enable(GateMDR));

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
                 .ir14(1'b0),
                 .R(R));

    reg_file regFile(.clk(clk),
                     .reset(reset),
                     .write(LDREG),
                     .out1(wireRegOut1),
                     .out2(wireRegOut2),
                     .in(bus),
                     .readAddr1(IR[8:6]),
                     .readAddr2(IR[2:0]),
                     .writeAddr(IR[11:9]));

    alu ALU(.in1(wireRegOut1),
            .in2(wireALUMUX),
            .op(aluop),
            .out(aluOut),
            .zero(zero),
            .negative(negative));

    mux16x1 ALUMUX(.data0(wireRegOut2),
                   .data1(wireIMM5SEXT),
                   .out(wireALUMUX),
                   .selectinput(MuxALU));

    gate16 gateALU(.in(aluOut),
                   .out(bus),
                   .enable(GateALU));

    npzLogic NPZ(.in(bus),
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