module timer_uart #(parameter max_bit_count = 9, baud = 115_200)
                  (input clk, rst,
                   input start,
                   output middle, bitend, charend, charended);

  localparam clock_freq = 50_000_000;
  localparam max_clk_count = clock_freq/baud;

  logic [19:0] clk_counter;  // sufficient for down to 75 baud

  always_ff @(posedge clk)
    if(rst) clk_counter <= 0;
    else
      if(start) clk_counter <= 0;
      else
        if(clk_counter < max_clk_count) clk_counter <= clk_counter + 1;
        else clk_counter <= 0;

  always_comb begin
    middle <= (clk_counter == max_clk_count/2);
    bitend <= (clk_counter == max_clk_count);
  end

  logic [3:0] bit_counter;  // 1 start bit, 8 char bit, 2 stop bits

  always_ff @(posedge clk)
    if(rst) bit_counter <= max_bit_count;
    else
      if(start) bit_counter <= 0;
      else
        if(bitend & ~charended) bit_counter <= bit_counter + 1;

  always_comb begin
    charend   <= middle && (bit_counter == max_bit_count-1);
    charended <= (bit_counter == max_bit_count);
  end

endmodule

