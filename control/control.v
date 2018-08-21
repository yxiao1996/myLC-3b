`include "./control/fsm.v"
`include "./control/controlStore.v"

module control(clk, reset,
                    IR,
                    N, P, Z, R,
                    aluop,
                    LDCC, LDIR, LDREG,
                    LDPC, LDMAR, LDMDR,
                    GatePC, GateMDR, GateALU, GateMARMUX, 
                    MuxALU, MuxAddr1, MuxAddr2, MuxPC, 
                    MEMEN);

    input clk;
    input reset;
    input [15:0] IR;
    input N, P, Z, R;
    output [2:0] aluop;
    output LDCC, LDIR, LDREG;
    output LDPC, LDMAR, LDMDR;
    output GatePC, GateMDR, GateALU, GateMARMUX;
    output MuxALU, MuxAddr1;
    output [1:0] MuxAddr2, MuxPC;
    output MEMEN;

    wire [5:0] wireStateID;

    fsm FSM(.clk(clk),
            .reset(reset),
            .R(R),
            .IR(IR),
            .stateID(wireStateID),
            .MuxALU(MuxALU), .MuxAddr1(MuxAddr1), .MuxAddr2(MuxAddr2), .MuxPC(MuxPC));

    controlStore ControlStore(.stateID(wireStateID),
                              .aluop(aluop),
                              .LDCC(LDCC), .LDIR(LDIR),   .LDREG(LDREG),
                              .LDPC(LDPC), .LDMAR(LDMAR), .LDMDR(LDMDR),
                              .GatePC(GatePC), .GateMDR(GateMDR), .GateALU(GateALU),
                              .GateMARMUX(GateMARMUX), 
                              .MEMEN(MEMEN));

endmodule