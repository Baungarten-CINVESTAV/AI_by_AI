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
/*
 *-------------------------------------------------------------
 *
 * user_project_wrapper
 *
 * This wrapper enumerates all of the pins available to the
 * user for the user project.
 *
 * An example user project is provided in this wrapper.  The
 * example should be removed and replaced with the actual
 * user project.
 *
 *-------------------------------------------------------------
 */

module user_project_wrapper #(
    parameter BITS = 32
) (
`ifdef USE_POWER_PINS
    inout vdda1,	// User area 1 3.3V supply
    inout vdda2,	// User area 2 3.3V supply
    inout vssa1,	// User area 1 analog ground
    inout vssa2,	// User area 2 analog ground
    inout vccd1,	// User area 1 1.8V supply
    inout vccd2,	// User area 2 1.8v supply
    inout vssd1,	// User area 1 digital ground
    inout vssd2,	// User area 2 digital ground
`endif

    // Wishbone Slave ports (WB MI A)
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output wbs_ack_o,
    output [31:0] wbs_dat_o,

    // Logic Analyzer Signals
    input  [127:0] la_data_in,
    output [127:0] la_data_out,
    input  [127:0] la_oenb,

    // IOs
    input  [`MPRJ_IO_PADS-1:0] io_in,
    output [`MPRJ_IO_PADS-1:0] io_out,
    output [`MPRJ_IO_PADS-1:0] io_oeb,

    // Analog (direct connection to GPIO pad---use with caution)
    // Note that analog I/O is not available on the 7 lowest-numbered
    // GPIO pads, and so the analog_io indexing is offset from the
    // GPIO indexing by 7 (also upper 2 GPIOs do not have analog_io).
    inout [`MPRJ_IO_PADS-10:0] analog_io,

    // Independent clock (on independent integer divider)
    input   user_clock2,

    // User maskable interrupt signals
    output [2:0] user_irq
);

/*--------------------------------------*/
/* User project is instantiated  here   */
/*--------------------------------------*/

  wire in_ap_rst;
  wire _in_ap_start;
  wire _ap_done;
  wire _ap_idle;
  wire _ap_ready;

  wire [31:0] _image_r_Addr_A;
  wire _image_r_EN_A;
  wire [1:0] _image_r_WEN_A;
  wire [15:0] _image_r_Din_A;
  wire [15:0] i_in_image_r_Dout_A;
  wire   _image_r_Clk_A;
  wire   _image_r_Rst_A;
  

 wire  [3:0] _ap_return;
 
 assign in_ap_rst = la_data_in[1]|io_in[30+5];
 assign io_oeb[30]=1;

 assign  _in_ap_start = la_data_in[2];
 assign la_data_out[3]=_ap_done;
 assign  la_data_out[4]=_ap_idle;
 assign  la_data_out[5]=_ap_ready;
 assign  la_data_out[31:28] = _ap_return;
 
 
 //DEfault to avoid errors
 assign la_data_out[2:0] = 3'b0;
  assign la_data_out[27:6] = 22'b0;
  assign la_data_out[127:32] = 96'b0;
  assign wbs_ack_o = 1'b0;
  assign wbs_dat_o = 0;
  assign user_irq = 3'b0;
  assign io_oeb[4:0] = 4'd0;
  assign io_out[4:0] = 4'd0;
assign io_oeb[37:35] = 3'd0;
assign io_out[33:18] = 0;
assign io_out[37:35] = 3'd0;
 //External memory controls
  assign io_out[11+5:0+5] = _image_r_Addr_A[11:0]; //Addres
  assign io_oeb[11+5:0+5] = 11'b0;
  
  assign io_out[12+5] = _image_r_EN_A; //r_Enb
  assign io_oeb[12+5]=0;
   
  assign i_in_image_r_Dout_A = io_in[28+5:13+5]; //Data_input
   assign io_oeb[28+5:13+5]=16'hFFFF;
  
  assign io_out[29+5] = _image_r_Clk_A; //CLK
   assign io_oeb[29+5]=0;

/////////////connections//////////////////
/*
ap_clk ----->  wb_clk_i
ap_rst ----->  la_data_in[1]|io_in[30]

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

  forward_pass AI_by_AI (
    .ap_clk(wb_clk_i),
    .ap_rst(in_ap_rst),
    .ap_start(_in_ap_start),
    .ap_done(_ap_done),
    .ap_idle(_ap_idle),
    .ap_ready(_ap_ready),
    .image_r_Addr_A(_image_r_Addr_A),
    .image_r_EN_A(_image_r_EN_A),
    .image_r_WEN_A(_image_r_WEN_A), //We just read the memory dont write in it
    .image_r_Din_A(_image_r_Din_A),
    .image_r_Dout_A(i_in_image_r_Dout_A),
    .image_r_Clk_A(_image_r_Clk_A),
    .image_r_Rst_A(_image_r_Rst_A),
    .ap_return(_ap_return)
	 
  );

endmodule
`default_nettype wire
