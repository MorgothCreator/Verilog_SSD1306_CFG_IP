`timescale 10ns / 10ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2017 05:51:26 PM
// Design Name: 
// Module Name: SSD1306_SIMULATE
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
`define	OSC_FREQ_HZ	100000000

`define BLOCK_ROM_INIT_ADDR_WIDTH	7
`define BLOCK_ROM_INIT_DATA_WIDTH	48

module	SSD1306_SIMULATE(
	output	reg oled_dc,
	output	reg oled_res,
	output	oled_sclk,
	output	oled_sdin,
	output	reg oled_vbat,
	output	reg oled_vdd
);
reg btnc;	

reg wait_spi;
reg rd_spi;
reg wr_spi;
				
	reg	clk_in	=	0;
	reg	clk_out	=	0;
	parameter	tck	=	3;	///<	clock	tick
				
	always	#(tck/2)	clk_in	<=	~clk_in;	//	clocking	device
	
wire buffempty;
wire charreceived;
		
reg [27:0]time_count;
reg [27:0]time_count_back;
reg [`BLOCK_ROM_INIT_ADDR_WIDTH-1:0]state_machine_count;
wire [`BLOCK_ROM_INIT_DATA_WIDTH-1:0]rom_bus;
		
reg [3:0]clk_div;

reg internal_state_machine;
reg [9:0]repeat_count;
	
initial begin
	#2;
	btnc <= 1'b1;
	#2;
	btnc <= 1'b0;
	time_count <= 28'h0000000;
	state_machine_count <= `BLOCK_ROM_INIT_ADDR_WIDTH'h00;
	internal_state_machine <= 1'b0;
	repeat_count <= 10'h000;
end
				
always @ (*)
begin
	if(!rom_bus[7])
	begin
		oled_vdd <= rom_bus[6];
		oled_vbat <= rom_bus[5];
		oled_res <= rom_bus[4];
		oled_dc <= rom_bus[3];
		wr_spi <= rom_bus[2];
		rd_spi <= rom_bus[1];
		wait_spi <= rom_bus[0];
	end
end
	
always @ (posedge clk_in)
begin
	if(btnc)
		clk_div <= 4'h0;
	else
		clk_div <= clk_div + 1;
end
	
block_rom_oled_init oled_rom_init(
	.addr(state_machine_count),
	.dout(rom_bus)
);
	
spi_master	#	(
.WORD_LEN(8),/*	Default	8	*/
.PRESCALLER_SIZE(8)/*	Default	8	/	Max	8*/
)
spi0(
	.clk(clk_div[3]),
	.rst(btnc),
	.data_in(rom_bus[15:8]),
	//.data_out(data_tmp),
	.wr(wr_spi),
	.rd(rd_spi),
	.buffempty(buffempty),
	.prescaller(3'h4),
	.sck(oled_sclk),
	.mosi(oled_sdin),
	//.miso(miso),
	//.ss(ss),
	.lsbfirst(1'b0),
	.mode(2'h0),
	//.senderr(senderr),
	//.res_senderr(res_senderr),
	.charreceived(charreceived)
);
		
//`define	US_TO_CICLES(US)				((`OSC_FREQ_HZ	/	1000000)	*	US)
	
always @ (posedge clk_div[3])
begin
	if(btnc)
	begin
		time_count <= 28'h0000000;
		state_machine_count <= `BLOCK_ROM_INIT_ADDR_WIDTH'h00;
		internal_state_machine <= 1'b0;
		repeat_count <= 10'h000;
	end
	else
	begin
		if(rom_bus[39:16] == time_count)
		begin
			case(internal_state_machine)
				1'b0 : begin
					if(rom_bus[7])
					begin
						repeat_count <= {rom_bus[6:0], rom_bus[15:8]};
						time_count_back <= time_count + 1;
					end
					else
						if(repeat_count && rom_bus[46:44] > 1)
							repeat_count <= repeat_count - 15'h0001;
					internal_state_machine <= 1'b1;
				end
				1'b1 : begin
				if(wait_spi)
				begin
					if(charreceived)
					begin
						internal_state_machine <= 1'b0;
						if(repeat_count)
						begin
							time_count <= time_count_back;
							if(rom_bus[47])
								state_machine_count <= state_machine_count - rom_bus[46:44];
							else
								state_machine_count <= state_machine_count + rom_bus[46:44];
							end
							else
							begin
								time_count <= time_count + 1;
								state_machine_count <= state_machine_count + `BLOCK_ROM_INIT_ADDR_WIDTH'h01;
							end
						end
					end
					else
					begin
						internal_state_machine <= 1'b0;
						if(repeat_count)
						begin
							time_count <= time_count_back;
							if(rom_bus[47])
								state_machine_count <= state_machine_count - rom_bus[46:44];
							else
								state_machine_count <= state_machine_count + rom_bus[46:44];
						end
						else
						begin
							time_count <= time_count + 1;
							state_machine_count <= state_machine_count + `BLOCK_ROM_INIT_ADDR_WIDTH'h01;
						end
					end
				end
			endcase
		end
		else
			time_count <= time_count + 1;
	end
end

endmodule
