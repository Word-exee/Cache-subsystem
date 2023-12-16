`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.11.2023 22:58:33
// Design Name: 
// Module Name: testbench
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module testbench;

reg [31:0] inputAddress, inputData;
reg loadEnable, storeEnable, clk;
wire [31:0] dataOut;
wire storeCompleted;
wire ready;
wire valid;


cache_and_ram tb(
	.inputAddress(inputAddress),
	.inputData(inputData),
	.loadEnable(loadEnable),
	.storeEnable(storeEnable),
	.clk(clk),
	.dataOut(dataOut),
	.storeCompleted(storeCompleted),
    .readyWire(ready),

    .validWire(valid)
    );


initial
begin
	clk = 1'b1;
	inputAddress =0;			// 0
	inputData =    32'b00000000000000000000000000000001;			// 14528
	loadEnable= 1'b1;
	storeEnable=1'b0;
	
	#200
	inputAddress = 32'b00000000000000000000000000001100;			// 0
	inputData =    32'b00000000000000000000000000000010;			// 14528
	loadEnable= 1'b1;
	storeEnable=1'b0;
	
//	#200
//    inputAddress = 32'b00000000000000000000000000000000;			// 0
//	inputData =    32'b00000000000000000000000000000011;			// 14528
//	loadEnable= 1'b1;
//	storeEnable=1'b0;

//	#200
//	inputAddress = 32'b00000000000000000000000001010100;			// 0
//	inputData =    32'b00000000000000000000000000000100;			// 14528
//	loadEnable= 1'b1;
//	storeEnable=1'b0;

//	#200
//	inputAddress = 32'b00000000000000000000000010000000;			// 0
//	inputData =    32'b00000000000000000011100011000000;			// 14528
//	loadEnable= 1'b1;
//	storeEnable=1'b0;

	#200
	inputAddress = 32'b00000000000000000000000001000000;			// 0
	inputData =    32'b00000000000000000011100011000000;			// 14528
	loadEnable= 1'b1;
	storeEnable=1'b0;
	
	#200
	inputAddress = 32'b00000000000000000000000000000000;			// 0
	inputData =    32'b00000000000000000011100011000000;			// 14528
	loadEnable= 1'b1;
	storeEnable=1'b0;
		
	#200
	inputAddress = 32'b00000000000000000000000000000000;			// 0
	inputData =    32'b00000000000000000011100011000000;			// 14528
	loadEnable= 1'b0;
	storeEnable=1'b1;
end

initial
$monitor("address = %d data = %d mode = %d out = %d", inputAddress % 4096, inputData, loadEnable,storeEnable,valid,ready, dataOut,storeCompleted);

always #25 clk = ~clk;

endmodule 
