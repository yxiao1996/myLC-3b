module controlStore(stateID,
                    LDCC, LDIR, LDREG, LDPC, LDMAR, LDMDR, MEMEN);

    input  [5:0] stateID;
    output reg LDCC, LDIR, LDREG;
    output reg LDPC, LDMAR, LDMDR;
    output reg MEMEN;

    always @(*) begin
        case(stateID)
        18: begin
            LDPC  <= 1'b1;
            LDMAR <= 1'b0;
            LDMDR <= 1'b1;
            LDCC  <= 1'b1;
            LDIR  <= 1'b1;
            LDREG <= 1'b1;
            MEMEN <= 1'b1;
        end
        19: begin
            LDPC  <= 1'b0;
            LDMAR <= 1'b1;
            LDMDR <= 1'b1;
            LDCC  <= 1'b1;
            LDIR  <= 1'b1;
            LDREG <= 1'b1;
            MEMEN <= 1'b1;
        end
        33:begin
            LDPC  <= 1'b1;
            LDMAR <= 1'b1;
            LDMDR <= 1'b0;
            LDCC  <= 1'b1;
            LDIR  <= 1'b1;
            LDREG <= 1'b1;
            MEMEN <= 1'b1;
        end
        35:begin
            LDPC  <= 1'b1;
            LDMAR <= 1'b1;
            LDMDR <= 1'b1;
            LDCC  <= 1'b1;
            LDIR  <= 1'b0;
            LDREG <= 1'b1;
            MEMEN <= 1'b1;
        end
        32:begin
            LDPC  <= 1'b1;
            LDMAR <= 1'b1;
            LDMDR <= 1'b1;
            LDCC  <= 1'b1;
            LDIR  <= 1'b1;
            LDREG <= 1'b1;
            MEMEN <= 1'b1;
        end
        1:begin
            LDPC  <= 1'b1;
            LDMAR <= 1'b1;
            LDMDR <= 1'b1;
            LDCC  <= 1'b1;
            LDIR  <= 1'b1;
            LDREG <= 1'b1;
            MEMEN <= 1'b1;
        end
        default: begin
            LDPC  <= 1'b1;
            LDMAR <= 1'b1;
            LDMDR <= 1'b1;
            LDCC  <= 1'b1;
            LDIR  <= 1'b1;
            LDREG <= 1'b1;
            MEMEN <= 1'b1;
        end
        endcase
    end

endmodule