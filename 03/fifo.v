module fifo( Din, Dout, Wen, Ren, rst, ck, Fempty, Ffull);

input [7:0] Din;
input Wen, Ren,ck,rst;
output [7:0] Dout;
output Fempty, Ffull;

reg  [7:0] FMEM[0:15];
reg  [3:0] Wptr, Rptr;
reg  Fempty, Ffull;
reg  [7:0] obuf;
wire [3:0] NWptr, NRptr;

assign Dout = obuf;
assign NWptr = Wptr + 1;
assign NRptr = Rptr + 1;
wire [7:0] f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15;
assign f0 = FMEM[0];
assign f1 = FMEM[1];
assign f2 = FMEM[2];
assign f3 = FMEM[3];
assign f4 = FMEM[4];
assign f5 = FMEM[5];
assign f6 = FMEM[6];
assign f7 = FMEM[7];
assign f8 = FMEM[8];
assign f9 = FMEM[9];
assign f10 = FMEM[10];
assign f11 = FMEM[11];
assign f12 = FMEM[12];
assign f13 = FMEM[13];
assign f14 = FMEM[14];
assign f15 = FMEM[15];

/*
no need to do 'Wptr = 0, when Wptr comes to 15' ...etc, because of overflow.
*/
always @(posedge ck) begin
if(!rst ) begin
  Wptr <=0;
  Rptr <=0;
  Fempty <=1;
  Ffull <=0;
  end else begin

  if (Wen==1 && Ffull==0) begin
    FMEM[Wptr] <= Din;
    Wptr <= NWptr;
    Fempty<=0;
    if (NWptr==Rptr) Ffull<=1;
    else Ffull<=0;
  end

  if (Ren==1 && Fempty==0) begin
    obuf <= FMEM[Rptr];
    Rptr <= NRptr;
    Ffull<=0;
    if(NRptr==Wptr) Fempty<=1;
    else Fempty<=0;
  end
end
end

endmodule