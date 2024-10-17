module combn_block_nonblock (
    input a, b, c,
    output x
);

    always @(a, b, c) begin
        // x = a;    // blocks evaluation of the next statement till this gets evaluated
        // x = x ^ b; // blocks evaluation of the next statement till this gets evaluated
        // x = x | c;  

        // above is just equivalent to x = a^b | c;
        // order matters!!

        x <= a;     // okay, next
        x <= x ^ b;  // okay, ditch the last. next
        x <= x | c;  // cool, ditch the last

        // produces x = x | c; without a latch. nonsense circuit.
        // order doesnt matter

    end

endmodule

// Block assignments are sequential 
// non-Blocking assignments are parallel (YOU THOUGHT!!)

// blocking -> immediate assignments
// non-blocking => deferred assignments
