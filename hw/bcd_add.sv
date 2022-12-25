//sum two 8-digit bcd numbers
module bcd_add_8(input logic [3:0] a[7:0], input logic [3:0] b[7:0], output logic[3:0] s[7:0], output logic cout);
  bcd_add #(8) Bcd_add(a, b, s, cout);
endmodule


module bcd_add 
        #(parameter width = 2)
        (input logic [3:0] a[width - 1:0], 
         input logic [3:0] b[width - 1:0], 
         output logic[3:0] s[width - 1:0], output logic cout);
    genvar i;
    logic carry[width - 2:0];

    bcd_adder Adder0(a[0], b[0], 1'b0    , s[0], carry[0]);

    generate 
        for(i=1; i < (width - 1); i=i+1) begin
            bcd_adder AdderI(a[i], b[i], carry[i-1], s[i], carry[i]);
        end
    endgenerate

    bcd_adder AdderN(a[width-1], b[width-1], carry[width-2], s[width-1], cout);

endmodule

module bcd_adder(input logic [3:0] a, input logic[3:0] b, input logic cin, output logic[3:0] s, output logic cout);
    logic [4:0] s1;
    logic [4:0] s2;
    logic less_than_9;
    always_comb begin : do_add
        s1 = a + b + {4'b0,cin};
        {less_than_9, s2} = s1 - 10;
        cout = ~less_than_9;

        case(less_than_9)
        0: {1'b0,s} = s2;
        1: {1'b0,s} = s1;
        endcase
    end
endmodule