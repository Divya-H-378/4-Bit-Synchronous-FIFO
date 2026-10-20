module sync_fifo (
    input wire clk,
    input wire rst,
    input wire wr_en,
    input wire rd_en,
    input wire [3:0] data_in,
    output reg [3:0] data_out,
    output wire full,
    output wire empty
);

    reg [3:0] memory [0:15];
    reg [4:0] wr_ptr, rd_ptr;
    reg [4:0] count;

    assign full = (count == 16);
    assign empty = (count == 0);

    always @(posedge clk) begin
        if (rst) begin
            wr_ptr <= 0;
            rd_ptr <= 0;
            count <= 0;
            data_out <= 0;
        end
        else begin
            case ({wr_en && !full, rd_en && !empty})
                2'b10: begin
                    memory[wr_ptr[3:0]] <= data_in;
                    wr_ptr <= wr_ptr + 1;
                    count <= count + 1;
                end

                2'b01: begin
                    data_out <= memory[rd_ptr[3:0]];
                    rd_ptr <= rd_ptr + 1;
                    count <= count - 1;
                end

                2'b11: begin
                    memory[wr_ptr[3:0]] <= data_in;
                    data_out <= memory[rd_ptr[3:0]];
                    wr_ptr <= wr_ptr + 1;
                    rd_ptr <= rd_ptr + 1;
                end
            endcase
        end
    end

endmodule
