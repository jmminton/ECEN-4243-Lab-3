module shifter (input  logic [31:0] data,
				input  logic [11:0]  src2,
				input  logic 		I,
				output logic [31:0] out)
	
	logic [3:0] rot;
	logic [7:0] imm8;
	logic [4:0] shamt5;
	logic [1:0] sh;
	
	assign rot = src2[11:8];
	assign imm8 = src2[7:0];
	assign shamt5 = src2[11:7];
	assign sh = src2[6:5];
	
	always_comb
		if (I == 0) {
			case(sh)
				2'b00: out = data<<shamt5;
				2'b01: out = data>>shamt5;
				2'b10: out = data>>>shamt5;
				2'b11: out = (data>>shamt5)|(data<<(32-shamt5));
				default: out = 32'bx;
			endcase
		}
		else {
			out = imm8>>2*rot|(imm8<<(32-2*rot));
		}
endmodule