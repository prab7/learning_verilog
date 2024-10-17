module greater_than (a, b, f);

    input [1:0] a,b;
    output f;
    
    // assign f = a > b;

    assign f = (a[1] & ~b[1]) | ((a[1]~^b[1]) & (a[0] & ~b[0]));
    //assign f = a[1] & ~b[1] | a[1] ~^ b[1] & a[0] & ~b[0]; // wrong!

endmodule