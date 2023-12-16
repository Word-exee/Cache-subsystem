`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.11.2023 10:44:46
// Design Name: 
// Module Name: subsystem
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

module cache_and_ram(
	input [31:0] inputAddress,
	input [31:0] inputData,
	input clk,
	input loadEnable,
	input storeEnable,
	output wire [31:0] dataOut,
	output wire storeCompleted,
	output wire validWire,
	output wire readyWire
	
);

wire [31:0]L1BusWire;
//wire cacheBusResetWire;
wire cacheAddressReceiveWire;
wire memoryAddressReceiveWire;
wire [31:0]memoryBusWire;
wire memoryBusResetWire;
wire [3:0]memoryBusCountWire;
wire storeCompleteWire;
// Instantiate L1D Cache and Main Memory modules
cache cache(
    .inputAddress(inputAddress),
    .inputData(inputData),
    .clk(clk),
    .loadEnable(loadEnable),
    .storeEnable(storeEnable),
    .ready(readyWire),  
    .memoryBus(memoryBusWire),
    .L1Bus(L1BusWire),
    .valid(validWire),
    .storeDone(storeCompleted),
    .dataOut(dataOut),
//    .cacheBusReset(cacheBusResetWire),
//    .cacheBusCount(cacheBusCountWire),
    .memoryBusReset(memoryBusResetWire),
    .memoryBusCount(memoryBusCountWire),
    .memoryAddressReceive(memoryAddressReceiveWire),
    .cacheAddressReceive(cacheAddressReceiveWire),
    .cacheStoreComplete(cacheStoreCompleteWire)
    
);
ram memory(
    .clk(clk),
    .loadEnable(loadEnable),
    .storeEnable(storeEnable),
    .ready(readyWire),
    .memoryBus(memoryBusWire),
    .L1Bus(L1BusWire),
    .valid(validWire),
//    .cacheBusReset(cacheBusResetWire),
//    .cacheBusCount(cacheBusCountWire),
    .memoryBusReset(memoryBusResetWire),
    .memoryBusCount(memoryBusCountWire),
    .cacheStoreComplete(cacheStoreCompleteWire),
    .memoryAddressReceive(memoryAddressReceiveWire),
    .cacheAddressReceive(cacheAddressReceiveWire)
    );



endmodule
