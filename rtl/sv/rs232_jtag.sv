module rs232_jtag(input logic clk, rst,
                  input  logic rx,
                  output logic tx);

logic [7:0] rx_data, tx_data;
logic rx_we, tx_start, empty;

rx (.clk(clk), .rst(rst),
    .uart(rx),
    .data(rx_data), .we(rx_we));

jtag_uart (.clk(clk), .rst(rst),
           .rx_data(rx_data), .rx_we(rx_we),
           .tx_data(tx_data), .rx_rd(tx_start), .tx_empty(empty));

tx (.clk(clk), .rst(rst),
    .data(tx_data), .start(tx_start), .empty(empty),
    .uart(tx));

endmodule

