module fsm(clk, reset, stateID,
           R);

    input            clk;
    input            reset;
    input            R;
    output reg [5:0] stateID;

    reg [5:0] nextState;

    always @(posedge clk) begin
      
        if(reset == 0)
            stateID <= 6'b010010;
        else
            stateID <= nextState;

    end

    always @(*) begin

        if(reset == 1) begin
            case(stateID)
                18: nextState = 19;
                19: nextState = 33;
                33: 
                    if (R == 1)
                        nextState = 35;
                    else
                        nextState = 33;
                35: nextState = 32;
                32: nextState = 1;
                1:  nextState = 18;
                default:
                    nextState = 18;
            endcase
        end
    end

endmodule