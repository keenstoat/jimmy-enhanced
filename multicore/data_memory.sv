`timescale 1ns / 1ps

module data_memory(
    input  clk,
    input  reset,
    input  [7:0] addr_bus_0,
    output [7:0] data_bus_0,

    input  [7:0] addr_bus_1,
    output [7:0] data_bus_1,

    input  [7:0] addr_bus_2,
    output [7:0] data_bus_2,

    input  [7:0] addr_bus_3,
    output [7:0] data_bus_3,

    input  [7:0] addr_bus_4,
    output [7:0] data_bus_4,

    input  [7:0] addr_bus_5,
    output [7:0] data_bus_5,

    input  [7:0] addr_bus_6,
    output [7:0] data_bus_6,

    input  [7:0] addr_bus_7,
    output [7:0] data_bus_7
    );
    
    reg [7:0] mem[255:0];
    assign data_bus_0 = mem[addr_bus_0];
    assign data_bus_1 = mem[addr_bus_1];
    assign data_bus_2 = mem[addr_bus_2];
    assign data_bus_3 = mem[addr_bus_3];
    assign data_bus_4 = mem[addr_bus_4];
    assign data_bus_5 = mem[addr_bus_5];
    assign data_bus_6 = mem[addr_bus_6];
    assign data_bus_7 = mem[addr_bus_7];
    
    always @(posedge(clk))
        if (reset == 0) begin
            mem[0] <= 8'd250; 
            mem[1] <= 8'd202;
            mem[2] <= 8'd161;
            mem[3] <= 8'd30;
            mem[4] <= 8'd133;
            mem[5] <= 8'd221;
            mem[6] <= 8'd155;
            mem[7] <= 8'd247;
            mem[8] <= 8'd192;
            mem[9] <= 8'd140;
            mem[10] <= 8'd165;
            mem[11] <= 8'd96;
            mem[12] <= 8'd69;
            mem[13] <= 8'd170;
            mem[14] <= 8'd53;       // prime
            mem[15] <= 8'd205;
            mem[16] <= 8'd252;
            mem[17] <= 8'd192;
            mem[18] <= 8'd114;
            mem[19] <= 8'd185;
            mem[20] <= 8'd26;
            mem[21] <= 8'd60;
            mem[22] <= 8'd238;
            mem[23] <= 8'd183;
            mem[24] <= 8'd156;
            mem[25] <= 8'd62;
            mem[26] <= 8'd164;
            mem[27] <= 8'd50;
            mem[28] <= 8'd163;     // prime
            mem[29] <= 8'd68;
            mem[30] <= 8'd56;
            mem[31] <= 8'd242;
            mem[32] <= 8'd122;
            mem[33] <= 8'd114;
            mem[34] <= 8'd81;
            mem[35] <= 8'd208;
            mem[36] <= 8'd155;
            mem[37] <= 8'd38;
            mem[38] <= 8'd187;
            mem[39] <= 8'd101;      // prime
            mem[40] <= 8'd134;
            mem[41] <= 8'd193;      // prime
            mem[42] <= 8'd20;
            mem[43] <= 8'd34;
            mem[44] <= 8'd185;
            mem[45] <= 8'd243;
            mem[46] <= 8'd214;
            mem[47] <= 8'd143;
            mem[48] <= 8'd79;       // prime
            mem[49] <= 8'd152;
            mem[50] <= 8'd69;
            mem[51] <= 8'd109;      // prime
            mem[52] <= 8'd249;
            mem[53] <= 8'd161;
            mem[54] <= 8'd85;
            mem[55] <= 8'd92; 
            mem[56] <= 8'd42;
            mem[57] <= 8'd103;      // prime
            mem[58] <= 8'd17;       // prime
            mem[59] <= 8'd232;
            mem[60] <= 8'd230;
            mem[61] <= 8'd142;
            mem[62] <= 8'd179;      // prime
            mem[63] <= 8'd42;
            mem[64] <= 8'd155;
            mem[65] <= 8'd77;
            mem[66] <= 8'd5;        // prime
            mem[67] <= 8'd16;
            mem[68] <= 8'd18;
            mem[69] <= 8'd155;
            mem[70] <= 8'd59;       // prime
            mem[71] <= 8'd50;
            mem[72] <= 8'd180;
            mem[73] <= 8'd81;
            mem[74] <= 8'd142;
            mem[75] <= 8'd205;
            mem[76] <= 8'd174;
            mem[77] <= 8'd143;
            mem[78] <= 8'd110;
            mem[79] <= 8'd181;      // prime
            mem[80] <= 8'd240;
            mem[81] <= 8'd221;
            mem[82] <= 8'd187;
            mem[83] <= 8'd150;
            mem[84] <= 8'd29;       // prime
            mem[85] <= 8'd100;
            mem[86] <= 8'd235;
            mem[87] <= 8'd156;
            mem[88] <= 8'd152;
            mem[89] <= 8'd174;
            mem[90] <= 8'd77;
            mem[91] <= 8'd49;
            mem[92] <= 8'd62;
            mem[93] <= 8'd110;
            mem[94] <= 8'd61;       // prime
            mem[95] <= 8'd251;      // prime
            mem[96] <= 8'd120;
            mem[97] <= 8'd115;
            mem[98] <= 8'd22;
            mem[99] <= 8'd88;
            mem[100] <= 8'd138;
            mem[101] <= 8'd252;
            mem[102] <= 8'd216;
            mem[103] <= 8'd47;      // prime
            mem[104] <= 8'd185;
            mem[105] <= 8'd71;      // prime
            mem[106] <= 8'd11;      // prime
            mem[107] <= 8'd229;     // prime
            mem[108] <= 8'd111;
            mem[109] <= 8'd196;
            mem[110] <= 8'd223;     // prime
            mem[111] <= 8'd161;
            mem[112] <= 8'd60;
            mem[113] <= 8'd194;
            mem[114] <= 8'd238;
            mem[115] <= 8'd35;
            mem[116] <= 8'd147;
            mem[117] <= 8'd70;
            mem[118] <= 8'd52;
            mem[119] <= 8'd50;
            mem[120] <= 8'd255;
            mem[121] <= 8'd170;
            mem[122] <= 8'd241;     // prime
            mem[123] <= 8'd82;
            mem[124] <= 8'd191;     // prime
            mem[125] <= 8'd23;      // prime
            mem[126] <= 8'd164;
            mem[127] <= 8'd188;
            mem[128] <= 8'd211;     // prime
            mem[129] <= 8'd249;
            mem[130] <= 8'd37;      // prime
            mem[131] <= 8'd226;
            mem[132] <= 8'd157;     // prime
            mem[133] <= 8'd40;
            mem[134] <= 8'd209;
            mem[135] <= 8'd206; 
            mem[136] <= 8'd201;
            mem[137] <= 8'd66;
            mem[138] <= 8'd112;
            mem[139] <= 8'd107;     // prime
            mem[140] <= 8'd6;
            mem[141] <= 8'd234;
            mem[142] <= 8'd225;
            mem[143] <= 8'd176;
            mem[144] <= 8'd13;      // prime
            mem[145] <= 8'd142;
            mem[146] <= 8'd200;
            mem[147] <= 8'd233;     // prime
            mem[148] <= 8'd149;     // prime
            mem[149] <= 8'd152;
            mem[150] <= 8'd43;      // prime
            mem[151] <= 8'd164;
            mem[152] <= 8'd135;
            mem[153] <= 8'd185;
            mem[154] <= 8'd220;
            mem[155] <= 8'd167;     // prime
            mem[156] <= 8'd127;     // prime
            mem[157] <= 8'd12;
            mem[158] <= 8'd213;
            mem[159] <= 8'd139;     // prime
            mem[160] <= 8'd222;
            mem[161] <= 8'd246;
            mem[162] <= 8'd41;      // prime
            mem[163] <= 8'd152;
            mem[164] <= 8'd97;      // prime
            mem[165] <= 8'd175;
            mem[166] <= 8'd8;
            mem[167] <= 8'd33;
            mem[168] <= 8'd197;     // prime
            mem[169] <= 8'd247;
            mem[170] <= 8'd112;
            mem[171] <= 8'd80;
            mem[172] <= 8'd88;
            mem[173] <= 8'd192;
            mem[174] <= 8'd151;     // prime
            mem[175] <= 8'd216;
            mem[176] <= 8'd36;
            mem[177] <= 8'd131;     // prime
            mem[178] <= 8'd185;
            mem[179] <= 8'd244;
            mem[180] <= 8'd165;
            mem[181] <= 8'd135;
            mem[182] <= 8'd136;
            mem[183] <= 8'd65;
            mem[184] <= 8'd165;
            mem[185] <= 8'd214;
            mem[186] <= 8'd224;
            mem[187] <= 8'd239;     // prime
            mem[188] <= 8'd156;
            mem[189] <= 8'd231;
            mem[190] <= 8'd120;
            mem[191] <= 8'd7;       // prime
            mem[192] <= 8'd187;
            mem[193] <= 8'd2;       // prime
            mem[194] <= 8'd247;
            mem[195] <= 8'd199;     // prime
            mem[196] <= 8'd112;
            mem[197] <= 8'd162;
            mem[198] <= 8'd138;
            mem[199] <= 8'd89;      // prime
            mem[200] <= 8'd128;
            mem[201] <= 8'd65;
            mem[202] <= 8'd73;      // prime
            mem[203] <= 8'd67;      // prime
            mem[204] <= 8'd6;
            mem[205] <= 8'd3;       // prime
            mem[206] <= 8'd45;
            mem[207] <= 8'd215;
            mem[208] <= 8'd182;
            mem[209] <= 8'd74;
            mem[210] <= 8'd173;     // prime
            mem[211] <= 8'd111;
            mem[212] <= 8'd94;
            mem[213] <= 8'd232;
            mem[214] <= 8'd62;
            mem[215] <= 8'd76;
            mem[216] <= 8'd176;
            mem[217] <= 8'd68;
            mem[218] <= 8'd100;
            mem[219] <= 8'd51;
            mem[220] <= 8'd192;
            mem[221] <= 8'd129;
            mem[222] <= 8'd113;     // prime
            mem[223] <= 8'd235;
            mem[224] <= 8'd125;
            mem[225] <= 8'd63;
            mem[226] <= 8'd69;
            mem[227] <= 8'd25;
            mem[228] <= 8'd248;
            mem[229] <= 8'd146;
            mem[230] <= 8'd158;
            mem[231] <= 8'd255;
            mem[232] <= 8'd231;
            mem[233] <= 8'd143;
            mem[234] <= 8'd187;
            mem[235] <= 8'd49;
            mem[236] <= 8'd83;      // prime
            mem[237] <= 8'd130;
            mem[238] <= 8'd130;
            mem[239] <= 8'd242;
            mem[240] <= 8'd137;     // prime
            mem[241] <= 8'd102;
            mem[242] <= 8'd159;
            mem[243] <= 8'd129;
            mem[244] <= 8'd235;
            mem[245] <= 8'd22;
            mem[246] <= 8'd227;     // prime
            mem[247] <= 8'd250;
            mem[248] <= 8'd156;
            mem[249] <= 8'd202;
            mem[250] <= 8'd120;
            mem[251] <= 8'd31;      // prime
            mem[252] <= 8'd55;
            mem[253] <= 8'd19;      // prime
            mem[254] <= 8'd120;
            mem[255] <= 8'd192;
        end
endmodule
