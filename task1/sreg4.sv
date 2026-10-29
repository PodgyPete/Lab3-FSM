module sreg4 (
    input logic clk,
    input logic rst,
    input logic data_in,
    output logic data_out
);

    logic [4:1] sreg;
    

    always_ff @ (posedge clk)
        if (rst)
            sreg <= 4'b0;
        else if (en) begin 
            sreg[4] <= sreg [3];
            sreg[3] <= sreg [2];
            sreg[2] <= sreg [1];
            sreg[1] <= data_in;
        end
    assign data_out = sreg;
endmodule