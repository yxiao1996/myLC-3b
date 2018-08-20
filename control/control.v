`include "./control/fsm.v"
`include "./control/controlStore.v"

module control(clk, reset,
                    IR,
                    N, P, Z, R,
                    aluop,
                    LDCC, LDIR, LDREG,
                    LDPC, LDMAR, LDMDR,
                    MEMEN);

    input clk;
    input reset;
    input [15:0] IR;
    input N, P, Z, R;
    output reg [2:0] aluop;
    output LDCC, LDIR, LDREG;
    output LDPC, LDMAR, LDMDR;
    output MEMEN;

    wire [5:0] wireStateID;

    always @(*) begin
        aluop <= 3'b00;
    end

    fsm FSM(.clk(clk),
            .reset(reset),
            .R(R),
            .stateID(wireStateID));

    controlStore ControlStore(.stateID(wireStateID),
                              .LDCC(LDCC), .LDIR(LDIR),   .LDREG(LDREG),
                              .LDPC(LDPC), .LDMAR(LDMAR), .LDMDR(LDMDR),
                              .MEMEN(MEMEN));

endmodule