module tx(input logic clk, rst,
          input logic empty,
          input logic [7:0] data,
          output logic start, uart);

logic ready, ready_, bitend, charended;
always_comb ready <= ~empty & charended;
always_ff @(posedge clk)
  if (rst) ready_ <= 1;
  else     ready_ <= ready;
always_comb start <= ready & ~ready_;

timer_uart #(10) (.clk(clk), .rst(rst),
   .start(start),
   .bitend(bitend), .charended(charended) );

logic [8:0] shifter;

always_ff @(posedge clk)
  if(rst)  shifter <= -1;
  else
    if(start) shifter <= {data, 1'b0};
    else
     if(bitend) shifter <= {1'b1, shifter[8:1]};

always_comb uart <= shifter[0];

endmodule

