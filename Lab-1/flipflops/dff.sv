module D_FF (
    output reg q,
    input d, reset, clk, en
);
    always @ (posedge clk) begin
        if (reset) begin
            q <= 0; // On reset, set q to 0
        end else if (en) begin
            q <= d; // Otherwise, q = d
        end
    end
endmodule

module dff_testbench();

    // Inputs and outputs of the D_FF module
    logic d, reset, clk, en;
    logic q;

    // Instantiate the D_FF module
    D_FF dff_inst (
        .q(q),
        .d(d),
        .reset(reset),
        .clk(clk),
        .en(en)
    );

    // Clock generation
    reg clk_tb = 0;
    always #5 clk = ~clk; // Toggle the clock every 5 time units

    // Stimulus generation
    initial begin
        // Initialize inputs
        d = 0;
        reset = 1; // Start with reset high
        en = 0; // Disable DFF initially
        clk = 0;

        // Apply stimulus
        #20 reset = 0; // Assert reset low after 20 time units

        // Enable DFF and apply data
        #10 en = 1; // Enable DFF after 10 more time units
        #10 d = 1;  // Set D input to 1 after another 10 time units
        #10 d = 0;  // Set D input to 0 after another 10 time units
        #10 d = 1;  // Set D input to 1 after another 10 time units

        // End simulation
        #10 $finish;
    end

    // Display outputs
    always @(posedge clk_tb) begin
        $display("Time %0t: d = %b, q = %b", $time, d, q);
    end

endmodule
