module rx(input logic clk, rst,
          input logic uart,
          output logic [7:0] data,
          output we);

logic uart_, rx_bit, rx_bit_;
logic [1:0] filter;

always_ff @(posedge clk)
  if(rst) begin
    uart_ <= 1;
    filter <= 3;
    rx_bit <= 1;
    rx_bit_ <= 1;
  end
  else begin
    uart_ <= uart;
    if( uart_ && filter != 3) filter <= filter+1;
    if(!uart_ && filter != 0) filter <= filter-1;
    if(filter == 3) rx_bit <= 1;
    if(filter == 0) rx_bit <= 0;
    rx_bit_ <= rx_bit;
  end

logic [7:0] shifter;
logic start, middle, charended;

always_comb start <= rx_bit_ & ~rx_bit & charended;

timer_uart (.clk(clk), .rst(rst),
            .start(start),
            .middle(middle), .charend(we), .charended(charended) );

always_comb data <= {rx_bit, shifter[7:1]};

always_ff @(posedge clk)
  if(rst)  shifter <= 0;
  else
    if(middle & ~charended) shifter <= data;

endmodule

