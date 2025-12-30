module RAM #(
    parameter WIDTH = 16,
    parameter DEPTH = 32          // RAM32 par défaut
)(
    input  wire                 clk,
    input  wire                 load,
    input  wire [$clog2(DEPTH)-1:0] address,
    input  wire [WIDTH-1:0]     in,
    output wire [WIDTH-1:0]     out
);

    reg [WIDTH-1:0] mem [0:DEPTH-1];

    // écriture synchrone
    always @(posedge clk) begin
        if (load) begin
            mem[address] <= in;
        end
    end

    // lecture combinatoire
    assign out = mem[address];

endmodule
