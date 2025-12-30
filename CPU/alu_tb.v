`timescale 1ns/1ps

module alu_tb;

  // Entrées
  reg [15:0] x;
  reg [15:0] y;
  reg zx, nx, zy, ny, f, no;

  // Sorties
  wire [15:0] out;
  wire zr, ng;

  // Référence
  reg [15:0] ref_out;
  reg ref_zr;
  reg ref_ng;

  integer ctrl;
  integer i;

  // =========================
  // DUT
  // =========================
  alu dut (
    .x(x), .y(y),
    .zx(zx), .nx(nx),
    .zy(zy), .ny(ny),
    .f(f),  .no(no),
    .out(out),
    .zr(zr),
    .ng(ng)
  );

  // =========================
  // Test
  // =========================
  initial begin
    $display("==== Hack ALU exhaustive test (iverilog safe) ====");

    for (ctrl = 0; ctrl < 64; ctrl = ctrl + 1) begin
      zx = ctrl[5];
      nx = ctrl[4];
      zy = ctrl[3];
      ny = ctrl[2];
      f  = ctrl[1];
      no = ctrl[0];

      for (i = 0; i < 8; i = i + 1) begin

        // Jeux de test
        case (i)
          0: begin x = 16'h0000; y = 16'h0000; end
          1: begin x = 16'h0001; y = 16'h0001; end
          2: begin x = 16'hFFFF; y = 16'h0001; end
          3: begin x = 16'h1234; y = 16'h5678; end
          4: begin x = 16'h8000; y = 16'h0001; end
          5: begin x = 16'h7FFF; y = 16'h0001; end
          6: begin x = 16'hAAAA; y = 16'h5555; end
          7: begin x = 16'hF0F0; y = 16'h0F0F; end
        endcase

        #1;

        // =========================
        // Référence logicielle
        // =========================
        ref_out = zx ? 16'h0000 : x;
        if (nx) ref_out = ~ref_out;

        begin
          reg [15:0] yy;
          yy = zy ? 16'h0000 : y;
          if (ny) yy = ~yy;

          if (f)
            ref_out = ref_out + yy;
          else
            ref_out = ref_out & yy;
        end

        if (no) ref_out = ~ref_out;

        ref_zr = (ref_out == 16'h0000);
        ref_ng = ref_out[15];

        // =========================
        // Comparaisons
        // =========================
        if (out !== ref_out ||
            zr  !== ref_zr  ||
            ng  !== ref_ng) begin

          $display("❌ ERROR");
          $display("ctrl=%b zx=%b nx=%b zy=%b ny=%b f=%b no=%b",
                   ctrl, zx,nx,zy,ny,f,no);
          $display("x=%h y=%h", x, y);
          $display("out=%h zr=%b ng=%b",
                   out, zr, ng);
          $display("expected out=%h zr=%b ng=%b",
                   ref_out, ref_zr, ref_ng);
          $fatal;
        end
      end
    end

    $display("✅ ALL TESTS PASSED");
    $finish;
  end

endmodule
