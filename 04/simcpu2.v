module simcpu;
reg CK, RST;
wire RW;
wire [15:0] IA, DA, DD;
reg [15:0] ID, DDi;
reg [15:0] IMEM [0:127], DMEM[0:127];

	CPU c(CK,RST,IA,ID,DA,DD,RW);

   assign DD = ((RW == 1) ? DDi : 'b Z);

initial begin
	CK = 0;
	RST = 0;
#5	RST = 1;
#100	RST = 0;

        #10000 $finish;
end

always @(negedge CK) begin
   if( DA == 'b 0 && DD == 'b 0100 && RW == 0 ) begin
      $display( "OK" );
      $finish;
   end
end

always @(negedge CK) begin
	ID = IMEM[IA];
end

always @(negedge CK) begin
   if( RW == 1 ) DDi = DMEM[DA];
   else DMEM[DA] = DD;
end


initial begin
IMEM[0]=  'b 1100_0000_0000_0000; // IMM  R0, [0]
IMEM[1]=  'b 1100_0001_0000_0001; // IMM  R1, [1]
IMEM[2]=  'b 1100_0010_0000_0010; // IMM  R2, [2]
IMEM[3]=  'b 1011_0011_0000_0000; // load R3  R0[0]
IMEM[4]=  'b 1011_0100_0000_0001; // load R4  R1[1]
IMEM[5]=  'b 1100_0101_0000_0000; // IMM  R5, [0]
IMEM[6]=  'b 1100_0110_0000_1000; // IMM  R6  [8]
IMEM[7]=  'b 1100_0111_0000_1100; // IMM  R7  [12]
IMEM[8]=  'b 0000_0101_0101_0011; // add  R5 R5  R3
IMEM[9]=  'b 0001_0100_0100_0001; // sub  R4 R4  R1
IMEM[10]= 'b 1001_0000_0000_0111; // if R7[12]
IMEM[11]= 'b 1000_0000_0000_0110; // jump R6[8]
IMEM[12]= 'b 1010_0000_0101_0010; // store R5 -> R2[2]

DMEM[0]=  'b 0000_0000_0000_0010; // 2
DMEM[1]=  'b 0000_0000_0000_0111; // 7

$monitor("%t: DMEM[2] = %", $time, DMEM[2]);
end

always #10 CK = ~CK;

endmodule
