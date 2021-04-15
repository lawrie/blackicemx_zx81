`timescale 1ns / 1ps
`default_nettype none

module zx81 (
    input wire         clk_25mhz,
    input wire         ear,

    output wire [2:0]  led,

    output wire        hsync,
    output wire        vsync,
    output wire[3:0]   red,
    output wire[3:0]   green,
    output wire[3:0]   blue,

    input wire         ps2_clk,
    input wire         ps2_data

  );

  assign led = 0;

  wire video; // 1-bit video signal (black/white)

  // Trivial conversion for audio
  wire mic,spk;
  
  // Video timing
  wire vga_blank;

  // Power-on RESET (8 clocks)
  reg [7:0] poweron_reset = 8'h00;
  always @(posedge clk_sys) begin
    poweron_reset <= {poweron_reset[6:0],1'b1};
  end

  reg clk_sys; 
  wire [10:0] ps2_key;

  always @(posedge clk_25mhz) clk_sys <= ~clk_sys;

  // The ZX80/ZX81 core
  fpga_zx81 the_core (
    .clk_sys(clk_sys),
    .reset_n(poweron_reset[7]),
    .ear(ear),
    .ps2_key(ps2_key),
    .video(video),
    .hsync(hsync),
    .vsync(vsync),
    .vde(vga_blank),
    .mic(mic),
    .spk(spk),
    .zx81(1'b1)
  );

  assign red = {4{video}};
  assign green = {4{video}};
  assign blue = {4{video}};

  // Get PS/2 keyboard events
  ps2 ps2_kbd (
     .clk(clk_sys),
     .ps2_clk(ps2_clk),
     .ps2_data(ps2_data),
     .ps2_key(ps2_key)
  );

endmodule

