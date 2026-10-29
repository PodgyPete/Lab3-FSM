module f1_full (
    input  logic       clk,
    input  logic       rst,
    input  logic       trigger,
    output logic [7:0] data_out
);

    //internal wires
    logic       cmd_seq;
    logic       cmd_delay;
    logic       tick;
    logic       time_out;
    logic       fsm_en; 
    logic [6:0] rand_k;

    lfsr lfsr (
        .clk (clk),
        .rst (rst),
        .en (1'b1),
        .data_out (rand_k)

    );

    clktick clktick (
        .N (5'd24),
        .clk (clk),
        .rst (rst),
        .en (cmd_seq),
        .tick (tick)
    );

    delay delay (
        .clk (clk),
        .rst (rst),
        .trigger (cmd_delay),
        .n (rand_k),
        .time_out (time_out)
    );

    //mux
    assign fsm_en = cmd_seq ? tick : time_out;

    f1_fsm f1_fsm (
        .clk      (clk),
        .rst      (rst),
        .en       (fsm_en),
        .trigger  (trigger),
        .data_out (data_out),
        .cmd_seq  (cmd_seq),
        .cmd_delay (cmd_delay)
    );

endmodule
