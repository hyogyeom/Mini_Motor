`timescale 1ns / 1ps

module Stepmotor(
    input i_clk,
    input i_reset,
    input [2:0]i_enable,
    input i_ms1,
    input i_dir_mode,
    output[3:0] o_motor
   );

    
    // reg r_clk;
    reg[12:0] r_counter_full;
    reg[12:0] r_counter_half;
    reg[3:0] r_motor;
    assign o_motor = r_motor;

    always @(posedge i_clk or posedge i_reset) begin
        if(!i_reset) begin
            r_counter_full <= 0;
            r_counter_half <= 0;
        end
        else begin
            r_counter_half <= r_counter_half + 1;
            if(r_counter_half >= 4096) begin
                r_counter_half <= 0;
            end
            r_counter_full <= r_counter_full + 1;
            if(r_counter_full >= 2048) begin
                r_counter_full <= 0;
            end
        end
    end

    always @(r_counter_full or r_counter_half) begin
        case(i_ms1)
            1'b0:  // full
                if(!i_enable) begin  // ????? ??? 0, ?��??? ????
                    case(i_dir_mode)
                        1'b0:
                        case(r_counter_half % 8)
                            4'd0: r_motor <= 4'b0001;  // 1
                            4'd1: r_motor <= 4'b0011;  // 3
                            4'd2: r_motor <= 4'b0010;  // 2
                            4'd3: r_motor <= 4'b0110;  // 6
                            4'd4: r_motor <= 4'b0100;  // 4
                            4'd5: r_motor <= 4'b1100;  // 12
                            4'd6: r_motor <= 4'b1000;  // 8
                            4'd7: r_motor <= 4'b1001;  // 9
                            default: r_motor <= 4'b0000;
                        endcase
                        1'b1:
                        case(r_counter_half % 8)
                            4'd0: r_motor <= 4'b1001;  // 1
                            4'd1: r_motor <= 4'b1000;  // 3
                            4'd2: r_motor <= 4'b1100;  // 2
                            4'd3: r_motor <= 4'b0100;  // 6
                            4'd4: r_motor <= 4'b0110;  // 4
                            4'd5: r_motor <= 4'b0010;  // 12
                            4'd6: r_motor <= 4'b0011;  // 8
                            4'd7: r_motor <= 4'b0001;  // 9
                            default: r_motor <= 4'b0000;
                        endcase
                    endcase
                end
                else begin
                    r_motor <= 4'b0000;
                end
            1'b1:
                if(!i_enable) begin
                    case(i_dir_mode)
                        1'b0:
                            case(r_counter_full % 4)
                                2'd0: r_motor <= 4'b0001;
                                2'd1: r_motor <= 4'b0010;
                                2'd2: r_motor <= 4'b0100;
                                2'd3: r_motor <= 4'b1000;
                                default: r_motor <= 4'b0000;
                            endcase
                        1'b1:
                            case(r_counter_full % 4)
                                2'd0: r_motor <= 4'b1000;
                                2'd1: r_motor <= 4'b0100;
                                2'd2: r_motor <= 4'b0010;
                                2'd3: r_motor <= 4'b0001;
                                default: r_motor <= 4'b0000;
                            endcase
                    endcase
                end
                else begin
                    r_motor <= 4'b0000;
                end
        endcase    
    end 
endmodule