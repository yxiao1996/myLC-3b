module controlStore(stateID,
                    aluop,
                    LDCC, LDIR, LDREG, LDPC, LDMAR, LDMDR, MEMEN,
                    GatePC, GateMDR, GateALU, GateMARMUX);

    input  [5:0] stateID;
    output reg [2:0] aluop;
    output reg LDCC, LDIR, LDREG;
    output reg LDPC, LDMAR, LDMDR;
    output reg GatePC, GateMDR, GateALU, GateMARMUX;
    output reg MEMEN;

    always @(*) begin
        case(stateID)
        18: begin
            aluop <= 3'b111;
            LDPC  <= 1'b1;
            LDMAR <= 1'b0;
            LDMDR <= 1'b1;
            LDCC  <= 1'b1;
            LDIR  <= 1'b1;
            LDREG <= 1'b1;
            MEMEN <= 1'b1;
            GatePC <= 1'b0;
            GateMDR <= 1'b1;
            GateALU <= 1'b1;
            GateMARMUX <= 1'b1;
        end
        19: begin
            aluop <= 3'b111;
            LDPC  <= 1'b0;
            LDMAR <= 1'b1;
            LDMDR <= 1'b1;
            LDCC  <= 1'b1;
            LDIR  <= 1'b1;
            LDREG <= 1'b1;
            MEMEN <= 1'b1;
            GatePC <= 1'b1;
            GateMDR <= 1'b1;
            GateALU <= 1'b1;
            GateMARMUX <= 1'b1;
        end
        33:begin
            aluop <= 3'b111;
            LDPC  <= 1'b1;
            LDMAR <= 1'b1;
            LDMDR <= 1'b0;
            LDCC  <= 1'b1;
            LDIR  <= 1'b1;
            LDREG <= 1'b1;
            MEMEN <= 1'b1;
            GatePC <= 1'b1;
            GateMDR <= 1'b1;
            GateALU <= 1'b1;
            GateMARMUX <= 1'b1;
        end
        35:begin
            aluop <= 3'b111;
            LDPC  <= 1'b1;
            LDMAR <= 1'b1;
            LDMDR <= 1'b1;
            LDCC  <= 1'b1;
            LDIR  <= 1'b0;
            LDREG <= 1'b1;
            MEMEN <= 1'b1;
            GatePC <= 1'b1;
            GateMDR <= 1'b1;
            GateALU <= 1'b1;
            GateMARMUX <= 1'b1;
        end
        32:begin
            aluop <= 3'b111;
            LDPC  <= 1'b1;
            LDMAR <= 1'b1;
            LDMDR <= 1'b1;
            LDCC  <= 1'b1;
            LDIR  <= 1'b1;
            LDREG <= 1'b1;
            MEMEN <= 1'b1;
            GatePC <= 1'b1;
            GateMDR <= 1'b1;
            GateALU <= 1'b1;
            GateMARMUX <= 1'b1;
        end
        1:begin // add
            aluop <= 3'b000;
            LDPC  <= 1'b1;
            LDMAR <= 1'b1;
            LDMDR <= 1'b1;
            LDCC  <= 1'b0;
            LDIR  <= 1'b1;
            LDREG <= 1'b0;
            MEMEN <= 1'b1;
            GatePC <= 1'b1;
            GateMDR <= 1'b1;
            GateALU <= 1'b0;
            GateMARMUX <= 1'b1;
        end
        5:begin // and
            aluop <= 3'b001;
            LDPC  <= 1'b1;
            LDMAR <= 1'b1;
            LDMDR <= 1'b1;
            LDCC  <= 1'b0;
            LDIR  <= 1'b1;
            LDREG <= 1'b0;
            MEMEN <= 1'b1;
            GatePC <= 1'b1;
            GateMDR <= 1'b1;
            GateALU <= 1'b0;
            GateMARMUX <= 1'b1;
        end
        6:begin
            aluop <= 3'b111;
            LDPC  <= 1'b1;
            LDMAR <= 1'b0;
            LDMDR <= 1'b1;
            LDCC  <= 1'b1;
            LDIR  <= 1'b1;
            LDREG <= 1'b1;
            MEMEN <= 1'b1;
            GatePC <= 1'b1;
            GateMDR <= 1'b1;
            GateALU <= 1'b1;
            GateMARMUX <= 1'b0;
        end
        25:begin
            aluop <= 3'b111;
            LDPC  <= 1'b1;
            LDMAR <= 1'b1;
            LDMDR <= 1'b0;
            LDCC  <= 1'b1;
            LDIR  <= 1'b1;
            LDREG <= 1'b1;
            MEMEN <= 1'b1;
            GatePC <= 1'b1;
            GateMDR <= 1'b1;
            GateALU <= 1'b1;
            GateMARMUX <= 1'b1;
        end
        27:begin
            aluop <= 3'b111;
            LDPC  <= 1'b1;
            LDMAR <= 1'b1;
            LDMDR <= 1'b1;
            LDCC  <= 1'b1;
            LDIR  <= 1'b1;
            LDREG <= 1'b0;
            MEMEN <= 1'b1;
            GatePC <= 1'b1;
            GateMDR <= 1'b0;
            GateALU <= 1'b1;
            GateMARMUX <= 1'b1;
        end
        12: begin
            aluop <= 3'b111;
            LDPC  <= 1'b0;
            LDMAR <= 1'b1;
            LDMDR <= 1'b1;
            LDCC  <= 1'b1;
            LDIR  <= 1'b1;
            LDREG <= 1'b1;
            MEMEN <= 1'b1;
            GatePC <= 1'b1;
            GateMDR <= 1'b1;
            GateALU <= 1'b1;
            GateMARMUX <= 1'b1;
        end
        default: begin
            aluop <= 3'b111;
            LDPC  <= 1'b1;
            LDMAR <= 1'b1;
            LDMDR <= 1'b1;
            LDCC  <= 1'b1;
            LDIR  <= 1'b1;
            LDREG <= 1'b1;
            MEMEN <= 1'b1;
            GatePC <= 1'b1;
            GateMDR <= 1'b1;
            GateALU <= 1'b1;
            GateMARMUX <= 1'b1;
        end
        endcase
    end

endmodule