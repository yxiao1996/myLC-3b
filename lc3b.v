`include "./control/control.v"
`include "datapath.v"

module lc3b(clk, reset);

    input clk;
    input reset;

    wire [2:0] wireALUOp;
    wire LDCC, LDIR, LDREG, LDPC, LDMAR, LDMDR, MEMEN;
    wire GatePC, GateMDR, GateALU, GateMARMUX;
    wire N, P, Z, R;
    wire [15:0] IR;

    control Control(.clk(clk),
                    .reset(reset),
                    .IR(IR),
                    .N(N), .P(P), .Z(Z), .R(R),
                    .aluop(wireALUOp),
                    .LDCC(LDCC), .LDIR(LDIR),   .LDREG(LDREG),
                    .LDPC(LDPC), .LDMAR(LDMAR), .LDMDR(LDMDR),
                    .GatePC(GatePC), .GateMDR(GateMDR), .GateALU(GateALU), .GateMARMUX(GateMARMUX),
                    .MEMEN(MEMEN));

    datapath DataPath(.clk(clk), 
                      .reset(reset),
                      .aluop(wireALUOp),
                      .IR(IR),
                      .LDCC(LDCC), .LDIR(LDIR), .LDREG(LDREG), 
                      .LDPC(LDPC), .LDMAR(LDMAR), .LDMDR(LDMDR), .MEMEN(MEMEN),
                      .GatePC(GatePC), .GateMDR(GateMDR),.GateALU(GateALU), .GateMARMUX(GateMARMUX),
                      .N(N), .P(P), .Z(Z), .R(R));

endmodule