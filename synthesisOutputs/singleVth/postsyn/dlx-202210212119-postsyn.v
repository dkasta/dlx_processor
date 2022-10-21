
module SNPS_CLOCK_GATE_HIGH_dlx_1 ( CLK, EN, ENCLK, TE );
  input CLK, EN, TE;
  output ENCLK;


  CLKGATETST_X1 latch ( .CK(CLK), .E(EN), .SE(TE), .GCK(ENCLK) );
endmodule


module SNPS_CLOCK_GATE_HIGH_dlx_2 ( CLK, EN, ENCLK, TE );
  input CLK, EN, TE;
  output ENCLK;


  CLKGATETST_X1 latch ( .CK(CLK), .E(EN), .SE(TE), .GCK(ENCLK) );
endmodule


module dlx ( Clk, Rst, IR, PC );
  input [31:0] IR;
  output [31:0] PC;
  input Clk, Rst;
  wire   \DTP/NPC[5] , \DTP/NPC[9] , \DTP/NPC[10] , \DTP/NPC[12] ,
         \DTP/NPC[13] , \DTP/NPC[14] , \DTP/NPC[15] , \DTP/NPC[17] ,
         \DTP/NPC[19] , \DTP/NPC[21] , \DTP/NPC[23] , \DTP/NPC[25] ,
         \DTP/NPC[27] , \DTP/NPC[28] , \DTP/NPC[29] , \DTP/NPC[31] ,
         \DTP/RDreg1/N6 , \DTP/RDreg1/N5 , \DTP/RDreg1/N4 , \DTP/RDreg1/N3 ,
         \DTP/RDreg1/N2 , \DTP/RDreg2/N6 , \DTP/RDreg2/N5 , \DTP/RDreg2/N4 ,
         \DTP/RDreg2/N3 , \DTP/RDreg2/N2 , \DTP/PC/N34 , \DTP/PC/N33 ,
         \DTP/PC/N32 , \DTP/PC/N30 , \DTP/PC/N29 , \DTP/PC/N27 , \DTP/PC/N26 ,
         \DTP/PC/N25 , \DTP/PC/N24 , \DTP/PC/N23 , \DTP/PC/N22 , \DTP/PC/N21 ,
         \DTP/PC/N20 , \DTP/PC/N19 , \DTP/PC/N18 , \DTP/PC/N17 , \DTP/PC/N16 ,
         \DTP/PC/N15 , \DTP/PC/N14 , \DTP/PC/N13 , \DTP/PC/N12 , \DTP/PC/N11 ,
         \DTP/PC/N10 , \DTP/PC/N9 , \DTP/PC/N8 , \DTP/PC/N7 , \DTP/PC/N6 ,
         \DTP/PC/N5 , \DTP/PC/N4 , \DTP/PC/N3 , \DTP/PC/N2 , \DTP/IR/N33 ,
         \DTP/IR/N31 , \DTP/IR/N30 , \DTP/IR/N29 , \DTP/IR/N27 , \DTP/IR/N26 ,
         \DTP/IR/N25 , \DTP/IR/N24 , \DTP/IR/N23 , \DTP/IR/N22 , \DTP/IR/N21 ,
         \DTP/IR/N20 , \DTP/IR/N19 , \DTP/IR/N18 , \DTP/IR/N13 ,
         \DTP/ALU_REG/N33 , \DTP/ALU_REG/N32 , \DTP/ALU_REG/N31 ,
         \DTP/ALU_REG/N30 , \DTP/ALU_REG/N29 , \DTP/ALU_REG/N28 ,
         \DTP/ALU_REG/N27 , \DTP/ALU_REG/N26 , \DTP/ALU_REG/N25 ,
         \DTP/ALU_REG/N24 , \DTP/ALU_REG/N23 , \DTP/ALU_REG/N22 ,
         \DTP/ALU_REG/N21 , \DTP/ALU_REG/N20 , \DTP/ALU_REG/N19 ,
         \DTP/ALU_REG/N18 , \DTP/ALU_REG/N17 , \DTP/ALU_REG/N16 ,
         \DTP/ALU_REG/N15 , \DTP/ALU_REG/N14 , \DTP/ALU_REG/N13 ,
         \DTP/ALU_REG/N12 , \DTP/ALU_REG/N11 , \DTP/ALU_REG/N10 ,
         \DTP/ALU_REG/N9 , \DTP/ALU_REG/N8 , \DTP/ALU_REG/N7 ,
         \DTP/ALU_REG/N6 , \DTP/ALU_REG/N5 , \DTP/ALU_REG/N4 ,
         \DTP/ALU_REG/N3 , \DTP/ALU_REG/N2 , \DTP/NPCreg1/N13 ,
         \DTP/NPCreg1/N9 , \DTP/NPCreg1/N4 , \DTP/NPCreg1/N3 ,
         \DTP/NPCreg1/N2 , \DTP/NPCreg2/N33 , \DTP/NPCreg2/N32 ,
         \DTP/NPCreg2/N31 , \DTP/NPCreg2/N30 , \DTP/NPCreg2/N29 ,
         \DTP/NPCreg2/N28 , \DTP/NPCreg2/N27 , \DTP/NPCreg2/N26 ,
         \DTP/NPCreg2/N25 , \DTP/NPCreg2/N24 , \DTP/NPCreg2/N23 ,
         \DTP/NPCreg2/N22 , \DTP/NPCreg2/N21 , \DTP/NPCreg2/N20 ,
         \DTP/NPCreg2/N19 , \DTP/NPCreg2/N18 , \DTP/NPCreg2/N17 ,
         \DTP/NPCreg2/N16 , \DTP/NPCreg2/N15 , \DTP/NPCreg2/N14 ,
         \DTP/NPCreg2/N13 , \DTP/NPCreg2/N12 , \DTP/NPCreg2/N11 ,
         \DTP/NPCreg2/N10 , \DTP/NPCreg2/N9 , \DTP/NPCreg2/N8 ,
         \DTP/NPCreg2/N7 , \DTP/NPCreg2/N6 , \DTP/NPCreg2/N5 ,
         \DTP/NPCreg2/N4 , \DTP/NPCreg2/N3 , \DTP/NPCreg2/N2 , \DTP/cnt/N94 ,
         \DTP/cnt/N32 , \DTP/cnt/N31 , \DTP/cnt/N30 , \DTP/cnt/N29 ,
         \DTP/cnt/N28 , \DTP/cnt/N27 , \DTP/cnt/N26 , \DTP/cnt/N25 ,
         \DTP/cnt/N24 , \DTP/cnt/N23 , \DTP/cnt/N22 , \DTP/cnt/N21 ,
         \DTP/cnt/N20 , \DTP/cnt/N19 , \DTP/cnt/N18 , \DTP/cnt/N17 ,
         \DTP/cnt/N16 , \DTP/cnt/N15 , \DTP/cnt/N14 , \DTP/cnt/N13 ,
         \DTP/cnt/N12 , \DTP/cnt/N11 , \DTP/cnt/N10 , \DTP/cnt/N9 ,
         \DTP/cnt/N8 , \DTP/cnt/N7 , \DTP/cnt/N6 , \DTP/cnt/N5 , \DTP/cnt/N1 ,
         \DTP/forward_branchREG1/N2 , \DTP/forward_branchREG2/N2 ,
         \DTP/JALreg1/N2 , \DTP/JALreg2/N2 , \DTP/JRreg1/N2 ,
         \DTP/BRANCH_opREG1/N2 , \DTP/LOADREG1/N2 , \DTP/FWDBRANCH1/N2 ,
         \DTP/FWDBRANCH2/N2 , net7833, net7838, n932, n934, n935, n936, n939,
         n7406, \intadd_0/B[0] , \intadd_0/CI , \intadd_0/SUM[4] ,
         \intadd_0/SUM[3] , \intadd_0/SUM[2] , \intadd_0/SUM[1] ,
         \intadd_0/SUM[0] , \intadd_0/n5 , \intadd_0/n4 , \intadd_0/n3 ,
         \intadd_0/n2 , \intadd_0/n1 , n9284, n9297, n9298, n9300, n9308,
         n9309, n9310, n9311, n9313, n9315, n9319, n9320, n9321, n9322, n9323,
         n9324, n9325, n9326, n9327, n9328, n9330, n9331, n9333, n9334, n9335,
         n9336, n9345, n9346, n9348, n9349, n9377, n9724, n9736, n9737, n9764,
         n9780, n9784, n9790, n9791, n9792, n9793, n9794, n10054, n10055,
         n10056, n10057, n10058, n10059, n10062, n10063, n10064, n10065,
         n10066, n10067, n10068, n10069, n10070, n10071, n10072, n10073,
         n10074, n10076, n10077, n10078, n10079, n10080, n10081, n10082,
         n10083, n10084, n10085, n10086, n10087, n10088, n10089, n10090,
         n10091, n10092, n10093, n10094, n10095, n10096, n10097, n10098,
         n10099, n10100, n10101, n10102, n10103, n10104, n10105, n10106,
         n10107, n10108, n10109, n10110, n10111, n10112, n10113, n10114,
         n10115, n10116, n10117, n10118, n10119, n10120, n10121, n10122,
         n10123, n10124, n10125, n10126, n10127, n10128, n10129, n10130,
         n10131, n10132, n10133, n10134, n10135, n10136, n10137, n10138,
         n10139, n10140, n10141, n10142, n10143, n10144, n10145, n10146,
         n10147, n10148, n10149, n10150, n10151, n10152, n10153, n10154,
         n10155, n10156, n10157, n10158, n10159, n10160, n10161, n10162,
         n10163, n10164, n10165, n10166, n10168, n10169, n10170, n10171,
         n10172, n10173, n10174, n10175, n10176, n10177, n10178, n10179,
         n10180, n10181, n10182, n10183, n10184, n10185, n10186, n10187,
         n10188, n10189, n10190, n10191, n10192, n10193, n10194, n10195,
         n10196, n10197, n10198, n10199, n10200, n10201, n10202, n10203,
         n10204, n10205, n10206, n10207, n10208, n10210, n10211, n10212,
         n10213, n10214, n10215, n10216, n10217, n10218, n10219, n10220,
         n10221, n10222, n10224, n10225, n10226, n10227, n10228, n10229,
         n10230, n10231, n10232, n10233, \intadd_2/B[1] , \intadd_2/CI ,
         \intadd_2/SUM[2] , \intadd_2/SUM[1] , \intadd_2/SUM[0] ,
         \intadd_2/n3 , \intadd_2/n2 , \intadd_2/n1 , n10234, n10235, n10236,
         n10237, n10238, n10239, n10240, n10241, n10242, n10243, n10244,
         n10245, n10246, n10247, n10248, n10249, n10250, n10251, n10252,
         n10253, n10254, n10255, n10256, n10257, n10258, n10259, n10260,
         n10261, n10262, n10263, n10264, n10265, n10266, n10267, n10268,
         n10269, n10270, n10271, n10272, n10273, n10274, n10275, n10276,
         n10277, n10278, n10280, n10281, n10283, n10285, n10286, n10287,
         n10289, n10290, n10291, n10292, n10293, n10294, n10295, n10296,
         n10297, n10298, n10299, n10300, n10301, n10302, n10303, n10304,
         n10305, n10306, n10307, n10308, n10309, n10310, n10311, n10312,
         n10313, n10314, n10315, n10316, n10317, n10318, n10319, n10320,
         n10321, n10322, n10323, n10324, n10325, n10326, n10327, n10328,
         n10329, n10330, n10331, n10332, n10333, n10334, n10335, n10336,
         n10337, n10338, n10339, n10340, n10341, n10342, n10343, n10344,
         n10345, n10346, n10347, n10348, n10349, n10350, n10351, n10352,
         n10353, n10354, n10355, n10356, n10357, n10358, n10359, n10360,
         n10361, n10362, n10363, n10364, n10365, n10366, n10367, n10368,
         n10369, n10370, n10371, n10372, n10373, n10374, n10375, n10376,
         n10377, n10378, n10379, n10380, n10381, n10382, n10383, n10384,
         n10385, n10386, n10387, n10388, n10389, n10390, n10391, n10392,
         n10393, n10394, n10395, n10396, n10397, n10398, n10399, n10400,
         n10401, n10402, n10403, n10404, n10405, n10406, n10407, n10408,
         n10409, n10410, n10411, n10412, n10413, n10414, n10415, n10416,
         n10417, n10418, n10419, n10420, n10421, n10422, n10423, n10424,
         n10425, n10426, n10427, n10428, n10429, n10430, n10431, n10432,
         n10433, n10434, n10435, n10436, n10437, n10438, n10439, n10440,
         n10441, n10442, n10443, n10444, n10445, n10446, n10447, n10448,
         n10449, n10450, n10451, n10452, n10453, n10454, n10455, n10456,
         n10457, n10458, n10459, n10460, n10461, n10462, n10463, n10464,
         n10465, n10466, n10467, n10468, n10469, n10470, n10471, n10472,
         n10473, n10474, n10475, n10476, n10477, n10478, n10479, n10480,
         n10481, n10482, n10483, n10484, n10485, n10486, n10487, n10488,
         n10489, n10490, n10491, n10492, n10493, n10494, n10495, n10496,
         n10497, n10498, n10499, n10500, n10501, n10502, n10503, n10504,
         n10505, n10506, n10507, n10508, n10509, n10510, n10511, n10512,
         n10513, n10514, n10515, n10516, n10517, n10518, n10519, n10520,
         n10521, n10522, n10523, n10524, n10525, n10526, n10527, n10528,
         n10529, n10530, n10531, n10532, n10533, n10534, n10535, n10536,
         n10537, n10538, n10539, n10540, n10541, n10542, n10543, n10544,
         n10545, n10546, n10547, n10548, n10549, n10550, n10551, n10552,
         n10553, n10554, n10555, n10556, n10557, n10558, n10559, n10560,
         n10561, n10562, n10563, n10564, n10565, n10566, n10567, n10568,
         n10569, n10570, n10571, n10572, n10573, n10574, n10575, n10576,
         n10577, n10578, n10579, n10580, n10581, n10582, n10583, n10584,
         n10585, n10586, n10587, n10588, n10589, n10590, n10591, n10592,
         n10593, n10594, n10595, n10596, n10597, n10598, n10599, n10600,
         n10601, n10602, n10603, n10604, n10605, n10606, n10607, n10608,
         n10609;
  assign PC[31] = \DTP/PC/N34 ;
  assign PC[30] = \DTP/PC/N34 ;
  assign PC[29] = \DTP/PC/N34 ;
  assign PC[28] = \DTP/PC/N33 ;

  SNPS_CLOCK_GATE_HIGH_dlx_2 \clk_gate_DTP/PC/d_out_reg  ( .CLK(Clk), .EN(
        \DTP/PC/N2 ), .ENCLK(net7833), .TE(1'b0) );
  SNPS_CLOCK_GATE_HIGH_dlx_1 \clk_gate_DTP/cnt/i_reg  ( .CLK(Clk), .EN(
        \DTP/cnt/N1 ), .ENCLK(net7838), .TE(1'b0) );
  DFF_X1 \DTP/IR/d_out_reg[11]  ( .D(\DTP/IR/N13 ), .CK(Clk), .QN(n10184) );
  SDFF_X1 \DTP/IR/d_out_reg[12]  ( .D(1'b0), .SI(Rst), .SE(IR[12]), .CK(Clk), 
        .QN(n10185) );
  SDFF_X1 \DTP/IR/d_out_reg[13]  ( .D(1'b0), .SI(Rst), .SE(IR[13]), .CK(Clk), 
        .QN(n10187) );
  SDFF_X1 \DTP/IR/d_out_reg[14]  ( .D(1'b0), .SI(Rst), .SE(IR[14]), .CK(Clk), 
        .QN(n10189) );
  SDFF_X1 \DTP/IR/d_out_reg[15]  ( .D(1'b0), .SI(Rst), .SE(IR[15]), .CK(Clk), 
        .QN(n10191) );
  DFF_X1 \DTP/IR/d_out_reg[16]  ( .D(\DTP/IR/N18 ), .CK(Clk), .Q(n9300) );
  DFF_X1 \DTP/IR/d_out_reg[17]  ( .D(\DTP/IR/N19 ), .CK(Clk), .Q(n10186) );
  DFF_X1 \DTP/IR/d_out_reg[18]  ( .D(\DTP/IR/N20 ), .CK(Clk), .Q(n10283), .QN(
        n10188) );
  DFF_X1 \DTP/IR/d_out_reg[19]  ( .D(\DTP/IR/N21 ), .CK(Clk), .Q(n10190), .QN(
        n10287) );
  DFF_X1 \DTP/IR/d_out_reg[20]  ( .D(\DTP/IR/N22 ), .CK(Clk), .Q(n10192) );
  DFF_X1 \DTP/IR/d_out_reg[21]  ( .D(\DTP/IR/N23 ), .CK(Clk), .QN(n10097) );
  DFF_X1 \DTP/IR/d_out_reg[22]  ( .D(\DTP/IR/N24 ), .CK(Clk), .QN(n10101) );
  DFF_X1 \DTP/IR/d_out_reg[25]  ( .D(\DTP/IR/N27 ), .CK(Clk), .Q(n10102) );
  SDFF_X1 \DTP/IR/d_out_reg[26]  ( .D(1'b1), .SI(n9784), .SE(Rst), .CK(Clk), 
        .Q(n10302), .QN(n10183) );
  DFF_X1 \DTP/IR/d_out_reg[27]  ( .D(\DTP/IR/N29 ), .CK(Clk), .Q(n9310), .QN(
        n10280) );
  DFF_X1 \DTP/IR/d_out_reg[28]  ( .D(\DTP/IR/N30 ), .CK(Clk), .QN(n10180) );
  DFF_X1 \DTP/IR/d_out_reg[29]  ( .D(\DTP/IR/N31 ), .CK(Clk), .Q(n10296), .QN(
        n10181) );
  DFF_X1 \DTP/IR/d_out_reg[30]  ( .D(n9780), .CK(Clk), .Q(n10182) );
  DFF_X1 \DTP/IR/d_out_reg[31]  ( .D(\DTP/IR/N33 ), .CK(Clk), .QN(n10179) );
  DFF_X1 \DTP/RDreg1/d_out_reg[0]  ( .D(\DTP/RDreg1/N2 ), .CK(Clk), .Q(n9346), 
        .QN(n10281) );
  DFF_X1 \DTP/RDreg2/d_out_reg[0]  ( .D(\DTP/RDreg2/N2 ), .CK(Clk), .Q(n10096)
         );
  DFF_X1 \DTP/RDreg1/d_out_reg[3]  ( .D(\DTP/RDreg1/N5 ), .CK(Clk), .Q(n9308)
         );
  DFF_X1 \DTP/RDreg2/d_out_reg[3]  ( .D(\DTP/RDreg2/N5 ), .CK(Clk), .Q(n10095)
         );
  DFF_X1 \DTP/RDreg1/d_out_reg[4]  ( .D(\DTP/RDreg1/N6 ), .CK(Clk), .QN(n10193) );
  DFF_X1 \DTP/RDreg2/d_out_reg[4]  ( .D(\DTP/RDreg2/N6 ), .CK(Clk), .QN(n10103) );
  DFF_X1 \DTP/RDreg1/d_out_reg[1]  ( .D(\DTP/RDreg1/N3 ), .CK(Clk), .Q(n9309), 
        .QN(n10285) );
  DFF_X1 \DTP/RDreg2/d_out_reg[1]  ( .D(\DTP/RDreg2/N3 ), .CK(Clk), .Q(n10100)
         );
  DFF_X1 \DTP/RDreg1/d_out_reg[2]  ( .D(\DTP/RDreg1/N4 ), .CK(Clk), .Q(n10295), 
        .QN(n9298) );
  DFF_X1 \DTP/RDreg2/d_out_reg[2]  ( .D(\DTP/RDreg2/N4 ), .CK(Clk), .QN(n10098) );
  DFF_X1 \DTP/NPCreg1/d_out_reg[0]  ( .D(\DTP/NPCreg1/N2 ), .CK(Clk), .QN(
        n10116) );
  DFF_X1 \DTP/NPCreg1/d_out_reg[7]  ( .D(\DTP/NPCreg1/N9 ), .CK(Clk), .QN(
        n10137) );
  DFF_X1 \DTP/NPCreg1/d_out_reg[11]  ( .D(\DTP/NPCreg1/N13 ), .CK(Clk), .QN(
        n10109) );
  DFF_X1 \DTP/NPCreg2/d_out_reg[0]  ( .D(\DTP/NPCreg2/N2 ), .CK(Clk), .QN(
        n10173) );
  DFF_X1 \DTP/NPCreg2/d_out_reg[3]  ( .D(\DTP/NPCreg2/N5 ), .CK(Clk), .QN(
        n10055) );
  DFF_X1 \DTP/NPCreg2/d_out_reg[4]  ( .D(\DTP/NPCreg2/N6 ), .CK(Clk), .QN(
        n10056) );
  DFF_X1 \DTP/NPCreg2/d_out_reg[5]  ( .D(\DTP/NPCreg2/N7 ), .CK(Clk), .QN(
        n10057) );
  DFF_X1 \DTP/NPCreg2/d_out_reg[6]  ( .D(\DTP/NPCreg2/N8 ), .CK(Clk), .QN(
        n10058) );
  DFF_X1 \DTP/NPCreg2/d_out_reg[7]  ( .D(\DTP/NPCreg2/N9 ), .CK(Clk), .QN(
        n10157) );
  DFF_X1 \DTP/NPCreg2/d_out_reg[8]  ( .D(\DTP/NPCreg2/N10 ), .CK(Clk), .QN(
        n10086) );
  DFF_X1 \DTP/NPCreg2/d_out_reg[9]  ( .D(\DTP/NPCreg2/N11 ), .CK(Clk), .QN(
        n10158) );
  DFF_X1 \DTP/NPCreg2/d_out_reg[10]  ( .D(\DTP/NPCreg2/N12 ), .CK(Clk), .QN(
        n10218) );
  DFF_X1 \DTP/NPCreg2/d_out_reg[11]  ( .D(\DTP/NPCreg2/N13 ), .CK(Clk), .QN(
        n10160) );
  DFF_X1 \DTP/NPCreg2/d_out_reg[12]  ( .D(\DTP/NPCreg2/N14 ), .CK(Clk), .QN(
        n10161) );
  DFF_X1 \DTP/NPCreg2/d_out_reg[13]  ( .D(\DTP/NPCreg2/N15 ), .CK(Clk), .QN(
        n10087) );
  DFF_X1 \DTP/NPCreg2/d_out_reg[14]  ( .D(\DTP/NPCreg2/N16 ), .CK(Clk), .QN(
        n10162) );
  DFF_X1 \DTP/NPCreg2/d_out_reg[15]  ( .D(\DTP/NPCreg2/N17 ), .CK(Clk), .QN(
        n10164) );
  DFF_X1 \DTP/NPCreg2/d_out_reg[16]  ( .D(\DTP/NPCreg2/N18 ), .CK(Clk), .QN(
        n10165) );
  DFF_X1 \DTP/NPCreg2/d_out_reg[17]  ( .D(\DTP/NPCreg2/N19 ), .CK(Clk), .Q(
        n10298), .QN(n10168) );
  DFF_X1 \DTP/NPCreg2/d_out_reg[18]  ( .D(\DTP/NPCreg2/N20 ), .CK(Clk), .QN(
        n10088) );
  DFF_X1 \DTP/NPCreg2/d_out_reg[19]  ( .D(\DTP/NPCreg2/N21 ), .CK(Clk), .QN(
        n10169) );
  DFF_X1 \DTP/NPCreg2/d_out_reg[20]  ( .D(\DTP/NPCreg2/N22 ), .CK(Clk), .Q(
        n10299), .QN(n10170) );
  DFF_X1 \DTP/NPCreg2/d_out_reg[21]  ( .D(\DTP/NPCreg2/N23 ), .CK(Clk), .QN(
        n10217) );
  DFF_X1 \DTP/NPCreg2/d_out_reg[22]  ( .D(\DTP/NPCreg2/N24 ), .CK(Clk), .QN(
        n10216) );
  DFF_X1 \DTP/NPCreg2/d_out_reg[23]  ( .D(\DTP/NPCreg2/N25 ), .CK(Clk), .QN(
        n10214) );
  DFF_X1 \DTP/NPCreg2/d_out_reg[24]  ( .D(\DTP/NPCreg2/N26 ), .CK(Clk), .Q(
        n10300), .QN(n10171) );
  DFF_X1 \DTP/NPCreg2/d_out_reg[25]  ( .D(\DTP/NPCreg2/N27 ), .CK(Clk), .QN(
        n10059) );
  DFF_X1 \DTP/NPCreg2/d_out_reg[26]  ( .D(\DTP/NPCreg2/N28 ), .CK(Clk), .QN(
        n10089) );
  DFF_X1 \DTP/NPCreg2/d_out_reg[27]  ( .D(\DTP/NPCreg2/N29 ), .CK(Clk), .Q(
        n10301), .QN(n10090) );
  DFF_X1 \DTP/NPCreg2/d_out_reg[28]  ( .D(\DTP/NPCreg2/N30 ), .CK(Clk), .QN(
        n10176) );
  DFF_X1 \DTP/NPCreg2/d_out_reg[29]  ( .D(\DTP/NPCreg2/N31 ), .CK(Clk), .QN(
        n10177) );
  DFF_X1 \DTP/NPCreg2/d_out_reg[30]  ( .D(\DTP/NPCreg2/N32 ), .CK(Clk), .Q(
        n10303), .QN(n10212) );
  DFF_X1 \DTP/NPCreg2/d_out_reg[31]  ( .D(\DTP/NPCreg2/N33 ), .CK(Clk), .QN(
        n10091) );
  DFFR_X1 \DTP/cnt/i_reg[0]  ( .D(n9345), .CK(net7838), .RN(Rst), .QN(n9345)
         );
  DFFS_X1 \DTP/cnt/i_reg[1]  ( .D(n10222), .CK(net7838), .SN(Rst), .QN(n10194)
         );
  DFFR_X1 \DTP/cnt/i_reg[2]  ( .D(n9724), .CK(net7838), .RN(Rst), .QN(n9334)
         );
  DFFR_X1 \DTP/cnt/i_reg[3]  ( .D(\DTP/cnt/N5 ), .CK(net7838), .RN(Rst), .QN(
        n10195) );
  DFFR_X1 \DTP/cnt/i_reg[4]  ( .D(\DTP/cnt/N6 ), .CK(net7838), .RN(Rst), .Q(
        n10083) );
  DFFR_X1 \DTP/cnt/i_reg[5]  ( .D(\DTP/cnt/N7 ), .CK(net7838), .RN(Rst), .QN(
        n10196) );
  DFFR_X1 \DTP/cnt/i_reg[6]  ( .D(\DTP/cnt/N8 ), .CK(net7838), .RN(Rst), .Q(
        n10084) );
  DFFR_X1 \DTP/cnt/i_reg[7]  ( .D(\DTP/cnt/N9 ), .CK(net7838), .RN(Rst), .QN(
        n10197) );
  DFFR_X1 \DTP/cnt/i_reg[8]  ( .D(\DTP/cnt/N10 ), .CK(net7838), .RN(Rst), .Q(
        n10085) );
  DFFR_X1 \DTP/cnt/i_reg[9]  ( .D(\DTP/cnt/N11 ), .CK(net7838), .RN(Rst), .QN(
        n10198) );
  DFFR_X1 \DTP/cnt/i_reg[10]  ( .D(\DTP/cnt/N12 ), .CK(net7838), .RN(Rst), .Q(
        n10076) );
  DFFR_X1 \DTP/cnt/i_reg[11]  ( .D(\DTP/cnt/N13 ), .CK(net7838), .RN(Rst), 
        .QN(n10199) );
  DFFR_X1 \DTP/cnt/i_reg[12]  ( .D(\DTP/cnt/N14 ), .CK(net7838), .RN(Rst), 
        .QN(n9335) );
  DFFR_X1 \DTP/cnt/i_reg[13]  ( .D(\DTP/cnt/N15 ), .CK(net7838), .RN(Rst), 
        .QN(n10200) );
  DFFR_X1 \DTP/cnt/i_reg[14]  ( .D(\DTP/cnt/N16 ), .CK(net7838), .RN(Rst), .Q(
        n10077) );
  DFFR_X1 \DTP/cnt/i_reg[15]  ( .D(\DTP/cnt/N17 ), .CK(net7838), .RN(Rst), 
        .QN(n10201) );
  DFFR_X1 \DTP/cnt/i_reg[16]  ( .D(\DTP/cnt/N18 ), .CK(net7838), .RN(Rst), .Q(
        n10078) );
  DFFR_X1 \DTP/cnt/i_reg[17]  ( .D(\DTP/cnt/N19 ), .CK(net7838), .RN(Rst), 
        .QN(n10202) );
  DFFR_X1 \DTP/cnt/i_reg[18]  ( .D(\DTP/cnt/N20 ), .CK(net7838), .RN(Rst), .Q(
        n10205) );
  DFFR_X1 \DTP/cnt/i_reg[19]  ( .D(\DTP/cnt/N21 ), .CK(net7838), .RN(Rst), 
        .QN(n10079) );
  DFFR_X1 \DTP/cnt/i_reg[20]  ( .D(\DTP/cnt/N22 ), .CK(net7838), .RN(Rst), .Q(
        n10206) );
  DFFR_X1 \DTP/cnt/i_reg[21]  ( .D(\DTP/cnt/N23 ), .CK(net7838), .RN(Rst), 
        .QN(n10080) );
  DFFR_X1 \DTP/cnt/i_reg[22]  ( .D(\DTP/cnt/N24 ), .CK(net7838), .RN(Rst), 
        .QN(n9336) );
  DFFR_X1 \DTP/cnt/i_reg[23]  ( .D(\DTP/cnt/N25 ), .CK(net7838), .RN(Rst), 
        .QN(n10203) );
  DFFR_X1 \DTP/cnt/i_reg[24]  ( .D(\DTP/cnt/N26 ), .CK(net7838), .RN(Rst), .Q(
        n10081) );
  DFFR_X1 \DTP/cnt/i_reg[25]  ( .D(\DTP/cnt/N27 ), .CK(net7838), .RN(Rst), 
        .QN(n10204) );
  DFFR_X1 \DTP/cnt/i_reg[26]  ( .D(\DTP/cnt/N28 ), .CK(net7838), .RN(Rst), 
        .QN(n9333) );
  DFFR_X1 \DTP/cnt/i_reg[27]  ( .D(\DTP/cnt/N29 ), .CK(net7838), .RN(Rst), 
        .QN(n10207) );
  DFFR_X1 \DTP/cnt/i_reg[28]  ( .D(\DTP/cnt/N30 ), .CK(net7838), .RN(Rst), .Q(
        n10082) );
  DFFR_X1 \DTP/cnt/i_reg[29]  ( .D(\DTP/cnt/N31 ), .CK(net7838), .RN(Rst), .Q(
        n10297), .QN(n10208) );
  DFFR_X1 \DTP/cnt/i_reg[30]  ( .D(\DTP/cnt/N32 ), .CK(net7838), .RN(Rst), 
        .QN(n10292) );
  DFFS_X1 \DTP/cnt/tc_reg  ( .D(\DTP/cnt/N94 ), .CK(Clk), .SN(Rst), .QN(n10166) );
  DFF_X1 \DTP/forward_branchREG1/d_out_reg  ( .D(\DTP/forward_branchREG1/N2 ), 
        .CK(Clk), .QN(n10210) );
  DFF_X1 \DTP/forward_branchREG2/d_out_reg  ( .D(\DTP/forward_branchREG2/N2 ), 
        .CK(Clk), .QN(n10156) );
  DFF_X1 \DTP/pcen1/d_out_reg  ( .D(Rst), .CK(Clk), .QN(n10294) );
  DFF_X1 \DTP/JALreg1/d_out_reg  ( .D(\DTP/JALreg1/N2 ), .CK(Clk), .QN(n10104)
         );
  DFF_X1 \DTP/JALreg2/d_out_reg  ( .D(\DTP/JALreg2/N2 ), .CK(Clk), .QN(n9297)
         );
  DFF_X1 \DTP/JRreg1/d_out_reg  ( .D(\DTP/JRreg1/N2 ), .CK(Clk), .Q(n10293), 
        .QN(n9311) );
  DFF_X1 \DTP/BRANCH_opREG1/d_out_reg  ( .D(\DTP/BRANCH_opREG1/N2 ), .CK(Clk), 
        .QN(n10093) );
  DFF_X1 \DTP/BRANCH_opREG2/d_out_reg  ( .D(n7406), .CK(Clk), .Q(n10155) );
  DFF_X1 \DTP/LOADREG1/d_out_reg  ( .D(\DTP/LOADREG1/N2 ), .CK(Clk), .Q(n10138) );
  DFF_X1 \DTP/FWDBRANCH1/d_out_reg  ( .D(\DTP/FWDBRANCH1/N2 ), .CK(Clk), .QN(
        n9377) );
  DFF_X1 \DTP/FWDBRANCH2/d_out_reg  ( .D(\DTP/FWDBRANCH2/N2 ), .CK(Clk), .QN(
        n10219) );
  DFF_X1 \DTP/ALU_REG/d_out_reg[31]  ( .D(\DTP/ALU_REG/N33 ), .CK(Clk), .QN(
        n10149) );
  DFF_X1 \DTP/ALU_REG/d_out_reg[0]  ( .D(\DTP/ALU_REG/N2 ), .CK(Clk), .Q(
        n10175) );
  DFF_X1 \DTP/ALU_REG/d_out_reg[15]  ( .D(\DTP/ALU_REG/N17 ), .CK(Clk), .Q(
        n10154) );
  DFF_X1 \DTP/ALU_REG/d_out_reg[1]  ( .D(\DTP/ALU_REG/N3 ), .CK(Clk), .Q(
        n10139) );
  DFF_X1 \DTP/PC/d_out_reg[1]  ( .D(\DTP/PC/N4 ), .CK(net7833), .Q(n10105), 
        .QN(\intadd_0/B[0] ) );
  DFF_X1 \DTP/NPCreg1/d_out_reg[1]  ( .D(\DTP/NPCreg1/N3 ), .CK(Clk), .QN(
        n10127) );
  DFF_X1 \DTP/NPCreg2/d_out_reg[1]  ( .D(\DTP/NPCreg2/N3 ), .CK(Clk), .QN(
        n10054) );
  DFF_X1 R_241 ( .D(\DTP/PC/N5 ), .CK(net7833), .Q(PC[0]), .QN(n10178) );
  DFF_X1 \DTP/NPCreg1/d_out_reg[2]  ( .D(\DTP/NPCreg1/N4 ), .CK(Clk), .QN(
        n10132) );
  DFF_X1 \DTP/NPCreg2/d_out_reg[2]  ( .D(\DTP/NPCreg2/N4 ), .CK(Clk), .QN(
        n10092) );
  DFF_X1 \DTP/ALU_REG/d_out_reg[2]  ( .D(\DTP/ALU_REG/N4 ), .CK(Clk), .Q(
        n10141) );
  DFF_X1 \DTP/ALU_REG/d_out_reg[3]  ( .D(\DTP/ALU_REG/N5 ), .CK(Clk), .Q(
        n10140) );
  DFF_X1 \DTP/ALU_REG/d_out_reg[4]  ( .D(\DTP/ALU_REG/N6 ), .CK(Clk), .Q(
        n10143) );
  DFF_X1 \DTP/ALU_REG/d_out_reg[5]  ( .D(\DTP/ALU_REG/N7 ), .CK(Clk), .Q(
        n10142) );
  DFF_X1 \DTP/ALU_REG/d_out_reg[6]  ( .D(\DTP/ALU_REG/N8 ), .CK(Clk), .Q(
        n10145) );
  DFF_X1 \DTP/ALU_REG/d_out_reg[7]  ( .D(\DTP/ALU_REG/N9 ), .CK(Clk), .Q(
        n10144) );
  DFF_X1 R_239 ( .D(\DTP/PC/N6 ), .CK(net7833), .Q(PC[1]), .QN(n10073) );
  DFF_X1 R_240 ( .D(\DTP/PC/N7 ), .CK(net7833), .Q(PC[2]) );
  DFF_X1 R_243 ( .D(\DTP/PC/N8 ), .CK(net7833), .Q(PC[3]), .QN(n10308) );
  DFF_X1 \DTP/PC/d_out_reg[6]  ( .D(\DTP/PC/N9 ), .CK(net7833), .Q(PC[4]), 
        .QN(n10072) );
  DFF_X1 \DTP/PC/d_out_reg[7]  ( .D(\DTP/PC/N10 ), .CK(net7833), .Q(PC[5]), 
        .QN(n9331) );
  DFF_X1 \DTP/ALU_REG/d_out_reg[9]  ( .D(\DTP/ALU_REG/N11 ), .CK(Clk), .Q(
        n10152) );
  DFF_X1 \DTP/ALU_REG/d_out_reg[8]  ( .D(\DTP/ALU_REG/N10 ), .CK(Clk), .QN(
        n9313) );
  DFF_X1 \DTP/PC/d_out_reg[8]  ( .D(\DTP/PC/N11 ), .CK(net7833), .Q(PC[6]), 
        .QN(n10071) );
  DFF_X1 \DTP/PC/d_out_reg[9]  ( .D(\DTP/PC/N12 ), .CK(net7833), .Q(PC[7]), 
        .QN(n9328) );
  DFF_X1 \DTP/ALU_REG/d_out_reg[11]  ( .D(\DTP/ALU_REG/N13 ), .CK(Clk), .Q(
        n10159) );
  DFF_X1 \DTP/ALU_REG/d_out_reg[10]  ( .D(\DTP/ALU_REG/N12 ), .CK(Clk), .Q(
        n9348) );
  DFF_X1 \DTP/PC/d_out_reg[10]  ( .D(\DTP/PC/N13 ), .CK(net7833), .Q(PC[8]), 
        .QN(n10070) );
  DFF_X1 \DTP/ALU_REG/d_out_reg[12]  ( .D(\DTP/ALU_REG/N14 ), .CK(Clk), .Q(
        n9349) );
  DFF_X1 \DTP/ALU_REG/d_out_reg[13]  ( .D(\DTP/ALU_REG/N15 ), .CK(Clk), .Q(
        n10153) );
  DFF_X1 \DTP/ALU_REG/d_out_reg[14]  ( .D(\DTP/ALU_REG/N16 ), .CK(Clk), .Q(
        n10163) );
  DFF_X1 \DTP/PC/d_out_reg[14]  ( .D(\DTP/PC/N17 ), .CK(net7833), .Q(PC[12]), 
        .QN(n10068) );
  DFF_X1 \DTP/PC/d_out_reg[13]  ( .D(\DTP/PC/N16 ), .CK(net7833), .Q(PC[11]), 
        .QN(n9327) );
  DFF_X1 \DTP/PC/d_out_reg[12]  ( .D(\DTP/PC/N15 ), .CK(net7833), .Q(PC[10]), 
        .QN(n10069) );
  DFF_X1 \DTP/PC/d_out_reg[11]  ( .D(\DTP/PC/N14 ), .CK(net7833), .Q(PC[9]), 
        .QN(n9330) );
  DFF_X1 \DTP/PC/d_out_reg[15]  ( .D(\DTP/PC/N18 ), .CK(net7833), .Q(PC[13]), 
        .QN(n9326) );
  DFF_X1 \DTP/ALU_REG/d_out_reg[16]  ( .D(\DTP/ALU_REG/N18 ), .CK(Clk), .Q(
        n9315) );
  DFF_X1 \DTP/PC/d_out_reg[16]  ( .D(\DTP/PC/N19 ), .CK(net7833), .Q(PC[14]), 
        .QN(n10067) );
  DFF_X1 \DTP/ALU_REG/d_out_reg[17]  ( .D(\DTP/ALU_REG/N19 ), .CK(Clk), .QN(
        n932) );
  DFF_X1 \DTP/PC/d_out_reg[17]  ( .D(\DTP/PC/N20 ), .CK(net7833), .Q(PC[15]), 
        .QN(n9325) );
  DFF_X1 \DTP/ALU_REG/d_out_reg[18]  ( .D(\DTP/ALU_REG/N20 ), .CK(Clk), .Q(
        n10150) );
  DFF_X1 \DTP/PC/d_out_reg[18]  ( .D(\DTP/PC/N21 ), .CK(net7833), .Q(PC[16]), 
        .QN(n10066) );
  DFF_X1 \DTP/ALU_REG/d_out_reg[19]  ( .D(\DTP/ALU_REG/N21 ), .CK(Clk), .QN(
        n934) );
  DFF_X1 \DTP/PC/d_out_reg[19]  ( .D(\DTP/PC/N22 ), .CK(net7833), .Q(PC[17]), 
        .QN(n9324) );
  DFF_X1 \DTP/ALU_REG/d_out_reg[20]  ( .D(\DTP/ALU_REG/N22 ), .CK(Clk), .QN(
        n935) );
  DFF_X1 \DTP/PC/d_out_reg[20]  ( .D(\DTP/PC/N23 ), .CK(net7833), .Q(PC[18]), 
        .QN(n10065) );
  DFF_X1 \DTP/ALU_REG/d_out_reg[21]  ( .D(\DTP/ALU_REG/N23 ), .CK(Clk), .QN(
        n936) );
  DFF_X1 \DTP/PC/d_out_reg[21]  ( .D(\DTP/PC/N24 ), .CK(net7833), .Q(PC[19]), 
        .QN(n9323) );
  DFF_X1 \DTP/ALU_REG/d_out_reg[22]  ( .D(\DTP/ALU_REG/N24 ), .CK(Clk), .QN(
        n10215) );
  DFF_X1 \DTP/PC/d_out_reg[22]  ( .D(\DTP/PC/N25 ), .CK(net7833), .Q(PC[20]), 
        .QN(n10064) );
  DFF_X1 \DTP/ALU_REG/d_out_reg[23]  ( .D(\DTP/ALU_REG/N25 ), .CK(Clk), .QN(
        n10213) );
  DFF_X1 \DTP/PC/d_out_reg[23]  ( .D(\DTP/PC/N26 ), .CK(net7833), .Q(PC[21]), 
        .QN(n9322) );
  DFF_X1 \DTP/ALU_REG/d_out_reg[24]  ( .D(\DTP/ALU_REG/N26 ), .CK(Clk), .Q(
        n10151), .QN(n10304) );
  DFF_X1 \DTP/PC/d_out_reg[24]  ( .D(\DTP/PC/N27 ), .CK(net7833), .Q(PC[22]), 
        .QN(n10063) );
  DFF_X1 \DTP/ALU_REG/d_out_reg[25]  ( .D(\DTP/ALU_REG/N27 ), .CK(Clk), .Q(
        n10172) );
  DFF_X1 \DTP/PC/d_out_reg[25]  ( .D(n10221), .CK(net7833), .Q(PC[23]), .QN(
        n9321) );
  DFF_X1 \DTP/ALU_REG/d_out_reg[26]  ( .D(\DTP/ALU_REG/N28 ), .CK(Clk), .QN(
        n10146) );
  DFF_X1 \DTP/PC/d_out_reg[26]  ( .D(\DTP/PC/N29 ), .CK(net7833), .Q(PC[24]), 
        .QN(n10062) );
  DFF_X1 \DTP/ALU_REG/d_out_reg[27]  ( .D(\DTP/ALU_REG/N29 ), .CK(Clk), .QN(
        n10147) );
  DFF_X1 \DTP/PC/d_out_reg[27]  ( .D(\DTP/PC/N30 ), .CK(net7833), .Q(PC[25]), 
        .QN(n9320) );
  DFF_X1 \DTP/ALU_REG/d_out_reg[28]  ( .D(\DTP/ALU_REG/N30 ), .CK(Clk), .QN(
        n939) );
  DFF_X1 \DTP/ALU_REG/d_out_reg[29]  ( .D(\DTP/ALU_REG/N31 ), .CK(Clk), .QN(
        n10148) );
  DFF_X1 \DTP/PC/d_out_reg[29]  ( .D(\DTP/PC/N32 ), .CK(net7833), .Q(PC[27]), 
        .QN(n9319) );
  DFF_X1 \DTP/ALU_REG/d_out_reg[30]  ( .D(\DTP/ALU_REG/N32 ), .CK(Clk), .QN(
        n10211) );
  DFF_X1 \DTP/PC/d_out_reg[0]  ( .D(\DTP/PC/N3 ), .CK(net7833), .Q(n10323), 
        .QN(n10174) );
  FA_X1 \intadd_0/U6  ( .A(n9794), .B(\intadd_0/B[0] ), .CI(\intadd_0/CI ), 
        .CO(\intadd_0/n5 ), .S(\intadd_0/SUM[0] ) );
  FA_X1 \intadd_0/U5  ( .A(n9793), .B(PC[0]), .CI(\intadd_0/n5 ), .CO(
        \intadd_0/n4 ), .S(\intadd_0/SUM[1] ) );
  FA_X1 \intadd_0/U4  ( .A(n9792), .B(n9737), .CI(\intadd_0/n4 ), .CO(
        \intadd_0/n3 ), .S(\intadd_0/SUM[2] ) );
  FA_X1 \intadd_0/U3  ( .A(n9791), .B(n9736), .CI(\intadd_0/n3 ), .CO(
        \intadd_0/n2 ), .S(\intadd_0/SUM[3] ) );
  FA_X1 \intadd_0/U2  ( .A(n9790), .B(n9764), .CI(\intadd_0/n2 ), .CO(
        \intadd_0/n1 ), .S(\intadd_0/SUM[4] ) );
  DFF_X1 \DTP/IR/d_out_reg[23]  ( .D(\DTP/IR/N25 ), .CK(Clk), .Q(n10099) );
  DFF_X1 \DTP/IR/d_out_reg[24]  ( .D(\DTP/IR/N26 ), .CK(Clk), .QN(n10094) );
  DFF_X1 R_223 ( .D(n9284), .CK(Clk), .QN(n10220) );
  FA_X1 \intadd_2/U4  ( .A(IR[10]), .B(\DTP/NPC[10] ), .CI(\intadd_2/CI ), 
        .CO(\intadd_2/n3 ), .S(\intadd_2/SUM[0] ) );
  FA_X1 \intadd_2/U3  ( .A(IR[11]), .B(\intadd_2/B[1] ), .CI(\intadd_2/n3 ), 
        .CO(\intadd_2/n2 ), .S(\intadd_2/SUM[1] ) );
  FA_X1 \intadd_2/U2  ( .A(IR[12]), .B(\DTP/NPC[12] ), .CI(\intadd_2/n2 ), 
        .CO(\intadd_2/n1 ), .S(\intadd_2/SUM[2] ) );
  DFF_X1 \DTP/PC/R_224_PC_d_out_reg[30]  ( .D(n10211), .CK(net7833), .Q(n10317) );
  DFF_X1 \DTP/PC/R_225_PC_d_out_reg[30]  ( .D(n10524), .CK(net7833), .Q(n10316) );
  DFF_X1 \DTP/PC/R_232_PC_d_out_reg[30]  ( .D(n10520), .CK(net7833), .Q(n10314) );
  DFF_X1 \DTP/PC/R_233_PC_d_out_reg[30]  ( .D(n10326), .CK(net7833), .Q(n10313) );
  DFF_X1 \DTP/PC/R_234_PC_d_out_reg[30]  ( .D(n10303), .CK(net7833), .Q(n10312) );
  DFF_X1 \DTP/PC/R_231_PC_d_out_reg[30]  ( .D(n10224), .CK(net7833), .Q(n10315) );
  DFF_X1 \DTP/PC/R_235_PC_d_out_reg[31]  ( .D(n10526), .CK(net7833), .Q(n10311) );
  DFF_X1 \DTP/PC/R_237_PC_d_out_reg[31]  ( .D(n10525), .CK(net7833), .Q(n10310) );
  DFF_X1 \DTP/PC/R_238_PC_d_out_reg[28]  ( .D(n10512), .CK(net7833), .Q(n10309), .QN(PC[26]) );
  DFF_X1 R_244 ( .D(n10307), .CK(net7833), .Q(n10368), .QN(n10290) );
  DFF_X1 R_245 ( .D(n10528), .CK(net7833), .Q(n10306) );
  DFF_X1 \DTP/PC/R_246_PC_d_out_reg[31]  ( .D(\DTP/NPC[31] ), .CK(net7833), 
        .Q(n10305) );
  DFF_X1 \DTP/NPCreg1/d_out_reg[3]  ( .D(n10278), .CK(Clk), .QN(n10133) );
  DFF_X1 \DTP/NPCreg1/d_out_reg[6]  ( .D(n10277), .CK(Clk), .QN(n10136) );
  DFF_X1 \DTP/NPCreg1/d_out_reg[5]  ( .D(n10276), .CK(Clk), .QN(n10135) );
  DFF_X1 \DTP/NPCreg1/d_out_reg[4]  ( .D(n10275), .CK(Clk), .QN(n10134) );
  DFF_X1 \DTP/NPCreg1/d_out_reg[8]  ( .D(n10274), .CK(Clk), .QN(n10106) );
  DFF_X1 \DTP/NPCreg1/d_out_reg[9]  ( .D(n10273), .CK(Clk), .QN(n10107) );
  DFF_X1 \DTP/NPCreg1/d_out_reg[10]  ( .D(n10272), .CK(Clk), .QN(n10108) );
  DFF_X1 \DTP/NPCreg1/d_out_reg[12]  ( .D(n10271), .CK(Clk), .QN(n10110) );
  DFF_X1 \DTP/NPCreg1/d_out_reg[13]  ( .D(n10270), .CK(Clk), .QN(n10111) );
  DFF_X1 \DTP/NPCreg1/d_out_reg[14]  ( .D(n10269), .CK(Clk), .QN(n10112) );
  DFF_X1 \DTP/NPCreg1/d_out_reg[15]  ( .D(n10268), .CK(Clk), .QN(n10113) );
  DFF_X1 \DTP/NPCreg1/d_out_reg[16]  ( .D(n10267), .CK(Clk), .QN(n10114) );
  DFF_X1 \DTP/NPCreg1/d_out_reg[17]  ( .D(n10266), .CK(Clk), .QN(n10115) );
  DFF_X1 \DTP/NPCreg1/d_out_reg[18]  ( .D(n10265), .CK(Clk), .QN(n10117) );
  DFF_X1 \DTP/NPCreg1/d_out_reg[19]  ( .D(n10264), .CK(Clk), .QN(n10118) );
  DFF_X1 \DTP/NPCreg1/d_out_reg[20]  ( .D(n10263), .CK(Clk), .QN(n10119) );
  DFF_X1 \DTP/NPCreg1/d_out_reg[21]  ( .D(n10262), .CK(Clk), .QN(n10120) );
  DFF_X1 \DTP/NPCreg1/d_out_reg[22]  ( .D(n10261), .CK(Clk), .QN(n10121) );
  DFF_X1 \DTP/NPCreg1/d_out_reg[23]  ( .D(n10260), .CK(Clk), .QN(n10122) );
  DFF_X1 \DTP/NPCreg1/d_out_reg[26]  ( .D(n10259), .CK(Clk), .QN(n10125) );
  DFF_X1 \DTP/NPCreg1/d_out_reg[25]  ( .D(n10258), .CK(Clk), .QN(n10124) );
  DFF_X1 \DTP/NPCreg1/d_out_reg[24]  ( .D(n10257), .CK(Clk), .QN(n10123) );
  DFF_X1 \DTP/NPCreg1/d_out_reg[27]  ( .D(n10256), .CK(Clk), .QN(n10126) );
  DFF_X1 \DTP/NPCreg1/d_out_reg[28]  ( .D(n10255), .CK(Clk), .QN(n10128) );
  DFF_X1 \DTP/NPCreg1/d_out_reg[29]  ( .D(n10254), .CK(Clk), .QN(n10129) );
  DFF_X1 \DTP/NPCreg1/d_out_reg[30]  ( .D(n10253), .CK(Clk), .QN(n10130) );
  DFF_X1 \DTP/NPCreg1/d_out_reg[31]  ( .D(n10252), .CK(Clk), .QN(n10131) );
  NAND2_X1 U10421 ( .A1(PC[23]), .A2(PC[22]), .ZN(n10234) );
  NOR3_X1 U10422 ( .A1(n10321), .A2(n9322), .A3(n10234), .ZN(n10362) );
  NOR2_X1 U10423 ( .A1(n10156), .A2(n10155), .ZN(n10235) );
  NAND2_X1 U10424 ( .A1(n10388), .A2(n10235), .ZN(n10407) );
  XOR2_X1 U10425 ( .A(n10484), .B(n10064), .Z(n10227) );
  INV_X1 U10426 ( .A(n10361), .ZN(n10236) );
  AOI22_X1 U10427 ( .A1(n10361), .A2(PC[22]), .B1(n10063), .B2(n10236), .ZN(
        n10226) );
  INV_X1 U10428 ( .A(IR[6]), .ZN(n10237) );
  OAI21_X1 U10429 ( .B1(IR[6]), .B2(n10542), .A(n10232), .ZN(n10238) );
  OAI21_X1 U10430 ( .B1(n10237), .B2(\intadd_0/n1 ), .A(n10238), .ZN(n10415)
         );
  NOR3_X1 U10431 ( .A1(n10286), .A2(n10229), .A3(\DTP/NPC[21] ), .ZN(n10239)
         );
  NAND3_X1 U10432 ( .A1(n10467), .A2(n10487), .A3(n10239), .ZN(n10499) );
  AND4_X1 U10433 ( .A1(\DTP/PC/N6 ), .A2(\DTP/PC/N5 ), .A3(\DTP/PC/N7 ), .A4(
        \DTP/PC/N8 ), .ZN(n10307) );
  AOI22_X1 U10434 ( .A1(n10414), .A2(n10541), .B1(n10144), .B2(n10603), .ZN(
        n10240) );
  XOR2_X1 U10435 ( .A(n10415), .B(IR[7]), .Z(n10241) );
  NAND2_X1 U10436 ( .A1(n10414), .A2(n10241), .ZN(n10242) );
  OAI211_X1 U10437 ( .C1(n10414), .C2(n10241), .A(n10543), .B(n10242), .ZN(
        n10243) );
  OAI211_X1 U10438 ( .C1(n10325), .C2(n10157), .A(n10240), .B(n10243), .ZN(
        \DTP/PC/N10 ) );
  OAI21_X1 U10439 ( .B1(n10414), .B2(IR[7]), .A(n10415), .ZN(n10244) );
  OAI21_X1 U10440 ( .B1(n10245), .B2(n10246), .A(n10244), .ZN(n10420) );
  INV_X1 U10441 ( .A(n10414), .ZN(n10245) );
  INV_X1 U10442 ( .A(IR[7]), .ZN(n10246) );
  NOR2_X1 U10443 ( .A1(n9736), .A2(n10329), .ZN(n10275) );
  NAND2_X1 U10444 ( .A1(n10517), .A2(\DTP/PC/N33 ), .ZN(n10247) );
  XNOR2_X1 U10445 ( .A(\DTP/PC/N34 ), .B(n10247), .ZN(\DTP/NPC[31] ) );
  AOI22_X1 U10446 ( .A1(n10232), .A2(n10541), .B1(n10145), .B2(n10603), .ZN(
        n10248) );
  XOR2_X1 U10447 ( .A(n10542), .B(IR[6]), .Z(n10249) );
  NAND2_X1 U10448 ( .A1(n10232), .A2(n10249), .ZN(n10250) );
  OAI211_X1 U10449 ( .C1(n10232), .C2(n10249), .A(n10543), .B(n10250), .ZN(
        n10251) );
  OAI211_X1 U10450 ( .C1(n10325), .C2(n10058), .A(n10248), .B(n10251), .ZN(
        \DTP/PC/N9 ) );
  AND2_X1 U10451 ( .A1(\DTP/NPC[31] ), .A2(Rst), .ZN(n10252) );
  AND2_X1 U10452 ( .A1(n10224), .A2(Rst), .ZN(n10253) );
  AND2_X1 U10453 ( .A1(\DTP/NPC[29] ), .A2(Rst), .ZN(n10254) );
  AND2_X1 U10454 ( .A1(\DTP/NPC[28] ), .A2(Rst), .ZN(n10255) );
  AND2_X1 U10455 ( .A1(\DTP/NPC[27] ), .A2(Rst), .ZN(n10256) );
  AND2_X1 U10456 ( .A1(n10226), .A2(Rst), .ZN(n10257) );
  AND2_X1 U10457 ( .A1(\DTP/NPC[25] ), .A2(Rst), .ZN(n10258) );
  AND2_X1 U10458 ( .A1(n10225), .A2(Rst), .ZN(n10259) );
  AND2_X1 U10459 ( .A1(\DTP/NPC[23] ), .A2(Rst), .ZN(n10260) );
  AND2_X1 U10460 ( .A1(n10227), .A2(Rst), .ZN(n10261) );
  AND2_X1 U10461 ( .A1(\DTP/NPC[21] ), .A2(Rst), .ZN(n10262) );
  AND2_X1 U10462 ( .A1(n10228), .A2(Rst), .ZN(n10263) );
  AND2_X1 U10463 ( .A1(\DTP/NPC[19] ), .A2(Rst), .ZN(n10264) );
  AND2_X1 U10464 ( .A1(n10229), .A2(Rst), .ZN(n10265) );
  AND2_X1 U10465 ( .A1(\DTP/NPC[17] ), .A2(Rst), .ZN(n10266) );
  AND2_X1 U10466 ( .A1(n10230), .A2(Rst), .ZN(n10267) );
  AND2_X1 U10467 ( .A1(\DTP/NPC[15] ), .A2(Rst), .ZN(n10268) );
  AND2_X1 U10468 ( .A1(\DTP/NPC[14] ), .A2(Rst), .ZN(n10269) );
  AND2_X1 U10469 ( .A1(\DTP/NPC[13] ), .A2(Rst), .ZN(n10270) );
  AND2_X1 U10470 ( .A1(\DTP/NPC[12] ), .A2(Rst), .ZN(n10271) );
  AND2_X1 U10471 ( .A1(\DTP/NPC[10] ), .A2(Rst), .ZN(n10272) );
  AND2_X1 U10472 ( .A1(\DTP/NPC[9] ), .A2(Rst), .ZN(n10273) );
  AND2_X1 U10473 ( .A1(n10231), .A2(Rst), .ZN(n10274) );
  AND2_X1 U10474 ( .A1(\DTP/NPC[5] ), .A2(Rst), .ZN(n10276) );
  AND2_X1 U10475 ( .A1(n10232), .A2(Rst), .ZN(n10277) );
  AND2_X1 U10476 ( .A1(n10233), .A2(Rst), .ZN(n10278) );
  OR2_X2 U10477 ( .A1(n9297), .A2(n10329), .ZN(n10387) );
  INV_X1 U10478 ( .A(Rst), .ZN(n10329) );
  NOR2_X1 U10479 ( .A1(n10410), .A2(n10329), .ZN(n10543) );
  INV_X1 U10480 ( .A(n10566), .ZN(n10569) );
  AND2_X1 U10481 ( .A1(PC[27]), .A2(n10366), .ZN(n10517) );
  AND2_X1 U10482 ( .A1(n10364), .A2(PC[26]), .ZN(n10366) );
  NOR2_X1 U10483 ( .A1(n10363), .A2(n9320), .ZN(n10364) );
  INV_X1 U10484 ( .A(n10497), .ZN(n10363) );
  NOR2_X1 U10485 ( .A1(n10498), .A2(n10062), .ZN(n10497) );
  INV_X1 U10486 ( .A(n10362), .ZN(n10498) );
  OR2_X1 U10487 ( .A1(n10484), .A2(n10064), .ZN(n10321) );
  INV_X1 U10488 ( .A(n10360), .ZN(n10484) );
  NOR2_X1 U10489 ( .A1(n10359), .A2(n9323), .ZN(n10360) );
  INV_X1 U10490 ( .A(n10474), .ZN(n10359) );
  NOR2_X1 U10491 ( .A1(n10475), .A2(n10065), .ZN(n10474) );
  INV_X1 U10492 ( .A(n10358), .ZN(n10475) );
  AND2_X1 U10493 ( .A1(PC[17]), .A2(n10464), .ZN(n10358) );
  NOR2_X1 U10494 ( .A1(n10465), .A2(n10066), .ZN(n10464) );
  INV_X1 U10495 ( .A(n10356), .ZN(n10465) );
  NOR2_X1 U10496 ( .A1(n10355), .A2(n9325), .ZN(n10356) );
  INV_X1 U10497 ( .A(n10455), .ZN(n10355) );
  AND2_X1 U10498 ( .A1(n10354), .A2(PC[14]), .ZN(n10455) );
  NOR2_X1 U10499 ( .A1(n9326), .A2(n10353), .ZN(n10354) );
  INV_X1 U10500 ( .A(n10352), .ZN(n10353) );
  AND2_X1 U10501 ( .A1(n10350), .A2(PC[12]), .ZN(n10352) );
  NOR2_X1 U10502 ( .A1(n9327), .A2(n10349), .ZN(n10350) );
  INV_X1 U10503 ( .A(n10348), .ZN(n10349) );
  NOR2_X1 U10504 ( .A1(n10347), .A2(n10069), .ZN(n10348) );
  INV_X1 U10505 ( .A(n10371), .ZN(n10347) );
  AND2_X1 U10506 ( .A1(PC[9]), .A2(n10346), .ZN(n10371) );
  AND2_X1 U10507 ( .A1(n10369), .A2(PC[8]), .ZN(n10346) );
  NOR2_X1 U10508 ( .A1(n9328), .A2(n10370), .ZN(n10369) );
  INV_X1 U10509 ( .A(n10411), .ZN(n10370) );
  AND2_X1 U10510 ( .A1(n10373), .A2(PC[6]), .ZN(n10411) );
  NOR2_X1 U10511 ( .A1(n9331), .A2(n10374), .ZN(n10373) );
  INV_X1 U10512 ( .A(n10375), .ZN(n10374) );
  NOR2_X1 U10513 ( .A1(n10290), .A2(n10072), .ZN(n10375) );
  INV_X1 U10514 ( .A(n10556), .ZN(n10558) );
  INV_X1 U10515 ( .A(n10554), .ZN(n10557) );
  INV_X1 U10516 ( .A(n10608), .ZN(n10580) );
  INV_X1 U10517 ( .A(n10598), .ZN(n10609) );
  INV_X1 U10518 ( .A(n10572), .ZN(n10575) );
  INV_X1 U10519 ( .A(n10568), .ZN(n10570) );
  NOR2_X1 U10520 ( .A1(n10083), .A2(n10581), .ZN(n10582) );
  NAND2_X1 U10521 ( .A1(n10580), .A2(n10195), .ZN(n10581) );
  INV_X1 U10522 ( .A(n10524), .ZN(n10603) );
  NOR2_X1 U10523 ( .A1(n10077), .A2(n10559), .ZN(n10560) );
  NAND2_X1 U10524 ( .A1(n10200), .A2(n10558), .ZN(n10559) );
  INV_X1 U10525 ( .A(n10326), .ZN(n10325) );
  INV_X1 U10526 ( .A(n10543), .ZN(n10601) );
  NOR2_X1 U10527 ( .A1(n10085), .A2(n10584), .ZN(n10552) );
  NOR2_X1 U10528 ( .A1(n10084), .A2(n10583), .ZN(n10585) );
  AND2_X1 U10529 ( .A1(n10319), .A2(n10452), .ZN(n10467) );
  INV_X1 U10530 ( .A(n10538), .ZN(n10541) );
  INV_X1 U10531 ( .A(n10601), .ZN(n10324) );
  NOR2_X1 U10532 ( .A1(n10078), .A2(n10561), .ZN(n10562) );
  NOR2_X1 U10533 ( .A1(n10076), .A2(n10553), .ZN(n10555) );
  NAND2_X1 U10534 ( .A1(n10198), .A2(n10552), .ZN(n10553) );
  NAND2_X1 U10535 ( .A1(n10197), .A2(n10585), .ZN(n10584) );
  NAND2_X1 U10536 ( .A1(n10196), .A2(n10582), .ZN(n10583) );
  INV_X1 U10537 ( .A(n10606), .ZN(n10326) );
  NOR2_X1 U10538 ( .A1(n10205), .A2(n10563), .ZN(n10564) );
  NAND2_X1 U10539 ( .A1(n10202), .A2(n10562), .ZN(n10563) );
  NAND2_X1 U10540 ( .A1(n10201), .A2(n10560), .ZN(n10561) );
  OR3_X1 U10541 ( .A1(IR[29]), .A2(IR[31]), .A3(n10294), .ZN(n10343) );
  OR4_X1 U10542 ( .A1(n10183), .A2(n9310), .A3(n10182), .A4(n10544), .ZN(
        n10550) );
  NAND4_X1 U10543 ( .A1(n10406), .A2(n10405), .A3(n10404), .A4(n10410), .ZN(
        n10524) );
  AND2_X1 U10544 ( .A1(Rst), .A2(IR[11]), .ZN(\DTP/IR/N13 ) );
  INV_X1 U10545 ( .A(IR[26]), .ZN(n9784) );
  INV_X1 U10546 ( .A(IR[27]), .ZN(n10342) );
  AND2_X1 U10547 ( .A1(IR[28]), .A2(Rst), .ZN(\DTP/IR/N30 ) );
  INV_X1 U10548 ( .A(Rst), .ZN(n10328) );
  INV_X1 U10549 ( .A(Rst), .ZN(n10327) );
  OR2_X1 U10550 ( .A1(n10093), .A2(n10329), .ZN(n7406) );
  AOI221_X1 U10551 ( .B1(\DTP/NPC[23] ), .B2(n10324), .C1(n10499), .C2(n10324), 
        .A(n10541), .ZN(n10599) );
  NAND4_X1 U10552 ( .A1(n10409), .A2(n10408), .A3(n10410), .A4(n10407), .ZN(
        n10538) );
  NOR3_X1 U10553 ( .A1(\DTP/NPC[27] ), .A2(n10225), .A3(n10318), .ZN(n10510)
         );
  OR4_X1 U10554 ( .A1(n10226), .A2(\DTP/NPC[23] ), .A3(\DTP/NPC[25] ), .A4(
        n10499), .ZN(n10318) );
  NOR2_X1 U10555 ( .A1(n9322), .A2(n10321), .ZN(n10361) );
  OR2_X1 U10556 ( .A1(n10228), .A2(\DTP/NPC[19] ), .ZN(n10286) );
  OR2_X1 U10557 ( .A1(\DTP/NPC[17] ), .A2(n10230), .ZN(n10289) );
  NAND2_X1 U10558 ( .A1(n10361), .A2(PC[22]), .ZN(n10291) );
  INV_X1 U10559 ( .A(\DTP/PC/N33 ), .ZN(n10074) );
  NOR4_X1 U10560 ( .A1(n10226), .A2(\DTP/NPC[23] ), .A3(\DTP/NPC[25] ), .A4(
        n10499), .ZN(n10505) );
  NOR2_X1 U10561 ( .A1(n10289), .A2(\DTP/NPC[15] ), .ZN(n10319) );
  NOR2_X1 U10562 ( .A1(n10479), .A2(n10286), .ZN(n10320) );
  NAND3_X1 U10563 ( .A1(PC[2]), .A2(PC[1]), .A3(PC[0]), .ZN(n10322) );
  NOR2_X1 U10564 ( .A1(n10086), .A2(n10387), .ZN(\DTP/ALU_REG/N10 ) );
  NOR2_X1 U10565 ( .A1(n10158), .A2(n10387), .ZN(\DTP/ALU_REG/N11 ) );
  NOR2_X1 U10566 ( .A1(n10218), .A2(n10387), .ZN(\DTP/ALU_REG/N12 ) );
  NOR2_X1 U10567 ( .A1(n10160), .A2(n10387), .ZN(\DTP/ALU_REG/N13 ) );
  NOR2_X1 U10568 ( .A1(n10161), .A2(n10387), .ZN(\DTP/ALU_REG/N14 ) );
  NOR2_X1 U10569 ( .A1(n10087), .A2(n10387), .ZN(\DTP/ALU_REG/N15 ) );
  NOR2_X1 U10570 ( .A1(n10162), .A2(n10387), .ZN(\DTP/ALU_REG/N16 ) );
  NOR2_X1 U10571 ( .A1(n10164), .A2(n10387), .ZN(\DTP/ALU_REG/N17 ) );
  NOR2_X1 U10572 ( .A1(n10165), .A2(n10387), .ZN(\DTP/ALU_REG/N18 ) );
  NOR2_X1 U10573 ( .A1(n10168), .A2(n10387), .ZN(\DTP/ALU_REG/N19 ) );
  NOR2_X1 U10574 ( .A1(n10173), .A2(n10387), .ZN(\DTP/ALU_REG/N2 ) );
  NOR2_X1 U10575 ( .A1(n10088), .A2(n10387), .ZN(\DTP/ALU_REG/N20 ) );
  NOR2_X1 U10576 ( .A1(n10169), .A2(n10387), .ZN(\DTP/ALU_REG/N21 ) );
  NOR2_X1 U10577 ( .A1(n10170), .A2(n10387), .ZN(\DTP/ALU_REG/N22 ) );
  NOR2_X1 U10578 ( .A1(n10217), .A2(n10387), .ZN(\DTP/ALU_REG/N23 ) );
  NOR2_X1 U10579 ( .A1(n10216), .A2(n10387), .ZN(\DTP/ALU_REG/N24 ) );
  NOR2_X1 U10580 ( .A1(n10214), .A2(n10387), .ZN(\DTP/ALU_REG/N25 ) );
  NOR2_X1 U10581 ( .A1(n10171), .A2(n10387), .ZN(\DTP/ALU_REG/N26 ) );
  NOR2_X1 U10582 ( .A1(n10059), .A2(n10387), .ZN(\DTP/ALU_REG/N27 ) );
  NOR2_X1 U10583 ( .A1(n10089), .A2(n10387), .ZN(\DTP/ALU_REG/N28 ) );
  NOR2_X1 U10584 ( .A1(n10090), .A2(n10387), .ZN(\DTP/ALU_REG/N29 ) );
  NOR2_X1 U10585 ( .A1(n10054), .A2(n10387), .ZN(\DTP/ALU_REG/N3 ) );
  NOR2_X1 U10586 ( .A1(n10176), .A2(n10387), .ZN(\DTP/ALU_REG/N30 ) );
  NOR2_X1 U10587 ( .A1(n10177), .A2(n10387), .ZN(\DTP/ALU_REG/N31 ) );
  NOR2_X1 U10588 ( .A1(n10212), .A2(n10387), .ZN(\DTP/ALU_REG/N32 ) );
  NOR2_X1 U10589 ( .A1(n10091), .A2(n10387), .ZN(\DTP/ALU_REG/N33 ) );
  NOR2_X1 U10590 ( .A1(n10092), .A2(n10387), .ZN(\DTP/ALU_REG/N4 ) );
  NOR2_X1 U10591 ( .A1(n10055), .A2(n10387), .ZN(\DTP/ALU_REG/N5 ) );
  NOR2_X1 U10592 ( .A1(n10056), .A2(n10387), .ZN(\DTP/ALU_REG/N6 ) );
  NOR2_X1 U10593 ( .A1(n10057), .A2(n10387), .ZN(\DTP/ALU_REG/N7 ) );
  NOR2_X1 U10594 ( .A1(n10058), .A2(n10387), .ZN(\DTP/ALU_REG/N8 ) );
  NOR2_X1 U10595 ( .A1(n10157), .A2(n10387), .ZN(\DTP/ALU_REG/N9 ) );
  NOR3_X1 U10596 ( .A1(IR[30]), .A2(IR[27]), .A3(n10343), .ZN(n10401) );
  AND2_X1 U10597 ( .A1(n10401), .A2(\DTP/IR/N30 ), .ZN(\DTP/BRANCH_opREG1/N2 )
         );
  OAI22_X1 U10598 ( .A1(n10101), .A2(n9309), .B1(n9308), .B2(n10094), .ZN(
        n10330) );
  AOI221_X1 U10599 ( .B1(n10101), .B2(n9309), .C1(n10094), .C2(n9308), .A(
        n10330), .ZN(n10333) );
  OAI22_X1 U10600 ( .A1(n10102), .A2(n10193), .B1(n10099), .B2(n9298), .ZN(
        n10331) );
  AOI221_X1 U10601 ( .B1(n10102), .B2(n10193), .C1(n9298), .C2(n10099), .A(
        n10331), .ZN(n10332) );
  OAI211_X1 U10602 ( .C1(n10097), .C2(n9346), .A(n10333), .B(n10332), .ZN(
        n10334) );
  AOI21_X1 U10603 ( .B1(n10097), .B2(n9346), .A(n10334), .ZN(n10397) );
  INV_X1 U10604 ( .A(n10397), .ZN(n10404) );
  NOR2_X1 U10605 ( .A1(n10404), .A2(n7406), .ZN(\DTP/FWDBRANCH1/N2 ) );
  OAI22_X1 U10606 ( .A1(n10101), .A2(n10100), .B1(n10103), .B2(n10102), .ZN(
        n10335) );
  AOI221_X1 U10607 ( .B1(n10101), .B2(n10100), .C1(n10102), .C2(n10103), .A(
        n10335), .ZN(n10338) );
  OAI22_X1 U10608 ( .A1(n10094), .A2(n10095), .B1(n10097), .B2(n10096), .ZN(
        n10336) );
  AOI21_X1 U10609 ( .B1(n10097), .B2(n10096), .A(n10336), .ZN(n10337) );
  OAI211_X1 U10610 ( .C1(n10099), .C2(n10098), .A(n10338), .B(n10337), .ZN(
        n10339) );
  AOI21_X1 U10611 ( .B1(n10099), .B2(n10098), .A(n10339), .ZN(n10406) );
  INV_X1 U10612 ( .A(n10406), .ZN(n10340) );
  AOI211_X1 U10613 ( .C1(n10094), .C2(n10095), .A(n10340), .B(n7406), .ZN(
        \DTP/FWDBRANCH2/N2 ) );
  AND2_X1 U10614 ( .A1(Rst), .A2(IR[16]), .ZN(\DTP/IR/N18 ) );
  AND2_X1 U10615 ( .A1(Rst), .A2(IR[17]), .ZN(\DTP/IR/N19 ) );
  AND2_X1 U10616 ( .A1(Rst), .A2(IR[18]), .ZN(\DTP/IR/N20 ) );
  AND2_X1 U10617 ( .A1(Rst), .A2(IR[19]), .ZN(\DTP/IR/N21 ) );
  AND2_X1 U10618 ( .A1(Rst), .A2(IR[20]), .ZN(\DTP/IR/N22 ) );
  AND2_X1 U10619 ( .A1(Rst), .A2(IR[21]), .ZN(\DTP/IR/N23 ) );
  AND2_X1 U10620 ( .A1(Rst), .A2(IR[22]), .ZN(\DTP/IR/N24 ) );
  AND2_X1 U10621 ( .A1(Rst), .A2(IR[23]), .ZN(\DTP/IR/N25 ) );
  AND2_X1 U10622 ( .A1(Rst), .A2(IR[24]), .ZN(\DTP/IR/N26 ) );
  AND2_X1 U10623 ( .A1(Rst), .A2(IR[25]), .ZN(\DTP/IR/N27 ) );
  NOR2_X1 U10624 ( .A1(n10342), .A2(n10329), .ZN(\DTP/IR/N29 ) );
  AND2_X1 U10625 ( .A1(IR[29]), .A2(Rst), .ZN(\DTP/IR/N31 ) );
  AND2_X1 U10626 ( .A1(IR[31]), .A2(Rst), .ZN(\DTP/IR/N33 ) );
  INV_X1 U10627 ( .A(\DTP/IR/N29 ), .ZN(n10341) );
  NOR4_X1 U10628 ( .A1(IR[28]), .A2(n10343), .A3(n10341), .A4(n9784), .ZN(
        \DTP/JALreg1/N2 ) );
  NOR2_X1 U10629 ( .A1(n10104), .A2(n10328), .ZN(\DTP/JALreg2/N2 ) );
  NAND2_X1 U10630 ( .A1(IR[30]), .A2(Rst), .ZN(n10607) );
  NOR4_X1 U10631 ( .A1(IR[28]), .A2(n10343), .A3(n10342), .A4(n10607), .ZN(
        \DTP/JRreg1/N2 ) );
  NOR2_X1 U10632 ( .A1(n10179), .A2(n10182), .ZN(n10389) );
  OAI221_X1 U10633 ( .B1(n10280), .B2(n10183), .C1(n10280), .C2(n10180), .A(
        n10389), .ZN(n10344) );
  NOR3_X1 U10634 ( .A1(n10296), .A2(n10328), .A3(n10344), .ZN(
        \DTP/LOADREG1/N2 ) );
  INV_X1 U10635 ( .A(n10373), .ZN(n10412) );
  INV_X1 U10636 ( .A(n10369), .ZN(n10345) );
  AOI21_X1 U10637 ( .B1(n10070), .B2(n10345), .A(n10346), .ZN(\DTP/NPC[10] )
         );
  INV_X1 U10638 ( .A(n10346), .ZN(n10372) );
  AOI21_X1 U10639 ( .B1(n10069), .B2(n10347), .A(n10348), .ZN(\DTP/NPC[12] )
         );
  AOI21_X1 U10640 ( .B1(n9327), .B2(n10349), .A(n10350), .ZN(\DTP/NPC[13] ) );
  INV_X1 U10641 ( .A(n10350), .ZN(n10351) );
  AOI21_X1 U10642 ( .B1(n10068), .B2(n10351), .A(n10352), .ZN(\DTP/NPC[14] )
         );
  AOI21_X1 U10643 ( .B1(n9326), .B2(n10353), .A(n10354), .ZN(\DTP/NPC[15] ) );
  INV_X1 U10644 ( .A(n10354), .ZN(n10456) );
  AOI21_X1 U10645 ( .B1(n9325), .B2(n10355), .A(n10356), .ZN(\DTP/NPC[17] ) );
  INV_X1 U10646 ( .A(n10464), .ZN(n10357) );
  AOI21_X1 U10647 ( .B1(n9324), .B2(n10357), .A(n10358), .ZN(\DTP/NPC[19] ) );
  AOI21_X1 U10648 ( .B1(n9323), .B2(n10359), .A(n10360), .ZN(\DTP/NPC[21] ) );
  AOI21_X1 U10649 ( .B1(n9322), .B2(n10321), .A(n10361), .ZN(\DTP/NPC[23] ) );
  AOI21_X1 U10650 ( .B1(n9321), .B2(n10291), .A(n10362), .ZN(\DTP/NPC[25] ) );
  AOI21_X1 U10651 ( .B1(n9320), .B2(n10363), .A(n10364), .ZN(\DTP/NPC[27] ) );
  INV_X1 U10652 ( .A(n10364), .ZN(n10365) );
  AOI21_X1 U10653 ( .B1(n10309), .B2(n10365), .A(n10366), .ZN(\DTP/NPC[28] )
         );
  INV_X1 U10654 ( .A(n10366), .ZN(n10367) );
  AOI21_X1 U10655 ( .B1(n9319), .B2(n10367), .A(n10517), .ZN(\DTP/NPC[29] ) );
  AOI21_X1 U10656 ( .B1(n10308), .B2(n10322), .A(n10368), .ZN(\DTP/NPC[5] ) );
  AOI21_X1 U10657 ( .B1(n9328), .B2(n10370), .A(n10369), .ZN(\DTP/NPC[9] ) );
  AOI21_X1 U10658 ( .B1(n9330), .B2(n10372), .A(n10371), .ZN(\intadd_2/B[1] )
         );
  AND2_X1 U10659 ( .A1(Rst), .A2(\intadd_2/B[1] ), .ZN(\DTP/NPCreg1/N13 ) );
  NOR2_X1 U10660 ( .A1(n10174), .A2(n10329), .ZN(\DTP/NPCreg1/N2 ) );
  AND2_X1 U10661 ( .A1(Rst), .A2(n10105), .ZN(\DTP/NPCreg1/N3 ) );
  NOR2_X1 U10662 ( .A1(n10328), .A2(PC[0]), .ZN(\DTP/NPCreg1/N4 ) );
  AOI21_X1 U10663 ( .B1(n9331), .B2(n10374), .A(n10373), .ZN(n10414) );
  AND2_X1 U10664 ( .A1(Rst), .A2(n10414), .ZN(\DTP/NPCreg1/N9 ) );
  NOR2_X1 U10665 ( .A1(n10106), .A2(n10329), .ZN(\DTP/NPCreg2/N10 ) );
  NOR2_X1 U10666 ( .A1(n10107), .A2(n10327), .ZN(\DTP/NPCreg2/N11 ) );
  NOR2_X1 U10667 ( .A1(n10108), .A2(n10329), .ZN(\DTP/NPCreg2/N12 ) );
  NOR2_X1 U10668 ( .A1(n10109), .A2(n10329), .ZN(\DTP/NPCreg2/N13 ) );
  NOR2_X1 U10669 ( .A1(n10110), .A2(n10327), .ZN(\DTP/NPCreg2/N14 ) );
  NOR2_X1 U10670 ( .A1(n10111), .A2(n10327), .ZN(\DTP/NPCreg2/N15 ) );
  NOR2_X1 U10671 ( .A1(n10112), .A2(n10327), .ZN(\DTP/NPCreg2/N16 ) );
  NOR2_X1 U10672 ( .A1(n10113), .A2(n10328), .ZN(\DTP/NPCreg2/N17 ) );
  NOR2_X1 U10673 ( .A1(n10114), .A2(n10328), .ZN(\DTP/NPCreg2/N18 ) );
  NOR2_X1 U10674 ( .A1(n10115), .A2(n10327), .ZN(\DTP/NPCreg2/N19 ) );
  NOR2_X1 U10675 ( .A1(n10116), .A2(n10328), .ZN(\DTP/NPCreg2/N2 ) );
  NOR2_X1 U10676 ( .A1(n10117), .A2(n10328), .ZN(\DTP/NPCreg2/N20 ) );
  NOR2_X1 U10677 ( .A1(n10118), .A2(n10328), .ZN(\DTP/NPCreg2/N21 ) );
  NOR2_X1 U10678 ( .A1(n10119), .A2(n10329), .ZN(\DTP/NPCreg2/N22 ) );
  NOR2_X1 U10679 ( .A1(n10120), .A2(n10327), .ZN(\DTP/NPCreg2/N23 ) );
  NOR2_X1 U10680 ( .A1(n10121), .A2(n10327), .ZN(\DTP/NPCreg2/N24 ) );
  NOR2_X1 U10681 ( .A1(n10122), .A2(n10328), .ZN(\DTP/NPCreg2/N25 ) );
  NOR2_X1 U10682 ( .A1(n10123), .A2(n10329), .ZN(\DTP/NPCreg2/N26 ) );
  NOR2_X1 U10683 ( .A1(n10124), .A2(n10328), .ZN(\DTP/NPCreg2/N27 ) );
  NOR2_X1 U10684 ( .A1(n10125), .A2(n10329), .ZN(\DTP/NPCreg2/N28 ) );
  NOR2_X1 U10685 ( .A1(n10126), .A2(n10328), .ZN(\DTP/NPCreg2/N29 ) );
  NOR2_X1 U10686 ( .A1(n10127), .A2(n10327), .ZN(\DTP/NPCreg2/N3 ) );
  NOR2_X1 U10687 ( .A1(n10128), .A2(n10328), .ZN(\DTP/NPCreg2/N30 ) );
  NOR2_X1 U10688 ( .A1(n10129), .A2(n10327), .ZN(\DTP/NPCreg2/N31 ) );
  NOR2_X1 U10689 ( .A1(n10130), .A2(n10329), .ZN(\DTP/NPCreg2/N32 ) );
  NOR2_X1 U10690 ( .A1(n10131), .A2(n10327), .ZN(\DTP/NPCreg2/N33 ) );
  NOR2_X1 U10691 ( .A1(n10132), .A2(n10329), .ZN(\DTP/NPCreg2/N4 ) );
  NOR2_X1 U10692 ( .A1(n10133), .A2(n10327), .ZN(\DTP/NPCreg2/N5 ) );
  NOR2_X1 U10693 ( .A1(n10134), .A2(n10329), .ZN(\DTP/NPCreg2/N6 ) );
  NOR2_X1 U10694 ( .A1(n10135), .A2(n10327), .ZN(\DTP/NPCreg2/N7 ) );
  NOR2_X1 U10695 ( .A1(n10136), .A2(n10329), .ZN(\DTP/NPCreg2/N8 ) );
  NOR2_X1 U10696 ( .A1(n10137), .A2(n10329), .ZN(\DTP/NPCreg2/N9 ) );
  AOI21_X1 U10697 ( .B1(n10072), .B2(n10290), .A(n10375), .ZN(n10232) );
  NAND2_X1 U10698 ( .A1(n9377), .A2(n10220), .ZN(n10386) );
  NAND4_X1 U10699 ( .A1(n10213), .A2(n935), .A3(n936), .A4(n10147), .ZN(n10376) );
  NOR3_X1 U10700 ( .A1(n10139), .A2(n10172), .A3(n10376), .ZN(n10377) );
  NAND3_X1 U10701 ( .A1(n10215), .A2(n10377), .A3(n10304), .ZN(n10385) );
  NAND4_X1 U10702 ( .A1(n939), .A2(n10149), .A3(n932), .A4(n934), .ZN(n10384)
         );
  NAND4_X1 U10703 ( .A1(n10146), .A2(n10148), .A3(n9313), .A4(n10211), .ZN(
        n10383) );
  NOR4_X1 U10704 ( .A1(n10142), .A2(n10140), .A3(n9348), .A4(n10159), .ZN(
        n10381) );
  NOR4_X1 U10705 ( .A1(n9315), .A2(n10150), .A3(n10144), .A4(n10143), .ZN(
        n10380) );
  NOR4_X1 U10706 ( .A1(n10153), .A2(n10175), .A3(n10145), .A4(n10141), .ZN(
        n10379) );
  NOR4_X1 U10707 ( .A1(n10152), .A2(n9349), .A3(n10163), .A4(n10154), .ZN(
        n10378) );
  NAND4_X1 U10708 ( .A1(n10381), .A2(n10380), .A3(n10379), .A4(n10378), .ZN(
        n10382) );
  NOR4_X1 U10709 ( .A1(n10385), .A2(n10384), .A3(n10383), .A4(n10382), .ZN(
        n10597) );
  OAI22_X1 U10710 ( .A1(n10386), .A2(n10219), .B1(n9377), .B2(n10597), .ZN(
        n10388) );
  AOI221_X1 U10711 ( .B1(n9311), .B2(n10407), .C1(n10293), .C2(n10404), .A(
        n10387), .ZN(n10403) );
  NOR2_X1 U10712 ( .A1(n10328), .A2(n10293), .ZN(n10409) );
  NOR2_X1 U10713 ( .A1(n10155), .A2(n10388), .ZN(n10399) );
  OAI211_X1 U10714 ( .C1(n10183), .C2(n10280), .A(n10180), .B(n10389), .ZN(
        n10394) );
  OAI22_X1 U10715 ( .A1(n10281), .A2(n9300), .B1(n10287), .B2(n9308), .ZN(
        n10390) );
  AOI221_X1 U10716 ( .B1(n10281), .B2(n9300), .C1(n9308), .C2(n10287), .A(
        n10390), .ZN(n10393) );
  OAI22_X1 U10717 ( .A1(n10285), .A2(n10186), .B1(n10193), .B2(n10192), .ZN(
        n10391) );
  AOI221_X1 U10718 ( .B1(n10285), .B2(n10186), .C1(n10192), .C2(n10193), .A(
        n10391), .ZN(n10392) );
  OAI211_X1 U10719 ( .C1(n10181), .C2(n10394), .A(n10393), .B(n10392), .ZN(
        n10395) );
  AOI221_X1 U10720 ( .B1(n9298), .B2(n10283), .C1(n10295), .C2(n10188), .A(
        n10395), .ZN(n10396) );
  OAI21_X1 U10721 ( .B1(n10397), .B2(n10396), .A(n10138), .ZN(n10400) );
  INV_X1 U10722 ( .A(n10400), .ZN(n10398) );
  AOI21_X1 U10723 ( .B1(n10156), .B2(n10399), .A(n10398), .ZN(n10408) );
  INV_X1 U10724 ( .A(n10408), .ZN(n10402) );
  NAND4_X1 U10725 ( .A1(IR[15]), .A2(IR[28]), .A3(n10401), .A4(n10400), .ZN(
        n10410) );
  OAI221_X1 U10726 ( .B1(n10403), .B2(n10409), .C1(n10403), .C2(n10402), .A(
        n10410), .ZN(n10606) );
  AOI211_X1 U10727 ( .C1(n10094), .C2(n10095), .A(n9311), .B(n10327), .ZN(
        n10405) );
  INV_X1 U10728 ( .A(\intadd_0/n1 ), .ZN(n10542) );
  AOI21_X1 U10729 ( .B1(n10071), .B2(n10412), .A(n10411), .ZN(n10231) );
  NOR2_X1 U10730 ( .A1(IR[8]), .A2(n10231), .ZN(n10413) );
  AND2_X1 U10731 ( .A1(IR[8]), .A2(n10231), .ZN(n10421) );
  NOR2_X1 U10732 ( .A1(n10413), .A2(n10421), .ZN(n10416) );
  XNOR2_X1 U10733 ( .A(n10416), .B(n10420), .ZN(n10419) );
  OAI22_X1 U10734 ( .A1(n9313), .A2(n10524), .B1(n10086), .B2(n10325), .ZN(
        n10417) );
  AOI21_X1 U10735 ( .B1(n10541), .B2(n10231), .A(n10417), .ZN(n10418) );
  OAI21_X1 U10736 ( .B1(n10601), .B2(n10419), .A(n10418), .ZN(\DTP/PC/N11 ) );
  AOI22_X1 U10737 ( .A1(n10152), .A2(n10603), .B1(n10541), .B2(\DTP/NPC[9] ), 
        .ZN(n10425) );
  OAI22_X1 U10738 ( .A1(IR[8]), .A2(n10231), .B1(n10421), .B2(n10420), .ZN(
        n10427) );
  XNOR2_X1 U10739 ( .A(IR[9]), .B(n10427), .ZN(n10423) );
  AOI21_X1 U10740 ( .B1(\DTP/NPC[9] ), .B2(n10423), .A(n10601), .ZN(n10422) );
  OAI21_X1 U10741 ( .B1(\DTP/NPC[9] ), .B2(n10423), .A(n10422), .ZN(n10424) );
  OAI211_X1 U10742 ( .C1(n10158), .C2(n10325), .A(n10425), .B(n10424), .ZN(
        \DTP/PC/N12 ) );
  AOI22_X1 U10743 ( .A1(n9348), .A2(n10603), .B1(n10541), .B2(\DTP/NPC[10] ), 
        .ZN(n10430) );
  INV_X1 U10744 ( .A(\DTP/NPC[9] ), .ZN(n10428) );
  INV_X1 U10745 ( .A(IR[9]), .ZN(n10426) );
  AOI222_X1 U10746 ( .A1(n10428), .A2(n10427), .B1(n10428), .B2(n10426), .C1(
        n10427), .C2(n10426), .ZN(\intadd_2/CI ) );
  NAND2_X1 U10747 ( .A1(n10543), .A2(\intadd_2/SUM[0] ), .ZN(n10429) );
  OAI211_X1 U10748 ( .C1(n10218), .C2(n10325), .A(n10430), .B(n10429), .ZN(
        \DTP/PC/N13 ) );
  AOI22_X1 U10749 ( .A1(n10159), .A2(n10603), .B1(n10541), .B2(\intadd_2/B[1] ), .ZN(n10432) );
  NAND2_X1 U10750 ( .A1(n10543), .A2(\intadd_2/SUM[1] ), .ZN(n10431) );
  OAI211_X1 U10751 ( .C1(n10160), .C2(n10325), .A(n10432), .B(n10431), .ZN(
        \DTP/PC/N14 ) );
  AOI22_X1 U10752 ( .A1(n10541), .A2(\DTP/NPC[12] ), .B1(n10324), .B2(
        \intadd_2/SUM[2] ), .ZN(n10434) );
  NAND2_X1 U10753 ( .A1(n9349), .A2(n10603), .ZN(n10433) );
  OAI211_X1 U10754 ( .C1(n10161), .C2(n10325), .A(n10434), .B(n10433), .ZN(
        \DTP/PC/N15 ) );
  AOI22_X1 U10755 ( .A1(n10153), .A2(n10603), .B1(n10541), .B2(\DTP/NPC[13] ), 
        .ZN(n10439) );
  NOR2_X1 U10756 ( .A1(IR[13]), .A2(\DTP/NPC[13] ), .ZN(n10435) );
  AND2_X1 U10757 ( .A1(IR[13]), .A2(\DTP/NPC[13] ), .ZN(n10440) );
  NOR2_X1 U10758 ( .A1(n10435), .A2(n10440), .ZN(n10437) );
  AOI21_X1 U10759 ( .B1(\intadd_2/n1 ), .B2(n10437), .A(n10601), .ZN(n10436)
         );
  OAI21_X1 U10760 ( .B1(\intadd_2/n1 ), .B2(n10437), .A(n10436), .ZN(n10438)
         );
  OAI211_X1 U10761 ( .C1(n10087), .C2(n10606), .A(n10439), .B(n10438), .ZN(
        \DTP/PC/N16 ) );
  AOI22_X1 U10762 ( .A1(n10163), .A2(n10603), .B1(n10541), .B2(\DTP/NPC[14] ), 
        .ZN(n10447) );
  OAI22_X1 U10763 ( .A1(IR[13]), .A2(\DTP/NPC[13] ), .B1(n10440), .B2(
        \intadd_2/n1 ), .ZN(n10442) );
  INV_X1 U10764 ( .A(IR[14]), .ZN(n10441) );
  NOR2_X1 U10765 ( .A1(n10442), .A2(n10441), .ZN(n10448) );
  NAND2_X1 U10766 ( .A1(n10442), .A2(n10441), .ZN(n10449) );
  INV_X1 U10767 ( .A(n10449), .ZN(n10443) );
  NOR2_X1 U10768 ( .A1(n10448), .A2(n10443), .ZN(n10445) );
  AOI21_X1 U10769 ( .B1(\DTP/NPC[14] ), .B2(n10445), .A(n10601), .ZN(n10444)
         );
  OAI21_X1 U10770 ( .B1(\DTP/NPC[14] ), .B2(n10445), .A(n10444), .ZN(n10446)
         );
  OAI211_X1 U10771 ( .C1(n10162), .C2(n10325), .A(n10447), .B(n10446), .ZN(
        \DTP/PC/N17 ) );
  AOI21_X1 U10772 ( .B1(\DTP/NPC[14] ), .B2(n10449), .A(n10448), .ZN(n10452)
         );
  OAI21_X1 U10773 ( .B1(n10452), .B2(n10601), .A(n10538), .ZN(n10450) );
  AOI22_X1 U10774 ( .A1(n10154), .A2(n10603), .B1(\DTP/NPC[15] ), .B2(n10450), 
        .ZN(n10454) );
  INV_X1 U10775 ( .A(\DTP/NPC[15] ), .ZN(n10451) );
  NAND2_X1 U10776 ( .A1(n10452), .A2(n10451), .ZN(n10460) );
  INV_X1 U10777 ( .A(n10460), .ZN(n10457) );
  NAND2_X1 U10778 ( .A1(n10543), .A2(n10457), .ZN(n10453) );
  OAI211_X1 U10779 ( .C1(n10164), .C2(n10606), .A(n10454), .B(n10453), .ZN(
        \DTP/PC/N18 ) );
  AOI21_X1 U10780 ( .B1(n10067), .B2(n10456), .A(n10455), .ZN(n10230) );
  OAI21_X1 U10781 ( .B1(n10457), .B2(n10601), .A(n10538), .ZN(n10461) );
  AOI22_X1 U10782 ( .A1(n9315), .A2(n10603), .B1(n10230), .B2(n10461), .ZN(
        n10459) );
  OR3_X1 U10783 ( .A1(n10460), .A2(n10601), .A3(n10230), .ZN(n10458) );
  OAI211_X1 U10784 ( .C1(n10165), .C2(n10606), .A(n10459), .B(n10458), .ZN(
        \DTP/PC/N19 ) );
  NAND3_X1 U10785 ( .A1(Rst), .A2(n10166), .A3(n10294), .ZN(\DTP/PC/N2 ) );
  AOI22_X1 U10786 ( .A1(n10324), .A2(n10467), .B1(n10326), .B2(n10298), .ZN(
        n10463) );
  OAI221_X1 U10787 ( .B1(n10461), .B2(n10230), .C1(n10461), .C2(n10324), .A(
        \DTP/NPC[17] ), .ZN(n10462) );
  OAI211_X1 U10788 ( .C1(n932), .C2(n10524), .A(n10463), .B(n10462), .ZN(
        \DTP/PC/N20 ) );
  AOI21_X1 U10789 ( .B1(n10066), .B2(n10465), .A(n10464), .ZN(n10229) );
  OAI21_X1 U10790 ( .B1(n10467), .B2(n10601), .A(n10538), .ZN(n10470) );
  AOI22_X1 U10791 ( .A1(n10150), .A2(n10603), .B1(n10229), .B2(n10470), .ZN(
        n10469) );
  INV_X1 U10792 ( .A(n10229), .ZN(n10466) );
  NAND2_X1 U10793 ( .A1(n10467), .A2(n10466), .ZN(n10479) );
  NOR2_X1 U10794 ( .A1(n10601), .A2(n10479), .ZN(n10472) );
  INV_X1 U10795 ( .A(n10472), .ZN(n10468) );
  OAI211_X1 U10796 ( .C1(n10088), .C2(n10606), .A(n10469), .B(n10468), .ZN(
        \DTP/PC/N21 ) );
  AOI21_X1 U10797 ( .B1(n10324), .B2(n10229), .A(n10470), .ZN(n10476) );
  INV_X1 U10798 ( .A(\DTP/NPC[19] ), .ZN(n10477) );
  OAI22_X1 U10799 ( .A1(n934), .A2(n10524), .B1(n10169), .B2(n10325), .ZN(
        n10471) );
  AOI21_X1 U10800 ( .B1(n10472), .B2(n10477), .A(n10471), .ZN(n10473) );
  OAI21_X1 U10801 ( .B1(n10476), .B2(n10477), .A(n10473), .ZN(\DTP/PC/N22 ) );
  AOI21_X1 U10802 ( .B1(n10065), .B2(n10475), .A(n10474), .ZN(n10228) );
  OAI21_X1 U10803 ( .B1(n10601), .B2(n10477), .A(n10476), .ZN(n10478) );
  AOI22_X1 U10804 ( .A1(n10228), .A2(n10478), .B1(n10326), .B2(n10299), .ZN(
        n10480) );
  NAND2_X1 U10805 ( .A1(n10543), .A2(n10320), .ZN(n10483) );
  OAI211_X1 U10806 ( .C1(n935), .C2(n10524), .A(n10480), .B(n10483), .ZN(
        \DTP/PC/N23 ) );
  OAI21_X1 U10807 ( .B1(n10320), .B2(n10601), .A(n10538), .ZN(n10485) );
  OAI22_X1 U10808 ( .A1(n936), .A2(n10524), .B1(n10217), .B2(n10325), .ZN(
        n10481) );
  AOI21_X1 U10809 ( .B1(n10485), .B2(\DTP/NPC[21] ), .A(n10481), .ZN(n10482)
         );
  OAI21_X1 U10810 ( .B1(\DTP/NPC[21] ), .B2(n10483), .A(n10482), .ZN(
        \DTP/PC/N24 ) );
  AOI21_X1 U10811 ( .B1(n10324), .B2(\DTP/NPC[21] ), .A(n10485), .ZN(n10486)
         );
  INV_X1 U10812 ( .A(n10227), .ZN(n10487) );
  OAI22_X1 U10813 ( .A1(n10216), .A2(n10606), .B1(n10486), .B2(n10487), .ZN(
        n10488) );
  NOR2_X1 U10814 ( .A1(n10601), .A2(n10499), .ZN(n10493) );
  NOR2_X1 U10815 ( .A1(n10488), .A2(n10493), .ZN(n10489) );
  OAI21_X1 U10816 ( .B1(n10215), .B2(n10524), .A(n10489), .ZN(\DTP/PC/N25 ) );
  INV_X1 U10817 ( .A(\DTP/NPC[23] ), .ZN(n10492) );
  AOI21_X1 U10818 ( .B1(n10499), .B2(n10324), .A(n10541), .ZN(n10490) );
  OAI22_X1 U10819 ( .A1(n10492), .A2(n10490), .B1(n10325), .B2(n10214), .ZN(
        n10491) );
  INV_X1 U10820 ( .A(n10491), .ZN(n10494) );
  NAND2_X1 U10821 ( .A1(n10493), .A2(n10492), .ZN(n10496) );
  OAI211_X1 U10822 ( .C1(n10213), .C2(n10524), .A(n10494), .B(n10496), .ZN(
        \DTP/PC/N26 ) );
  INV_X1 U10823 ( .A(n10226), .ZN(n10600) );
  AOI22_X1 U10824 ( .A1(n10151), .A2(n10603), .B1(n10326), .B2(n10300), .ZN(
        n10495) );
  OAI221_X1 U10825 ( .B1(n10226), .B2(n10496), .C1(n10600), .C2(n10599), .A(
        n10495), .ZN(\DTP/PC/N27 ) );
  AOI21_X1 U10826 ( .B1(n10062), .B2(n10498), .A(n10497), .ZN(n10225) );
  NAND2_X1 U10827 ( .A1(n10324), .A2(n10505), .ZN(n10604) );
  OAI21_X1 U10828 ( .B1(n10505), .B2(n10601), .A(n10538), .ZN(n10506) );
  OAI22_X1 U10829 ( .A1(n10146), .A2(n10524), .B1(n10089), .B2(n10325), .ZN(
        n10500) );
  AOI21_X1 U10830 ( .B1(n10506), .B2(n10225), .A(n10500), .ZN(n10501) );
  OAI21_X1 U10831 ( .B1(n10225), .B2(n10604), .A(n10501), .ZN(\DTP/PC/N29 ) );
  NAND2_X1 U10832 ( .A1(IR[0]), .A2(n10323), .ZN(\intadd_0/CI ) );
  OAI21_X1 U10833 ( .B1(IR[0]), .B2(n10601), .A(n10538), .ZN(n10502) );
  AOI22_X1 U10834 ( .A1(n10175), .A2(n10603), .B1(n10323), .B2(n10502), .ZN(
        n10504) );
  NAND3_X1 U10835 ( .A1(n10324), .A2(IR[0]), .A3(n10174), .ZN(n10503) );
  OAI211_X1 U10836 ( .C1(n10173), .C2(n10325), .A(n10504), .B(n10503), .ZN(
        \DTP/PC/N3 ) );
  AOI22_X1 U10837 ( .A1(n10324), .A2(n10510), .B1(n10326), .B2(n10301), .ZN(
        n10508) );
  OAI221_X1 U10838 ( .B1(n10506), .B2(n10543), .C1(n10506), .C2(n10225), .A(
        \DTP/NPC[27] ), .ZN(n10507) );
  OAI211_X1 U10839 ( .C1(n10147), .C2(n10524), .A(n10508), .B(n10507), .ZN(
        \DTP/PC/N30 ) );
  OAI21_X1 U10840 ( .B1(n10510), .B2(n10601), .A(n10538), .ZN(n10513) );
  INV_X1 U10841 ( .A(\DTP/NPC[28] ), .ZN(n10509) );
  NAND2_X1 U10842 ( .A1(n10510), .A2(n10509), .ZN(n10521) );
  NOR2_X1 U10843 ( .A1(n10601), .A2(n10521), .ZN(n10515) );
  OAI22_X1 U10844 ( .A1(n939), .A2(n10524), .B1(n10176), .B2(n10325), .ZN(
        n10511) );
  AOI211_X1 U10845 ( .C1(\DTP/NPC[28] ), .C2(n10513), .A(n10515), .B(n10511), 
        .ZN(n10512) );
  AOI21_X1 U10846 ( .B1(n10543), .B2(\DTP/NPC[28] ), .A(n10513), .ZN(n10518)
         );
  INV_X1 U10847 ( .A(\DTP/NPC[29] ), .ZN(n10519) );
  OAI22_X1 U10848 ( .A1(n10148), .A2(n10524), .B1(n10177), .B2(n10325), .ZN(
        n10514) );
  AOI21_X1 U10849 ( .B1(n10515), .B2(n10519), .A(n10514), .ZN(n10516) );
  OAI21_X1 U10850 ( .B1(n10518), .B2(n10519), .A(n10516), .ZN(\DTP/PC/N32 ) );
  XNOR2_X1 U10851 ( .A(n10074), .B(n10517), .ZN(n10224) );
  OAI21_X1 U10852 ( .B1(n10601), .B2(n10519), .A(n10518), .ZN(n10520) );
  AOI22_X1 U10853 ( .A1(n10315), .A2(n10314), .B1(n10313), .B2(n10312), .ZN(
        n10522) );
  NOR3_X1 U10854 ( .A1(n10224), .A2(\DTP/NPC[29] ), .A3(n10521), .ZN(n10523)
         );
  NAND2_X1 U10855 ( .A1(n10543), .A2(n10523), .ZN(n10528) );
  OAI211_X1 U10856 ( .C1(n10317), .C2(n10316), .A(n10522), .B(n10306), .ZN(
        \DTP/PC/N33 ) );
  OAI21_X1 U10857 ( .B1(n10523), .B2(n10601), .A(n10538), .ZN(n10526) );
  OAI22_X1 U10858 ( .A1(n10149), .A2(n10524), .B1(n10091), .B2(n10325), .ZN(
        n10525) );
  AOI21_X1 U10859 ( .B1(n10311), .B2(n10305), .A(n10310), .ZN(n10527) );
  OAI21_X1 U10860 ( .B1(n10305), .B2(n10306), .A(n10527), .ZN(\DTP/PC/N34 ) );
  AOI22_X1 U10861 ( .A1(n10139), .A2(n10603), .B1(n10541), .B2(n10105), .ZN(
        n10530) );
  OR2_X1 U10862 ( .A1(n10054), .A2(n10606), .ZN(n10529) );
  OAI211_X1 U10863 ( .C1(\intadd_0/SUM[0] ), .C2(n10601), .A(n10530), .B(
        n10529), .ZN(\DTP/PC/N4 ) );
  OAI22_X1 U10864 ( .A1(n10092), .A2(n10325), .B1(n10538), .B2(PC[0]), .ZN(
        n10531) );
  AOI21_X1 U10865 ( .B1(n10141), .B2(n10603), .A(n10531), .ZN(n10532) );
  OAI21_X1 U10866 ( .B1(\intadd_0/SUM[1] ), .B2(n10601), .A(n10532), .ZN(
        \DTP/PC/N5 ) );
  NOR2_X1 U10867 ( .A1(n10073), .A2(n10178), .ZN(n10535) );
  AOI21_X1 U10868 ( .B1(n10178), .B2(n10073), .A(n10535), .ZN(n10233) );
  INV_X1 U10869 ( .A(n10233), .ZN(n9737) );
  OAI22_X1 U10870 ( .A1(n10055), .A2(n10325), .B1(n10538), .B2(n9737), .ZN(
        n10533) );
  AOI21_X1 U10871 ( .B1(n10140), .B2(n10603), .A(n10533), .ZN(n10534) );
  OAI21_X1 U10872 ( .B1(\intadd_0/SUM[2] ), .B2(n10601), .A(n10534), .ZN(
        \DTP/PC/N6 ) );
  OAI21_X1 U10873 ( .B1(PC[2]), .B2(n10535), .A(n10322), .ZN(n9736) );
  OAI22_X1 U10874 ( .A1(n10056), .A2(n10325), .B1(n10538), .B2(n9736), .ZN(
        n10536) );
  AOI21_X1 U10875 ( .B1(n10143), .B2(n10603), .A(n10536), .ZN(n10537) );
  OAI21_X1 U10876 ( .B1(\intadd_0/SUM[3] ), .B2(n10601), .A(n10537), .ZN(
        \DTP/PC/N7 ) );
  INV_X1 U10877 ( .A(\DTP/NPC[5] ), .ZN(n9764) );
  OAI22_X1 U10878 ( .A1(n10057), .A2(n10325), .B1(n10538), .B2(n9764), .ZN(
        n10539) );
  AOI21_X1 U10879 ( .B1(n10142), .B2(n10603), .A(n10539), .ZN(n10540) );
  OAI21_X1 U10880 ( .B1(\intadd_0/SUM[4] ), .B2(n10601), .A(n10540), .ZN(
        \DTP/PC/N8 ) );
  NAND3_X1 U10881 ( .A1(n10181), .A2(n10180), .A3(n10179), .ZN(n10544) );
  NOR3_X1 U10882 ( .A1(n10302), .A2(n10280), .A3(n10544), .ZN(n10549) );
  AOI21_X1 U10883 ( .B1(n9300), .B2(n10550), .A(n10549), .ZN(n10545) );
  AOI221_X1 U10884 ( .B1(n10184), .B2(n10545), .C1(n10550), .C2(n10545), .A(
        n10327), .ZN(\DTP/RDreg1/N2 ) );
  AOI21_X1 U10885 ( .B1(n10186), .B2(n10550), .A(n10549), .ZN(n10546) );
  AOI221_X1 U10886 ( .B1(n10185), .B2(n10546), .C1(n10550), .C2(n10546), .A(
        n10328), .ZN(\DTP/RDreg1/N3 ) );
  AOI21_X1 U10887 ( .B1(n10283), .B2(n10550), .A(n10549), .ZN(n10547) );
  AOI221_X1 U10888 ( .B1(n10187), .B2(n10547), .C1(n10550), .C2(n10547), .A(
        n10327), .ZN(\DTP/RDreg1/N4 ) );
  AOI21_X1 U10889 ( .B1(n10190), .B2(n10550), .A(n10549), .ZN(n10548) );
  AOI221_X1 U10890 ( .B1(n10189), .B2(n10548), .C1(n10550), .C2(n10548), .A(
        n10328), .ZN(\DTP/RDreg1/N5 ) );
  AOI21_X1 U10891 ( .B1(n10192), .B2(n10550), .A(n10549), .ZN(n10551) );
  AOI221_X1 U10892 ( .B1(n10191), .B2(n10551), .C1(n10550), .C2(n10551), .A(
        n10327), .ZN(\DTP/RDreg1/N6 ) );
  NOR2_X1 U10893 ( .A1(n10281), .A2(n10327), .ZN(\DTP/RDreg2/N2 ) );
  NOR2_X1 U10894 ( .A1(n10285), .A2(n10328), .ZN(\DTP/RDreg2/N3 ) );
  NOR2_X1 U10895 ( .A1(n9298), .A2(n10327), .ZN(\DTP/RDreg2/N4 ) );
  AND2_X1 U10896 ( .A1(n9308), .A2(Rst), .ZN(\DTP/RDreg2/N5 ) );
  NOR2_X1 U10897 ( .A1(n10193), .A2(n10329), .ZN(\DTP/RDreg2/N6 ) );
  NAND2_X1 U10898 ( .A1(n10194), .A2(n9345), .ZN(n10598) );
  NAND2_X1 U10899 ( .A1(n9334), .A2(n10609), .ZN(n10608) );
  NAND2_X1 U10900 ( .A1(n10199), .A2(n10555), .ZN(n10554) );
  NAND2_X1 U10901 ( .A1(n9335), .A2(n10557), .ZN(n10556) );
  NAND2_X1 U10902 ( .A1(n10564), .A2(n10079), .ZN(n10565) );
  NOR2_X1 U10903 ( .A1(n10206), .A2(n10565), .ZN(n10567) );
  NAND2_X1 U10904 ( .A1(n10567), .A2(n10080), .ZN(n10566) );
  NAND2_X1 U10905 ( .A1(n9336), .A2(n10569), .ZN(n10568) );
  NAND2_X1 U10906 ( .A1(n10203), .A2(n10570), .ZN(n10571) );
  NOR2_X1 U10907 ( .A1(n10081), .A2(n10571), .ZN(n10573) );
  NAND2_X1 U10908 ( .A1(n10573), .A2(n10204), .ZN(n10572) );
  NAND2_X1 U10909 ( .A1(n9333), .A2(n10575), .ZN(n10574) );
  INV_X1 U10910 ( .A(n10574), .ZN(n10576) );
  NAND2_X1 U10911 ( .A1(n10207), .A2(n10576), .ZN(n10577) );
  NOR3_X1 U10912 ( .A1(n10082), .A2(n10577), .A3(n10297), .ZN(n10595) );
  NAND2_X1 U10913 ( .A1(n10595), .A2(n10292), .ZN(\DTP/cnt/N1 ) );
  XNOR2_X1 U10914 ( .A(n10085), .B(n10584), .ZN(\DTP/cnt/N10 ) );
  OAI21_X1 U10915 ( .B1(n10198), .B2(n10552), .A(n10553), .ZN(\DTP/cnt/N11 )
         );
  XNOR2_X1 U10916 ( .A(n10076), .B(n10553), .ZN(\DTP/cnt/N12 ) );
  OAI21_X1 U10917 ( .B1(n10199), .B2(n10555), .A(n10554), .ZN(\DTP/cnt/N13 )
         );
  OAI21_X1 U10918 ( .B1(n9335), .B2(n10557), .A(n10556), .ZN(\DTP/cnt/N14 ) );
  OAI21_X1 U10919 ( .B1(n10200), .B2(n10558), .A(n10559), .ZN(\DTP/cnt/N15 )
         );
  XNOR2_X1 U10920 ( .A(n10077), .B(n10559), .ZN(\DTP/cnt/N16 ) );
  OAI21_X1 U10921 ( .B1(n10201), .B2(n10560), .A(n10561), .ZN(\DTP/cnt/N17 )
         );
  XNOR2_X1 U10922 ( .A(n10078), .B(n10561), .ZN(\DTP/cnt/N18 ) );
  OAI21_X1 U10923 ( .B1(n10202), .B2(n10562), .A(n10563), .ZN(\DTP/cnt/N19 )
         );
  XNOR2_X1 U10924 ( .A(n10205), .B(n10563), .ZN(\DTP/cnt/N20 ) );
  OAI21_X1 U10925 ( .B1(n10564), .B2(n10079), .A(n10565), .ZN(\DTP/cnt/N21 )
         );
  XNOR2_X1 U10926 ( .A(n10206), .B(n10565), .ZN(\DTP/cnt/N22 ) );
  OAI21_X1 U10927 ( .B1(n10567), .B2(n10080), .A(n10566), .ZN(\DTP/cnt/N23 )
         );
  OAI21_X1 U10928 ( .B1(n9336), .B2(n10569), .A(n10568), .ZN(\DTP/cnt/N24 ) );
  OAI21_X1 U10929 ( .B1(n10203), .B2(n10570), .A(n10571), .ZN(\DTP/cnt/N25 )
         );
  XNOR2_X1 U10930 ( .A(n10081), .B(n10571), .ZN(\DTP/cnt/N26 ) );
  OAI21_X1 U10931 ( .B1(n10573), .B2(n10204), .A(n10572), .ZN(\DTP/cnt/N27 )
         );
  OAI21_X1 U10932 ( .B1(n9333), .B2(n10575), .A(n10574), .ZN(\DTP/cnt/N28 ) );
  OAI21_X1 U10933 ( .B1(n10207), .B2(n10576), .A(n10577), .ZN(\DTP/cnt/N29 )
         );
  XNOR2_X1 U10934 ( .A(n10082), .B(n10577), .ZN(\DTP/cnt/N30 ) );
  NOR2_X1 U10935 ( .A1(n10082), .A2(n10577), .ZN(n10579) );
  INV_X1 U10936 ( .A(n10595), .ZN(n10578) );
  OAI21_X1 U10937 ( .B1(n10579), .B2(n10208), .A(n10578), .ZN(\DTP/cnt/N31 )
         );
  OAI21_X1 U10938 ( .B1(n10595), .B2(n10292), .A(\DTP/cnt/N1 ), .ZN(
        \DTP/cnt/N32 ) );
  OAI21_X1 U10939 ( .B1(n10580), .B2(n10195), .A(n10581), .ZN(\DTP/cnt/N5 ) );
  XNOR2_X1 U10940 ( .A(n10083), .B(n10581), .ZN(\DTP/cnt/N6 ) );
  OAI21_X1 U10941 ( .B1(n10196), .B2(n10582), .A(n10583), .ZN(\DTP/cnt/N7 ) );
  XNOR2_X1 U10942 ( .A(n10084), .B(n10583), .ZN(\DTP/cnt/N8 ) );
  OAI21_X1 U10943 ( .B1(n10197), .B2(n10585), .A(n10584), .ZN(\DTP/cnt/N9 ) );
  AND4_X1 U10944 ( .A1(n9336), .A2(n10202), .A3(n9333), .A4(n10208), .ZN(
        n10586) );
  AND4_X1 U10945 ( .A1(n9334), .A2(n10194), .A3(n10207), .A4(n10586), .ZN(
        n10593) );
  NAND4_X1 U10946 ( .A1(n10198), .A2(n10197), .A3(n10196), .A4(n10195), .ZN(
        n10591) );
  NOR4_X1 U10947 ( .A1(n10206), .A2(n10205), .A3(n10078), .A4(n9345), .ZN(
        n10589) );
  NOR4_X1 U10948 ( .A1(n10077), .A2(n10076), .A3(n10085), .A4(n10084), .ZN(
        n10588) );
  AND4_X1 U10949 ( .A1(n10201), .A2(n10200), .A3(n9335), .A4(n10199), .ZN(
        n10587) );
  NAND3_X1 U10950 ( .A1(n10589), .A2(n10588), .A3(n10587), .ZN(n10590) );
  NOR4_X1 U10951 ( .A1(\DTP/cnt/N6 ), .A2(\DTP/cnt/N21 ), .A3(n10591), .A4(
        n10590), .ZN(n10592) );
  NAND4_X1 U10952 ( .A1(n10203), .A2(n10204), .A3(n10593), .A4(n10592), .ZN(
        n10594) );
  NOR4_X1 U10953 ( .A1(\DTP/cnt/N26 ), .A2(\DTP/cnt/N23 ), .A3(\DTP/cnt/N30 ), 
        .A4(n10594), .ZN(n10596) );
  OAI21_X1 U10954 ( .B1(n10596), .B2(n10595), .A(n10292), .ZN(\DTP/cnt/N94 )
         );
  NOR2_X1 U10955 ( .A1(IR[15]), .A2(n10328), .ZN(\DTP/forward_branchREG1/N2 )
         );
  NOR2_X1 U10956 ( .A1(n10210), .A2(n10328), .ZN(\DTP/forward_branchREG2/N2 )
         );
  OR2_X1 U10957 ( .A1(n10597), .A2(n10329), .ZN(n9284) );
  OAI21_X1 U10958 ( .B1(n10194), .B2(n9345), .A(n10598), .ZN(n10222) );
  OAI21_X1 U10959 ( .B1(n10601), .B2(n10600), .A(n10599), .ZN(n10602) );
  AOI22_X1 U10960 ( .A1(n10172), .A2(n10603), .B1(\DTP/NPC[25] ), .B2(n10602), 
        .ZN(n10605) );
  OAI211_X1 U10961 ( .C1(n10059), .C2(n10325), .A(n10605), .B(n10604), .ZN(
        n10221) );
  INV_X1 U10962 ( .A(IR[1]), .ZN(n9794) );
  INV_X1 U10963 ( .A(IR[2]), .ZN(n9793) );
  INV_X1 U10964 ( .A(IR[3]), .ZN(n9792) );
  INV_X1 U10965 ( .A(IR[4]), .ZN(n9791) );
  INV_X1 U10966 ( .A(IR[5]), .ZN(n9790) );
  INV_X1 U10967 ( .A(n10607), .ZN(n9780) );
  OAI21_X1 U10968 ( .B1(n9334), .B2(n10609), .A(n10608), .ZN(n9724) );
endmodule

