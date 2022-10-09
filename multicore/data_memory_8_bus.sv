`timescale 1ns / 1ps

module data_memory_8_bus(
    input  clk,
    input  reset,
    inout  [7:0] addr_bus_0,
    output [7:0] data_bus_0,

    inout  [7:0] addr_bus_1,
    output [7:0] data_bus_1,

    inout  [7:0] addr_bus_2,
    output [7:0] data_bus_2,

    inout  [7:0] addr_bus_3,
    output [7:0] data_bus_3,

    inout  [7:0] addr_bus_4,
    output [7:0] data_bus_4,

    inout  [7:0] addr_bus_5,
    output [7:0] data_bus_5,

    inout  [7:0] addr_bus_6,
    output [7:0] data_bus_6,

    inout  [7:0] addr_bus_7,
    output [7:0] data_bus_7
    );
    
    reg [7:0] mem[255:0];
    assign data_bus_0 = mem[addr_bus_0];
    assign data_bus_1 = mem[addr_bus_1 + 32];
    assign data_bus_2 = mem[addr_bus_2 + 64];
    assign data_bus_1 = mem[addr_bus_3 + 96];
    assign data_bus_1 = mem[addr_bus_4 + 128];
    assign data_bus_2 = mem[addr_bus_5 + 160];
    assign data_bus_1 = mem[addr_bus_6 + 192];
    assign data_bus_1 = mem[addr_bus_7 + 224];

    always @(posedge(clk))
        if (reset == 0) begin
            {mem[0], mem[1], mem[2], mem[3]} <= {8'd74, 8'd107, 8'd212, 8'd254};
            {mem[4], mem[5], mem[6], mem[7]} <= {8'd37, 8'd97, 8'd253, 8'd5};
            {mem[8], mem[9], mem[10], mem[11]} <= {8'd93, 8'd53, 8'd54, 8'd248};
            {mem[12], mem[13], mem[14], mem[15]} <= {8'd169, 8'd68, 8'd0, 8'd59};
            {mem[16], mem[17], mem[18], mem[19]} <= {8'd73, 8'd43, 8'd0, 8'd203};
            {mem[20], mem[21], mem[22], mem[23]} <= {8'd81, 8'd176, 8'd109, 8'd23};
            {mem[24], mem[25], mem[26], mem[27]} <= {8'd233, 8'd68, 8'd146, 8'd46};
            {mem[28], mem[29], mem[30], mem[31]} <= {8'd231, 8'd204, 8'd112, 8'd140};
            {mem[32], mem[33], mem[34], mem[35]} <= {8'd162, 8'd248, 8'd48, 8'd254};
            {mem[36], mem[37], mem[38], mem[39]} <= {8'd162, 8'd105, 8'd69, 8'd39};
            {mem[40], mem[41], mem[42], mem[43]} <= {8'd184, 8'd66, 8'd245, 8'd168};
            {mem[44], mem[45], mem[46], mem[47]} <= {8'd58, 8'd238, 8'd120, 8'd84};
            {mem[48], mem[49], mem[50], mem[51]} <= {8'd235, 8'd179, 8'd147, 8'd155};
            {mem[52], mem[53], mem[54], mem[55]} <= {8'd189, 8'd144, 8'd21, 8'd30};
            {mem[56], mem[57], mem[58], mem[59]} <= {8'd93, 8'd94, 8'd193, 8'd239};
            {mem[60], mem[61], mem[62], mem[63]} <= {8'd238, 8'd200, 8'd196, 8'd196};
            {mem[64], mem[65], mem[66], mem[67]} <= {8'd83, 8'd194, 8'd126, 8'd154};
            {mem[68], mem[69], mem[70], mem[71]} <= {8'd103, 8'd85, 8'd118, 8'd159};
            {mem[72], mem[73], mem[74], mem[75]} <= {8'd54, 8'd139, 8'd184, 8'd81};
            {mem[76], mem[77], mem[78], mem[79]} <= {8'd58, 8'd87, 8'd249, 8'd117};
            {mem[80], mem[81], mem[82], mem[83]} <= {8'd253, 8'd27, 8'd161, 8'd240};
            {mem[84], mem[85], mem[86], mem[87]} <= {8'd143, 8'd119, 8'd54, 8'd128};
            {mem[88], mem[89], mem[90], mem[91]} <= {8'd199, 8'd171, 8'd208, 8'd205};
            {mem[92], mem[93], mem[94], mem[95]} <= {8'd8, 8'd48, 8'd116, 8'd98};
            {mem[96], mem[97], mem[98], mem[99]} <= {8'd47, 8'd54, 8'd100, 8'd82};
            {mem[100], mem[101], mem[102], mem[103]} <= {8'd222, 8'd6, 8'd92, 8'd63};
            {mem[104], mem[105], mem[106], mem[107]} <= {8'd226, 8'd251, 8'd181, 8'd102};
            {mem[108], mem[109], mem[110], mem[111]} <= {8'd177, 8'd55, 8'd58, 8'd19};
            {mem[112], mem[113], mem[114], mem[115]} <= {8'd235, 8'd215, 8'd176, 8'd194};
            {mem[116], mem[117], mem[118], mem[119]} <= {8'd200, 8'd41, 8'd178, 8'd113};
            {mem[120], mem[121], mem[122], mem[123]} <= {8'd124, 8'd50, 8'd229, 8'd149};
            {mem[124], mem[125], mem[126], mem[127]} <= {8'd175, 8'd69, 8'd201, 8'd79};
            {mem[128], mem[129], mem[130], mem[131]} <= {8'd27, 8'd250, 8'd201, 8'd36};
            {mem[132], mem[133], mem[134], mem[135]} <= {8'd13, 8'd81, 8'd203, 8'd190};
            {mem[136], mem[137], mem[138], mem[139]} <= {8'd80, 8'd52, 8'd137, 8'd163};
            {mem[140], mem[141], mem[142], mem[143]} <= {8'd216, 8'd205, 8'd125, 8'd245};
            {mem[144], mem[145], mem[146], mem[147]} <= {8'd78, 8'd26, 8'd191, 8'd213};
            {mem[148], mem[149], mem[150], mem[151]} <= {8'd3, 8'd29, 8'd146, 8'd127};
            {mem[152], mem[153], mem[154], mem[155]} <= {8'd12, 8'd131, 8'd62, 8'd219};
            {mem[156], mem[157], mem[158], mem[159]} <= {8'd240, 8'd220, 8'd60, 8'd98};
            {mem[160], mem[161], mem[162], mem[163]} <= {8'd203, 8'd89, 8'd132, 8'd17};
            {mem[164], mem[165], mem[166], mem[167]} <= {8'd177, 8'd237, 8'd153, 8'd25};
            {mem[168], mem[169], mem[170], mem[171]} <= {8'd11, 8'd98, 8'd108, 8'd225};
            {mem[172], mem[173], mem[174], mem[175]} <= {8'd222, 8'd151, 8'd104, 8'd20};
            {mem[176], mem[177], mem[178], mem[179]} <= {8'd33, 8'd58, 8'd7, 8'd201};
            {mem[180], mem[181], mem[182], mem[183]} <= {8'd48, 8'd219, 8'd33, 8'd122};
            {mem[184], mem[185], mem[186], mem[187]} <= {8'd210, 8'd98, 8'd49, 8'd143};
            {mem[188], mem[189], mem[190], mem[191]} <= {8'd204, 8'd205, 8'd150, 8'd197};
            {mem[192], mem[193], mem[194], mem[195]} <= {8'd78, 8'd167, 8'd115, 8'd26};
            {mem[196], mem[197], mem[198], mem[199]} <= {8'd84, 8'd61, 8'd183, 8'd241};
            {mem[200], mem[201], mem[202], mem[203]} <= {8'd60, 8'd156, 8'd66, 8'd62};
            {mem[204], mem[205], mem[206], mem[207]} <= {8'd186, 8'd158, 8'd188, 8'd45};
            {mem[208], mem[209], mem[210], mem[211]} <= {8'd217, 8'd175, 8'd210, 8'd155};
            {mem[212], mem[213], mem[214], mem[215]} <= {8'd69, 8'd211, 8'd67, 8'd1};
            {mem[216], mem[217], mem[218], mem[219]} <= {8'd205, 8'd68, 8'd80, 8'd224};
            {mem[220], mem[221], mem[222], mem[223]} <= {8'd44, 8'd216, 8'd232, 8'd157};
            {mem[224], mem[225], mem[226], mem[227]} <= {8'd12, 8'd178, 8'd190, 8'd51};
            {mem[228], mem[229], mem[230], mem[231]} <= {8'd98, 8'd72, 8'd92, 8'd223};
            {mem[232], mem[233], mem[234], mem[235]} <= {8'd101, 8'd10, 8'd173, 8'd2};
            {mem[236], mem[237], mem[238], mem[239]} <= {8'd190, 8'd122, 8'd205, 8'd86};
            {mem[240], mem[241], mem[242], mem[243]} <= {8'd248, 8'd9, 8'd60, 8'd49};
            {mem[244], mem[245], mem[246], mem[247]} <= {8'd75, 8'd112, 8'd1, 8'd227};
            {mem[248], mem[249], mem[250], mem[251]} <= {8'd249, 8'd71, 8'd215, 8'd188};
            {mem[252], mem[253], mem[254], mem[255]} <= {8'd198, 8'd26, 8'd31, 8'd225};
        end
endmodule
