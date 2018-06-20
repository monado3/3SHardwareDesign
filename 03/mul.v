module mul(A,B,O,ck,start,fin);
input [7:0] A,B;
input ck,start;
output [16:0] O;
output fin;

wire [7:0] A,B;
reg [16:0] O;
reg [7:0] AIN,BIN;
reg [3:0] st;
reg fin;

always @(posedge ck) begin
  if (start == 1) begin
    AIN <= A;
    BIN <= B;
    O <= 0;
    st <= 0;
    fin <= 0;
  end else begin
    case (st)
    0:O <= (O<<1) + AIN*BIN[7];
    1:O <= (O<<1) + AIN*BIN[6];
    2:O <= (O<<1) + AIN*BIN[5];
    3:O <= (O<<1) + AIN*BIN[4];
    4:O <= (O<<1) + AIN*BIN[3];
    5:O <= (O<<1) + AIN*BIN[2];
    6:O <= (O<<1) + AIN*BIN[1];
    7: begin O <= (O<<1) + AIN*BIN[0]; fin<= 1; end
    8: fin <= 0;
    endcase
    st <= st + 1;
  end
end

endmodule
