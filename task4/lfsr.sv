module lfsr (
    input  logic       clk,
    input  logic       rst,
    input  logic       en,
    output logic [6:0] data_out
);

    logic [7:1] sreg;

    always_ff @(posedge clk, posedge rst)
        if (rst)
            sreg <= 7'b000_0001;
        else if (en) begin 
            sreg[7] <= sreg[6];
            sreg[6] <= sreg[5];
            sreg[5] <= sreg[4];
            sreg[4] <= sreg[3];
            sreg[3] <= sreg[2];
            sreg[2] <= sreg[1];
            sreg[1] <= sreg[7] ^ sreg[3];
        end

    assign data_out = sreg;

endmodule
