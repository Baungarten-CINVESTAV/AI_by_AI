// SPDX-FileCopyrightText: 2020 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

`default_nettype wire

`timescale 1 ns / 1 ps

module Ay_by_AI_test_tb;
	reg clock;
	reg RSTB;
	reg CSB;
	reg power1, power2;
	reg power3, power4;

	wire gpio;
	wire [37:0] mprj_io;
	wire [7:0] mprj_io_0;

	//assign mprj_io_0 = mprj_io[7:0];
	// assign mprj_io_0 = {mprj_io[8:4],mprj_io[2:0]};

	//assign mprj_io[3] = (CSB == 1'b1) ? 1'b1 : 1'bz;
	// assign mprj_io[3] = 1'b1;

	// External clock is used by default.  Make this artificially fast for the
	// simulation.  Normally this would be a slow clock and the digital PLL
	// would be the fast clock.

	always #12.5 clock <= (clock === 1'b0);

	initial begin
		clock = 0;
	end


	`ifdef ENABLE_SDF
		initial begin
			$sdf_annotate("../../../sdf/user_proj_example.sdf", uut.mprj) ;
			$sdf_annotate("../../../sdf/user_project_wrapper.sdf", uut.mprj.mprj) ;
			$sdf_annotate("../../../mgmt_core_wrapper/sdf/DFFRAM.sdf", uut.soc.DFFRAM_0) ;
			$sdf_annotate("../../../mgmt_core_wrapper/sdf/mgmt_core.sdf", uut.soc.core) ;
			$sdf_annotate("../../../caravel/sdf/housekeeping.sdf", uut.housekeeping) ;
			$sdf_annotate("../../../caravel/sdf/chip_io.sdf", uut.padframe) ;
			$sdf_annotate("../../../caravel/sdf/mprj_logic_high.sdf", uut.mgmt_buffers.mprj_logic_high_inst) ;
			$sdf_annotate("../../../caravel/sdf/mprj2_logic_high.sdf", uut.mgmt_buffers.mprj2_logic_high_inst) ;
			$sdf_annotate("../../../caravel/sdf/mgmt_protect_hv.sdf", uut.mgmt_buffers.powergood_check) ;
			$sdf_annotate("../../../caravel/sdf/mgmt_protect.sdf", uut.mgmt_buffers) ;
			$sdf_annotate("../../../caravel/sdf/caravel_clocking.sdf", uut.clocking) ;
			$sdf_annotate("../../../caravel/sdf/digital_pll.sdf", uut.pll) ;
			$sdf_annotate("../../../caravel/sdf/xres_buf.sdf", uut.rstb_level) ;
			$sdf_annotate("../../../caravel/sdf/user_id_programming.sdf", uut.user_id_value) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_bidir_1[0] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_bidir_1[1] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_bidir_2[0] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_bidir_2[1] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_bidir_2[2] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[0] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[1] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[2] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[3] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[4] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[5] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[6] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[7] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[8] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[9] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[10] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1a[0] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1a[1] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1a[2] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1a[3] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1a[4] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1a[5] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[0] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[1] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[2] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[3] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[4] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[5] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[6] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[7] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[8] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[9] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[10] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[11] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[12] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[13] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[14] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[15] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.\gpio_defaults_block_0[0] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.\gpio_defaults_block_0[1] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.\gpio_defaults_block_2[0] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.\gpio_defaults_block_2[1] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.\gpio_defaults_block_2[2] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_5) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_6) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_7) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_8) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_9) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_10) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_11) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_12) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_13) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_14) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_15) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_16) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_17) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_18) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_19) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_20) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_21) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_22) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_23) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_24) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_25) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_26) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_27) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_28) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_29) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_30) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_31) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_32) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_33) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_34) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_35) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_36) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_37) ;
		end
	`endif 



	initial begin
		RSTB <= 1'b0;
		CSB  <= 1'b1;		// Force CSB high
		#2000;
		RSTB <= 1'b1;	    	// Release reset
		#3_00_000;
		CSB = 1'b0;		// CSB can be released
	end

	initial begin		// Power-up sequence
		power1 <= 1'b0;
		power2 <= 1'b0;
		power3 <= 1'b0;
		power4 <= 1'b0;
		#100;
		power1 <= 1'b1;
		#100;
		power2 <= 1'b1;
		#100;
		power3 <= 1'b1;
		#100;
		power4 <= 1'b1;
	end


	wire flash_csb;
	wire flash_clk;
	wire flash_io0;
	wire flash_io1;

	wire VDD3V3;
	wire VDD1V8;
	wire VSS;
	
	assign VDD3V3 = power1;
	assign VDD1V8 = power2;
	assign VSS = 1'b0;
	

	caravel uut (
		.vddio	  (VDD3V3),
		.vddio_2  (VDD3V3),
		.vssio	  (VSS),
		.vssio_2  (VSS),
		.vdda	  (VDD3V3),
		.vssa	  (VSS),
		.vccd	  (VDD1V8),
		.vssd	  (VSS),
		.vdda1    (VDD3V3),
		.vdda1_2  (VDD3V3),
		.vdda2    (VDD3V3),
		.vssa1	  (VSS),
		.vssa1_2  (VSS),
		.vssa2	  (VSS),
		.vccd1	  (VDD1V8),
		.vccd2	  (VDD1V8),
		.vssd1	  (VSS),
		.vssd2	  (VSS),
		.clock    (clock),
		.gpio     (gpio),
		.mprj_io  (mprj_io),
		.flash_csb(flash_csb),
		.flash_clk(flash_clk),
		.flash_io0(flash_io0),
		.flash_io1(flash_io1),
		.resetb	  (RSTB)
	);

	spiflash #(
		.FILENAME("Ay_by_AI_test.hex")
	) spiflash (
		.csb(flash_csb),
		.clk(flash_clk),
		.io0(flash_io0),
		.io1(flash_io1),
		.io2(),			// not used
		.io3()			// not used
	);
	
	
	//////////// Test Mnist set ////////////////
		/////////////connections//////////////////
/*
	ap_clk ----->  wb_clk_i
	
	ap_rst ----->  la_data_in[1]|io_in[1]
	ap_start ----->  la_data_out[2]
	
	ap_done ----->  la_data_out[3]
	ap_idle ----->  la_data_out[4]
	ap_ready ----->  la_data_out[5]
	ap_return ----->  la_data_out[31:28]


	image_r_Addr_A ----->  io_out[11:0]
	image_r_EN_A ----->  io_out[12] 
	image_r_WEN_A ----->  N/A
	image_r_Din_A ----->  N/A
	image_r_Dout_A ----->  o_in[28:13]
	image_r_Clk_A ----->  io_out[29]
	image_r_Rst_A ----->  N/A
*/

reg [3:0] correct_label [0:99];
//string filenames[0:99];  // Declare an array for 100 filenames
  integer image_file;
  real accuracy;
  
    reg [15:0] memory [0:1024]; // Define a memory block (adjust the size as needed)
    reg [15:0] memory2 [0:1024]; // Define a memory block (adjust the size as needed)
  wire [31:0] image_r_Addr_A;
  wire image_r_EN_A;
  wire [1:0] image_r_WEN_A;
  wire [15:0] image_r_Din_A;
  reg [15:0] image_r_Dout_A;
  wire   image_r_Clk_A;
wire   image_r_Rst_A;


 reg [31:0] Test_addr;
 reg [15:0] output_mem_test;

assign image_r_Addr_A = mprj_io[11+5:0+5];
assign  image_r_EN_A = mprj_io[12+5];
assign mprj_io[28+5:13+5] = image_r_Dout_A;
//assign image_r_Clk_A = mprj_io[29+5];
assign image_r_Clk_A =clock;

initial
begin
/*
filenames[0] = "image_0.txt";

filenames[1] = "image_1.txt";
filenames[2] = "image_2.txt";
filenames[3] = "image_3.txt";
filenames[4] = "image_4.txt";
filenames[5] = "image_5.txt";
filenames[6] = "image_6.txt";
filenames[7] = "image_7.txt";
filenames[8] = "image_8.txt";
filenames[9] = "image_9.txt";
filenames[10] = "image_10.txt";
filenames[11] = "image_11.txt";
filenames[12] = "image_12.txt";
filenames[13] = "image_13.txt";
filenames[14] = "image_14.txt";
filenames[15] = "image_15.txt";
filenames[16] = "image_16.txt";
filenames[17] = "image_17.txt";
filenames[18] = "image_18.txt";
filenames[19] = "image_19.txt";
filenames[20] = "image_20.txt";
filenames[21] = "image_21.txt";
filenames[22] = "image_22.txt";
filenames[23] = "image_23.txt";
filenames[24] = "image_24.txt";
filenames[25] = "image_25.txt";
filenames[26] = "image_26.txt";
filenames[27] = "image_27.txt";
filenames[28] = "image_28.txt";
filenames[29] = "image_29.txt";
filenames[30] = "image_30.txt";
filenames[31] = "image_31.txt";
filenames[32] = "image_32.txt";
filenames[33] = "image_33.txt";
filenames[34] = "image_34.txt";
filenames[35] = "image_35.txt";
filenames[36] = "image_36.txt";
filenames[37] = "image_37.txt";
filenames[38] = "image_38.txt";
filenames[39] = "image_39.txt";
filenames[40] = "image_40.txt";
filenames[41] = "image_41.txt";
filenames[42] = "image_42.txt";
filenames[43] = "image_43.txt";
filenames[44] = "image_44.txt";
filenames[45] = "image_45.txt";
filenames[46] = "image_46.txt";
filenames[47] = "image_47.txt";
filenames[48] = "image_48.txt";
filenames[49] = "image_49.txt";
filenames[50] = "image_50.txt";
filenames[51] = "image_51.txt";
filenames[52] = "image_52.txt";
filenames[53] = "image_53.txt";
filenames[54] = "image_54.txt";
filenames[55] = "image_55.txt";
filenames[56] = "image_56.txt";
filenames[57] = "image_57.txt";
filenames[58] = "image_58.txt";
filenames[59] = "image_59.txt";
filenames[60] = "image_60.txt";
filenames[61] = "image_61.txt";
filenames[62] = "image_62.txt";
filenames[63] = "image_63.txt";
filenames[64] = "image_64.txt";
filenames[65] = "image_65.txt";
filenames[66] = "image_66.txt";
filenames[67] = "image_67.txt";
filenames[68] = "image_68.txt";
filenames[69] = "image_69.txt";
filenames[70] = "image_70.txt";
filenames[71] = "image_71.txt";
filenames[72] = "image_72.txt";
filenames[73] = "image_73.txt";
filenames[74] = "image_74.txt";
filenames[75] = "image_75.txt";
filenames[76] = "image_76.txt";
filenames[77] = "image_77.txt";
filenames[78] = "image_78.txt";
filenames[79] = "image_79.txt";
filenames[80] = "image_80.txt";
filenames[81] = "image_81.txt";
filenames[82] = "image_82.txt";
filenames[83] = "image_83.txt";
filenames[84] = "image_84.txt";
filenames[85] = "image_85.txt";
filenames[86] = "image_86.txt";
filenames[87] = "image_87.txt";
filenames[88] = "image_88.txt";
filenames[89] = "image_89.txt";
filenames[90] = "image_90.txt";
filenames[91] = "image_91.txt";
filenames[92] = "image_92.txt";
filenames[93] = "image_93.txt";
filenames[94] = "image_94.txt";
filenames[95] = "image_95.txt";
filenames[96] = "image_96.txt";
filenames[97] = "image_97.txt";
filenames[98] = "image_98.txt";
filenames[99] = "image_99.txt";
*/
end

initial begin
//	for (i = 0; i < 1; i = i + 1) begin
		Test_addr = 0;
		$readmemh("image_10.txt", memory);
		$readmemh("image_10.txt", memory2);
		#10000000
		

	$display("Simulation completed.");
	$finish;
//    end
end

assign image_r_Rst_A = 0;

////////////////////////Memory block Simulation ////////////////////
// Synchronous Read Logic
  always @(posedge image_r_Clk_A) begin
	if (image_r_EN_A) begin
      image_r_Dout_A <= memory[image_r_Addr_A>>1'd1];
    end
  end
 
	initial begin
		$dumpfile("Ay_by_AI_test.vcd");
		$dumpvars;
	end
 
 

	// Synchronous Read Logic
  always @(posedge image_r_Clk_A) begin
  	Test_addr = Test_addr+ 1;
      output_mem_test <= memory2[Test_addr];
  end

endmodule

