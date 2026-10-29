module f1_fsm (
    input   logic       rst,
    input   logic       en,
    input   logic       clk,
    input   logic       trigger,
    output  logic [7:0] data_out,
    output  logic       cmd_seq,
    output  logic       cmd_delay
);
    typedef enum logic [3:0]{
        s0, s1, s2, s3, s4, s5, s6, s7, s8
    } my_state;

    my_state current_state, next_state;

        always_ff @ (posedge clk, posedge rst)
            if (rst)
                current_state <= s0;
            else if (current_state == s0 ? trigger : en) //if current state is s0, waits for trigger not enable
                current_state <= next_state;

        always_comb begin
            case (current_state) 
                s0: next_state = s1;
                s1: next_state = s2;
                s2: next_state = s3;
                s3: next_state = s4;
                s4: next_state = s5;
                s5: next_state = s6;
                s6: next_state = s7;
                s7: next_state = s8;
                s8: next_state = s0;
                default: next_state = s0;
            endcase
        end

        always_comb begin
            case (current_state)
                s0: data_out = 8'b0000_0000;
                s1: data_out = 8'b0000_0001;
                s2: data_out = 8'b0000_0011;
                s3: data_out = 8'b0000_0111;
                s4: data_out = 8'b0000_1111;
                s5: data_out = 8'b0001_1111;
                s6: data_out = 8'b0011_1111;
                s7: data_out = 8'b0111_1111;
                s8: data_out = 8'b1111_1111;
                default: data_out = 8'b0000_0000;
            endcase
        end

        //control signals
        assign cmd_seq = (current_state != s0);
        assign cmd_delay = (current_state == s8);

endmodule
