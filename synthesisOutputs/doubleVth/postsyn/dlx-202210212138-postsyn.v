
module SNPS_CLOCK_GATE_HIGH_dlx_1 ( CLK, EN, ENCLK );
  input CLK, EN;
  output ENCLK;
  wire   net7412, net7414, net7415, net7418;
  assign net7412 = CLK;
  assign ENCLK = net7414;
  assign net7415 = EN;

  HS65_LL_AND2X4 main_gate ( .A(net7418), .B(net7412), .Z(net7414) );
  HS65_LL_LDLQX9 latch ( .D(net7415), .GN(net7412), .Q(net7418) );
endmodule


module SNPS_CLOCK_GATE_HIGH_dlx_2 ( CLK, EN, ENCLK );
  input CLK, EN;
  output ENCLK;
  wire   net7412, net7414, net7415, net7418;
  assign net7412 = CLK;
  assign ENCLK = net7414;
  assign net7415 = EN;

  HS65_LL_AND2X4 main_gate ( .A(net7418), .B(net7412), .Z(net7414) );
  HS65_LL_LDLQX9 latch ( .D(net7415), .GN(net7412), .Q(net7418) );
endmodule


module dlx ( Clk, Rst, IR, PC );
  input [31:0] IR;
  output [31:0] PC;
  input Clk, Rst;
  wire   \DTP/FWD_exe_branch1 , \DTP/BRANCH_op1 , \DTP/JAL_op1 ,
         \DTP/bootstrap , \DTP/JR_op1 , \DTP/forward_branch2 ,
         \DTP/forward_branch1 , \DTP/NPC[0] , \DTP/NPC[3] , \DTP/NPC[4] ,
         \DTP/NPC[5] , \DTP/NPC[6] , \DTP/NPC[7] , \DTP/NPC[8] , \DTP/NPC[9] ,
         \DTP/NPC[10] , \DTP/NPC[11] , \DTP/NPC[12] , \DTP/NPC[13] ,
         \DTP/NPC[14] , \DTP/NPC[15] , \DTP/NPC[16] , \DTP/NPC[17] ,
         \DTP/NPC[18] , \DTP/NPC[19] , \DTP/NPC[20] , \DTP/NPC[21] ,
         \DTP/NPC[22] , \DTP/NPC[23] , \DTP/NPC[24] , \DTP/NPC[25] ,
         \DTP/NPC[26] , \DTP/NPC[27] , \DTP/NPC[28] , \DTP/NPC[29] ,
         \DTP/NPC[30] , \DTP/NPC[31] , \DTP/ALU_reg_out[0] ,
         \DTP/ALU_reg_out[1] , \DTP/ALU_reg_out[2] , \DTP/ALU_reg_out[3] ,
         \DTP/ALU_reg_out[4] , \DTP/ALU_reg_out[5] , \DTP/ALU_reg_out[6] ,
         \DTP/ALU_reg_out[7] , \DTP/ALU_reg_out[8] , \DTP/ALU_reg_out[9] ,
         \DTP/ALU_reg_out[10] , \DTP/ALU_reg_out[11] , \DTP/ALU_reg_out[12] ,
         \DTP/ALU_reg_out[13] , \DTP/ALU_reg_out[14] , \DTP/ALU_reg_out[15] ,
         \DTP/ALU_reg_out[16] , \DTP/ALU_reg_out[19] , \DTP/ALU_reg_out[20] ,
         \DTP/ALU_reg_out[21] , \DTP/ALU_reg_out[23] , \DTP/ALU_reg_out[26] ,
         \DTP/ALU_reg_out[28] , \DTP/ALU_reg_out[29] , \DTP/ALU_reg_out[30] ,
         \DTP/JAL_op2 , \DTP/NPC2[0] , \DTP/NPC2[1] , \DTP/NPC2[2] ,
         \DTP/NPC2[3] , \DTP/NPC2[4] , \DTP/NPC2[5] , \DTP/NPC2[6] ,
         \DTP/NPC2[7] , \DTP/NPC2[8] , \DTP/NPC2[9] , \DTP/NPC2[10] ,
         \DTP/NPC2[11] , \DTP/NPC2[12] , \DTP/NPC2[13] , \DTP/NPC2[14] ,
         \DTP/NPC2[15] , \DTP/NPC2[16] , \DTP/NPC2[17] , \DTP/NPC2[18] ,
         \DTP/NPC2[19] , \DTP/NPC2[20] , \DTP/NPC2[21] , \DTP/NPC2[22] ,
         \DTP/NPC2[23] , \DTP/NPC2[24] , \DTP/NPC2[25] , \DTP/NPC2[26] ,
         \DTP/NPC2[27] , \DTP/NPC2[28] , \DTP/NPC2[29] , \DTP/NPC2[30] ,
         \DTP/NPC2[31] , \DTP/RD2[0] , \DTP/RD2[2] , \DTP/RD1[0] ,
         \DTP/Instr_reg_out[29] , \DTP/Instr_reg_out[30] ,
         \DTP/Instr_reg_out[31] , \DTP/PC_enable1 , \DTP/RDreg1/N6 ,
         \DTP/RDreg1/N5 , \DTP/RDreg1/N4 , \DTP/RDreg1/N3 , \DTP/RDreg1/N2 ,
         \DTP/RDreg2/N6 , \DTP/RDreg2/N5 , \DTP/RDreg2/N4 , \DTP/RDreg2/N3 ,
         \DTP/RDreg2/N2 , \DTP/PC/N34 , \DTP/PC/N33 , \DTP/PC/N32 ,
         \DTP/PC/N31 , \DTP/PC/N30 , \DTP/PC/N29 , \DTP/PC/N28 , \DTP/PC/N27 ,
         \DTP/PC/N26 , \DTP/PC/N25 , \DTP/PC/N24 , \DTP/PC/N23 , \DTP/PC/N22 ,
         \DTP/PC/N21 , \DTP/PC/N20 , \DTP/PC/N19 , \DTP/PC/N18 , \DTP/PC/N17 ,
         \DTP/PC/N16 , \DTP/PC/N15 , \DTP/PC/N14 , \DTP/PC/N13 , \DTP/PC/N12 ,
         \DTP/PC/N11 , \DTP/PC/N10 , \DTP/PC/N9 , \DTP/PC/N8 , \DTP/PC/N7 ,
         \DTP/PC/N6 , \DTP/PC/N5 , \DTP/PC/N4 , \DTP/PC/N3 , \DTP/PC/N2 ,
         \DTP/IR/N33 , \DTP/IR/N32 , \DTP/IR/N31 , \DTP/IR/N30 , \DTP/IR/N29 ,
         \DTP/IR/N28 , \DTP/IR/N27 , \DTP/IR/N26 , \DTP/IR/N25 , \DTP/IR/N24 ,
         \DTP/IR/N23 , \DTP/IR/N22 , \DTP/IR/N21 , \DTP/IR/N20 , \DTP/IR/N19 ,
         \DTP/IR/N18 , \DTP/IR/N17 , \DTP/IR/N16 , \DTP/IR/N15 , \DTP/IR/N14 ,
         \DTP/IR/N13 , \DTP/ALU_REG/N33 , \DTP/ALU_REG/N32 , \DTP/ALU_REG/N31 ,
         \DTP/ALU_REG/N30 , \DTP/ALU_REG/N29 , \DTP/ALU_REG/N28 ,
         \DTP/ALU_REG/N27 , \DTP/ALU_REG/N26 , \DTP/ALU_REG/N25 ,
         \DTP/ALU_REG/N24 , \DTP/ALU_REG/N23 , \DTP/ALU_REG/N22 ,
         \DTP/ALU_REG/N21 , \DTP/ALU_REG/N20 , \DTP/ALU_REG/N19 ,
         \DTP/ALU_REG/N18 , \DTP/ALU_REG/N17 , \DTP/ALU_REG/N16 ,
         \DTP/ALU_REG/N15 , \DTP/ALU_REG/N14 , \DTP/ALU_REG/N13 ,
         \DTP/ALU_REG/N12 , \DTP/ALU_REG/N11 , \DTP/ALU_REG/N10 ,
         \DTP/ALU_REG/N9 , \DTP/ALU_REG/N8 , \DTP/ALU_REG/N7 ,
         \DTP/ALU_REG/N6 , \DTP/ALU_REG/N5 , \DTP/ALU_REG/N4 ,
         \DTP/ALU_REG/N3 , \DTP/ALU_REG/N2 , \DTP/ALUWB/N31 , \DTP/ALUWB/N30 ,
         \DTP/ALUWB/N29 , \DTP/ALUWB/N28 , \DTP/ALUWB/N27 , \DTP/ALUWB/N26 ,
         \DTP/ALUWB/N25 , \DTP/ALUWB/N24 , \DTP/ALUWB/N23 , \DTP/ALUWB/N22 ,
         \DTP/ALUWB/N21 , \DTP/ALUWB/N20 , \DTP/ALUWB/N19 , \DTP/ALUWB/N18 ,
         \DTP/ALUWB/N16 , \DTP/ALUWB/N15 , \DTP/ALUWB/N14 , \DTP/ALUWB/N13 ,
         \DTP/ALUWB/N7 , \DTP/ALUWB/N4 , \DTP/ALUWB/N3 , \DTP/NPCreg1/N17 ,
         \DTP/NPCreg1/N9 , \DTP/NPCreg1/N8 , \DTP/NPCreg1/N5 ,
         \DTP/NPCreg1/N4 , \DTP/NPCreg1/N3 , \DTP/NPCreg1/N2 ,
         \DTP/NPCreg2/N33 , \DTP/NPCreg2/N32 , \DTP/NPCreg2/N31 ,
         \DTP/NPCreg2/N30 , \DTP/NPCreg2/N29 , \DTP/NPCreg2/N28 ,
         \DTP/NPCreg2/N27 , \DTP/NPCreg2/N26 , \DTP/NPCreg2/N25 ,
         \DTP/NPCreg2/N24 , \DTP/NPCreg2/N23 , \DTP/NPCreg2/N22 ,
         \DTP/NPCreg2/N21 , \DTP/NPCreg2/N20 , \DTP/NPCreg2/N19 ,
         \DTP/NPCreg2/N18 , \DTP/NPCreg2/N17 , \DTP/NPCreg2/N16 ,
         \DTP/NPCreg2/N15 , \DTP/NPCreg2/N14 , \DTP/NPCreg2/N13 ,
         \DTP/NPCreg2/N12 , \DTP/NPCreg2/N11 , \DTP/NPCreg2/N10 ,
         \DTP/NPCreg2/N9 , \DTP/NPCreg2/N8 , \DTP/NPCreg2/N7 ,
         \DTP/NPCreg2/N6 , \DTP/NPCreg2/N5 , \DTP/NPCreg2/N4 ,
         \DTP/NPCreg2/N3 , \DTP/NPCreg2/N2 , \DTP/NPCreg3/N31 ,
         \DTP/NPCreg3/N30 , \DTP/NPCreg3/N12 , \DTP/NPCreg3/N11 ,
         \DTP/NPCreg3/N10 , \DTP/NPCreg3/N5 , \DTP/NPCreg3/N2 , \DTP/cnt/N94 ,
         \DTP/cnt/N32 , \DTP/cnt/N31 , \DTP/cnt/N30 , \DTP/cnt/N29 ,
         \DTP/cnt/N28 , \DTP/cnt/N27 , \DTP/cnt/N26 , \DTP/cnt/N25 ,
         \DTP/cnt/N24 , \DTP/cnt/N23 , \DTP/cnt/N22 , \DTP/cnt/N21 ,
         \DTP/cnt/N20 , \DTP/cnt/N19 , \DTP/cnt/N18 , \DTP/cnt/N17 ,
         \DTP/cnt/N16 , \DTP/cnt/N15 , \DTP/cnt/N14 , \DTP/cnt/N13 ,
         \DTP/cnt/N12 , \DTP/cnt/N11 , \DTP/cnt/N10 , \DTP/cnt/N9 ,
         \DTP/cnt/N8 , \DTP/cnt/N7 , \DTP/cnt/N6 , \DTP/cnt/N5 , \DTP/cnt/N4 ,
         \DTP/cnt/N2 , \DTP/cnt/N1 , \DTP/cnt/i[0] , \DTP/cnt/i[1] ,
         \DTP/cnt/i[2] , \DTP/cnt/i[3] , \DTP/cnt/i[4] , \DTP/cnt/i[5] ,
         \DTP/cnt/i[6] , \DTP/cnt/i[7] , \DTP/cnt/i[8] , \DTP/cnt/i[9] ,
         \DTP/cnt/i[10] , \DTP/cnt/i[11] , \DTP/cnt/i[12] , \DTP/cnt/i[13] ,
         \DTP/cnt/i[14] , \DTP/cnt/i[15] , \DTP/cnt/i[16] , \DTP/cnt/i[17] ,
         \DTP/cnt/i[18] , \DTP/cnt/i[19] , \DTP/cnt/i[20] , \DTP/cnt/i[21] ,
         \DTP/cnt/i[22] , \DTP/cnt/i[23] , \DTP/cnt/i[24] , \DTP/cnt/i[25] ,
         \DTP/cnt/i[26] , \DTP/cnt/i[27] , \DTP/cnt/i[28] , \DTP/cnt/i[29] ,
         \DTP/cnt/i[30] , \DTP/forward_branchREG1/N2 ,
         \DTP/forward_branchREG2/N2 , \DTP/JALreg1/N2 , \DTP/JALreg2/N2 ,
         \DTP/JRreg1/N2 , \DTP/BRANCH_opREG1/N2 , \DTP/BRANCH_opREG2/N2 ,
         \DTP/LOADREG1/N2 , \DTP/FWDBRANCH1/N2 , \DTP/FWDBRANCH2/N2 , net7824,
         net7829, n65, n66, n68, n69, n70, n72, n74, n79, n80, n82, n83, n85,
         n86, n88, n91, n93, n100, n103, n105, n107, n108, n109, n110, n111,
         n112, n119, n123, n124, n127, n128, n139, n140, n141, n142, n144,
         n145, n146, n148, n149, n150, n151, n152, n153, n154, n155, n156,
         n157, n158, n159, n160, \add_x_320/n28 , \add_x_320/n27 ,
         \add_x_320/n26 , \add_x_320/n25 , \add_x_320/n24 , \add_x_320/n23 ,
         \add_x_320/n22 , \add_x_320/n21 , \add_x_320/n20 , \add_x_320/n19 ,
         \add_x_320/n18 , \add_x_320/n17 , \add_x_320/n16 , \add_x_320/n15 ,
         \add_x_320/n14 , \add_x_320/n13 , \add_x_320/n12 , \add_x_320/n11 ,
         \add_x_320/n10 , \add_x_320/n9 , \add_x_320/n8 , \add_x_320/n7 ,
         \add_x_320/n6 , \add_x_320/n5 , \add_x_320/n4 , \add_x_320/n3 ,
         \add_x_320/n2 , \add_x_320/n1 , \intadd_0/A[2] , \intadd_0/A[1] ,
         \intadd_0/A[0] , \intadd_0/B[2] , \intadd_0/B[0] , \intadd_0/CI ,
         \intadd_0/SUM[2] , \intadd_0/SUM[1] , \intadd_0/SUM[0] ,
         \intadd_0/n3 , \intadd_0/n2 , \intadd_0/n1 , \intadd_1/CI ,
         \intadd_1/SUM[2] , \intadd_1/SUM[1] , \intadd_1/SUM[0] ,
         \intadd_1/n3 , \intadd_1/n2 , \intadd_1/n1 , \sub_x_338/n54 ,
         \sub_x_338/n51 , \sub_x_338/n47 , \sub_x_338/n46 , \sub_x_338/n39 ,
         \sub_x_338/n38 , \sub_x_338/n35 , \sub_x_338/n29 , \sub_x_338/n28 ,
         \sub_x_338/n27 , \sub_x_338/n26 , \sub_x_338/n25 , \sub_x_338/n24 ,
         \sub_x_338/n23 , \sub_x_338/n22 , \sub_x_338/n21 , \sub_x_338/n20 ,
         \sub_x_338/n19 , \sub_x_338/n18 , \sub_x_338/n17 , \sub_x_338/n16 ,
         \sub_x_338/n15 , \sub_x_338/n14 , \sub_x_338/n13 , \sub_x_338/n12 ,
         \sub_x_338/n11 , \sub_x_338/n10 , \sub_x_338/n9 , n7127, n7128, n7129,
         n7130, n7131, n7132, n7133, n7134, n7135, n7136, n7137, n7138, n7139,
         n7140, n7141, n7142, n7143, n7144, n7145, n7146, n7147, n7148, n7149,
         n7150, n7151, n7152, n7153, n7154, n7155, n7156, n7157, n7158, n7159,
         n7160, n7161, n7162, n7163, n7164, n7165, n7166, n7167, n7168, n7169,
         n7170, n7171, n7172, n7173, n7174, n7175, n7176, n7177, n7178, n7179,
         n7180, n7181, n7182, n7183, n7184, n7185, n7186, n7187, n7188, n7189,
         n7190, n7191, n7192, n7193, n7194, n7195, n7196, n7197, n7198, n7199,
         n7200, n7201, n7202, n7203, n7204, n7205, n7206, n7207, n7208, n7209,
         n7210, n7211, n7212, n7213, n7214, n7215, n7216, n7217, n7218, n7219,
         n7220, n7221, n7222, n7223, n7224, n7225, n7226, n7227, n7228, n7229,
         n7230, n7231, n7232, n7233, n7234, n7235, n7236, n7237, n7238, n7239,
         n7240, n7241, n7242, n7243, n7244, n7245, n7246, n7247, n7248, n7249,
         n7250, n7251, n7252, n7253, n7254, n7255, n7256, n7257, n7258, n7259,
         n7260, n7261, n7262, n7263, n7264, n7265, n7266, n7267, n7268, n7269,
         n7270, n7271, n7273, n7274, n7275, n7276, n7277, n7278, n7279, n7280,
         n7281, n7282, n7283, n7284, n7285, n7286, n7287, n7288, n7289, n7290,
         n7291, n7292, n7293, n7294, n7295, n7296, n7297, n7298, n7299, n7300,
         n7301, n7302, n7303, n7304, n7305, n7306, n7307, n7308, n7309, n7310,
         n7311, n7312, n7313, n7314, n7315, n7316, n7317, n7318, n7319, n7320,
         n7321, n7322, n7323, n7324, n7325, n7326, n7327, n7328, n7329, n7330,
         n7331, n7332, n7333, n7334, n7335, n7336, n7337, n7338, n7339, n7340,
         n7341, n7342, n7343, n7344, n7345, n7346, n7347, n7348, n7349, n7350,
         n7351, n7352, n7353, n7354, n7355, n7356, n7357, n7358, n7359, n7360,
         n7361, n7362, n7363, n7364, n7365, n7366, n7367, n7368, n7369, n7370,
         n7371, n7372, n7373, n7374, n7375, n7376, n7377, n7378, n7379, n7380,
         n7381, n7382, n7383, n7384, n7385, n7386, n7387, n7388, n7389, n7390,
         n7391, n7392, n7393, n7394, n7395, n7396, n7397, n7398, n7399, n7400,
         n7401, n7402, n7403, n7404, n7405, n7406, n7407, n7408, n7409, n7410,
         n7411, n7412, n7413, n7414, n7415, n7416, n7417, n7418, n7419, n7420,
         n7421, n7422, n7423, n7424, n7425, n7426, n7427, n7428, n7429, n7430,
         n7431, n7432, n7433, n7434, n7435, n7436, n7437, n7438, n7439, n7440,
         n7441, n7442, n7443, n7444, n7445, n7446, n7447, n7448, n7449, n7450,
         n7451, n7452, n7453, n7454, n7455, n7456, n7457, n7458, n7459, n7460,
         n7461, n7462, n7463, n7464, n7465, n7466, n7467, n7468, n7469, n7470,
         n7471, n7472, n7473, n7474, n7475, n7476, n7477, n7478, n7479, n7480,
         n7481, n7482, n7483, n7484, n7485, n7486, n7487, n7488;
  wire   [31:0] \DTP/NPC1 ;
  wire   [31:0] \DTP/Immediate_26_extended ;
  assign PC[29] = PC[31];
  assign PC[30] = PC[31];

  SNPS_CLOCK_GATE_HIGH_dlx_2 \clk_gate_DTP/PC/d_out_reg  ( .CLK(Clk), .EN(
        \DTP/PC/N2 ), .ENCLK(net7824) );
  SNPS_CLOCK_GATE_HIGH_dlx_1 \clk_gate_DTP/cnt/i_reg  ( .CLK(Clk), .EN(
        \DTP/cnt/N1 ), .ENCLK(net7829) );
  HS65_LL_DFPQX4 \DTP/IR/d_out_reg[11]  ( .D(\DTP/IR/N13 ), .CP(Clk), .Q(
        \DTP/Immediate_26_extended [11]) );
  HS65_LL_DFPQX4 \DTP/IR/d_out_reg[12]  ( .D(\DTP/IR/N14 ), .CP(Clk), .Q(
        \DTP/Immediate_26_extended [12]) );
  HS65_LL_DFPQX4 \DTP/IR/d_out_reg[13]  ( .D(\DTP/IR/N15 ), .CP(Clk), .Q(
        \DTP/Immediate_26_extended [13]) );
  HS65_LL_DFPQX4 \DTP/IR/d_out_reg[14]  ( .D(\DTP/IR/N16 ), .CP(Clk), .Q(
        \DTP/Immediate_26_extended [14]) );
  HS65_LL_DFPQX4 \DTP/IR/d_out_reg[15]  ( .D(\DTP/IR/N17 ), .CP(Clk), .Q(
        \DTP/Immediate_26_extended [15]) );
  HS65_LL_DFPQX4 \DTP/IR/d_out_reg[29]  ( .D(\DTP/IR/N31 ), .CP(Clk), .Q(
        \DTP/Instr_reg_out[29] ) );
  HS65_LL_DFPQX4 \DTP/IR/d_out_reg[30]  ( .D(\DTP/IR/N32 ), .CP(Clk), .Q(
        \DTP/Instr_reg_out[30] ) );
  HS65_LL_DFPQX4 \DTP/IR/d_out_reg[31]  ( .D(\DTP/IR/N33 ), .CP(Clk), .Q(
        \DTP/Instr_reg_out[31] ) );
  HS65_LL_DFPQX4 \DTP/RDreg1/d_out_reg[0]  ( .D(\DTP/RDreg1/N2 ), .CP(Clk), 
        .Q(\DTP/RD1[0] ) );
  HS65_LL_DFPQX4 \DTP/RDreg2/d_out_reg[0]  ( .D(\DTP/RDreg2/N2 ), .CP(Clk), 
        .Q(\DTP/RD2[0] ) );
  HS65_LL_DFPQX4 \DTP/RDreg2/d_out_reg[2]  ( .D(\DTP/RDreg2/N4 ), .CP(Clk), 
        .Q(\DTP/RD2[2] ) );
  HS65_LL_DFPQX4 \DTP/NPCreg1/d_out_reg[0]  ( .D(\DTP/NPCreg1/N2 ), .CP(Clk), 
        .Q(\DTP/NPC1 [0]) );
  HS65_LL_DFPQX4 \DTP/NPCreg1/d_out_reg[3]  ( .D(\DTP/NPCreg1/N5 ), .CP(Clk), 
        .Q(\DTP/NPC1 [3]) );
  HS65_LL_DFPQX4 \DTP/NPCreg1/d_out_reg[4]  ( .D(n7326), .CP(Clk), .Q(
        \DTP/NPC1 [4]) );
  HS65_LL_DFPQX4 \DTP/NPCreg1/d_out_reg[5]  ( .D(n7332), .CP(Clk), .Q(
        \DTP/NPC1 [5]) );
  HS65_LL_DFPQX4 \DTP/NPCreg1/d_out_reg[6]  ( .D(\DTP/NPCreg1/N8 ), .CP(Clk), 
        .Q(\DTP/NPC1 [6]) );
  HS65_LL_DFPQX4 \DTP/NPCreg1/d_out_reg[7]  ( .D(\DTP/NPCreg1/N9 ), .CP(Clk), 
        .Q(\DTP/NPC1 [7]) );
  HS65_LL_DFPQX4 \DTP/NPCreg1/d_out_reg[8]  ( .D(n7327), .CP(Clk), .Q(
        \DTP/NPC1 [8]) );
  HS65_LL_DFPQX4 \DTP/NPCreg1/d_out_reg[9]  ( .D(n7324), .CP(Clk), .Q(
        \DTP/NPC1 [9]) );
  HS65_LL_DFPQX4 \DTP/NPCreg1/d_out_reg[10]  ( .D(n7325), .CP(Clk), .Q(
        \DTP/NPC1 [10]) );
  HS65_LL_DFPQX4 \DTP/NPCreg1/d_out_reg[11]  ( .D(n7345), .CP(Clk), .Q(
        \DTP/NPC1 [11]) );
  HS65_LL_DFPQX4 \DTP/NPCreg1/d_out_reg[12]  ( .D(n7328), .CP(Clk), .Q(
        \DTP/NPC1 [12]) );
  HS65_LL_DFPQX4 \DTP/NPCreg1/d_out_reg[13]  ( .D(n7319), .CP(Clk), .Q(
        \DTP/NPC1 [13]) );
  HS65_LL_DFPQX4 \DTP/NPCreg1/d_out_reg[14]  ( .D(n7329), .CP(Clk), .Q(
        \DTP/NPC1 [14]) );
  HS65_LL_DFPQX4 \DTP/NPCreg1/d_out_reg[15]  ( .D(\DTP/NPCreg1/N17 ), .CP(Clk), 
        .Q(\DTP/NPC1 [15]) );
  HS65_LL_DFPQX4 \DTP/NPCreg1/d_out_reg[16]  ( .D(n7344), .CP(Clk), .Q(
        \DTP/NPC1 [16]) );
  HS65_LL_DFPQX4 \DTP/NPCreg1/d_out_reg[17]  ( .D(n7343), .CP(Clk), .Q(
        \DTP/NPC1 [17]) );
  HS65_LL_DFPQX4 \DTP/NPCreg1/d_out_reg[18]  ( .D(n7342), .CP(Clk), .Q(
        \DTP/NPC1 [18]) );
  HS65_LL_DFPQX4 \DTP/NPCreg1/d_out_reg[19]  ( .D(n7341), .CP(Clk), .Q(
        \DTP/NPC1 [19]) );
  HS65_LL_DFPQX4 \DTP/NPCreg1/d_out_reg[20]  ( .D(n7340), .CP(Clk), .Q(
        \DTP/NPC1 [20]) );
  HS65_LL_DFPQX4 \DTP/NPCreg1/d_out_reg[21]  ( .D(n7339), .CP(Clk), .Q(
        \DTP/NPC1 [21]) );
  HS65_LL_DFPQX4 \DTP/NPCreg1/d_out_reg[22]  ( .D(n7338), .CP(Clk), .Q(
        \DTP/NPC1 [22]) );
  HS65_LL_DFPQX4 \DTP/NPCreg1/d_out_reg[23]  ( .D(n7337), .CP(Clk), .Q(
        \DTP/NPC1 [23]) );
  HS65_LL_DFPQX4 \DTP/NPCreg1/d_out_reg[24]  ( .D(n7336), .CP(Clk), .Q(
        \DTP/NPC1 [24]) );
  HS65_LL_DFPQX4 \DTP/NPCreg1/d_out_reg[25]  ( .D(n7335), .CP(Clk), .Q(
        \DTP/NPC1 [25]) );
  HS65_LL_DFPQX4 \DTP/NPCreg1/d_out_reg[26]  ( .D(n7334), .CP(Clk), .Q(
        \DTP/NPC1 [26]) );
  HS65_LL_DFPQX4 \DTP/NPCreg1/d_out_reg[27]  ( .D(n7333), .CP(Clk), .Q(
        \DTP/NPC1 [27]) );
  HS65_LL_DFPQX4 \DTP/NPCreg1/d_out_reg[28]  ( .D(n7323), .CP(Clk), .Q(
        \DTP/NPC1 [28]) );
  HS65_LL_DFPQX4 \DTP/NPCreg1/d_out_reg[29]  ( .D(n7322), .CP(Clk), .Q(
        \DTP/NPC1 [29]) );
  HS65_LL_DFPQX4 \DTP/NPCreg1/d_out_reg[30]  ( .D(n7321), .CP(Clk), .Q(
        \DTP/NPC1 [30]) );
  HS65_LL_DFPQX4 \DTP/NPCreg1/d_out_reg[31]  ( .D(n7331), .CP(Clk), .Q(
        \DTP/NPC1 [31]) );
  HS65_LL_DFPQX4 \DTP/NPCreg2/d_out_reg[0]  ( .D(\DTP/NPCreg2/N2 ), .CP(Clk), 
        .Q(\DTP/NPC2[0] ) );
  HS65_LL_DFPQX4 \DTP/NPCreg2/d_out_reg[3]  ( .D(\DTP/NPCreg2/N5 ), .CP(Clk), 
        .Q(\DTP/NPC2[3] ) );
  HS65_LL_DFPQX4 \DTP/NPCreg2/d_out_reg[4]  ( .D(\DTP/NPCreg2/N6 ), .CP(Clk), 
        .Q(\DTP/NPC2[4] ) );
  HS65_LL_DFPQX4 \DTP/NPCreg2/d_out_reg[5]  ( .D(\DTP/NPCreg2/N7 ), .CP(Clk), 
        .Q(\DTP/NPC2[5] ) );
  HS65_LL_DFPQX4 \DTP/NPCreg2/d_out_reg[6]  ( .D(\DTP/NPCreg2/N8 ), .CP(Clk), 
        .Q(\DTP/NPC2[6] ) );
  HS65_LL_DFPQX4 \DTP/NPCreg2/d_out_reg[7]  ( .D(\DTP/NPCreg2/N9 ), .CP(Clk), 
        .Q(\DTP/NPC2[7] ) );
  HS65_LL_DFPQX4 \DTP/NPCreg2/d_out_reg[8]  ( .D(\DTP/NPCreg2/N10 ), .CP(Clk), 
        .Q(\DTP/NPC2[8] ) );
  HS65_LL_DFPQX4 \DTP/NPCreg2/d_out_reg[9]  ( .D(\DTP/NPCreg2/N11 ), .CP(Clk), 
        .Q(\DTP/NPC2[9] ) );
  HS65_LL_DFPQX4 \DTP/NPCreg2/d_out_reg[10]  ( .D(\DTP/NPCreg2/N12 ), .CP(Clk), 
        .Q(\DTP/NPC2[10] ) );
  HS65_LL_DFPQX4 \DTP/NPCreg2/d_out_reg[11]  ( .D(\DTP/NPCreg2/N13 ), .CP(Clk), 
        .Q(\DTP/NPC2[11] ) );
  HS65_LL_DFPQX4 \DTP/NPCreg2/d_out_reg[12]  ( .D(\DTP/NPCreg2/N14 ), .CP(Clk), 
        .Q(\DTP/NPC2[12] ) );
  HS65_LL_DFPQX4 \DTP/NPCreg2/d_out_reg[13]  ( .D(\DTP/NPCreg2/N15 ), .CP(Clk), 
        .Q(\DTP/NPC2[13] ) );
  HS65_LL_DFPQX4 \DTP/NPCreg2/d_out_reg[14]  ( .D(\DTP/NPCreg2/N16 ), .CP(Clk), 
        .Q(\DTP/NPC2[14] ) );
  HS65_LL_DFPQX4 \DTP/NPCreg2/d_out_reg[15]  ( .D(\DTP/NPCreg2/N17 ), .CP(Clk), 
        .Q(\DTP/NPC2[15] ) );
  HS65_LL_DFPQX4 \DTP/NPCreg2/d_out_reg[16]  ( .D(\DTP/NPCreg2/N18 ), .CP(Clk), 
        .Q(\DTP/NPC2[16] ) );
  HS65_LL_DFPQX4 \DTP/NPCreg2/d_out_reg[17]  ( .D(\DTP/NPCreg2/N19 ), .CP(Clk), 
        .Q(\DTP/NPC2[17] ) );
  HS65_LL_DFPQX4 \DTP/NPCreg2/d_out_reg[18]  ( .D(\DTP/NPCreg2/N20 ), .CP(Clk), 
        .Q(\DTP/NPC2[18] ) );
  HS65_LL_DFPQX4 \DTP/NPCreg2/d_out_reg[19]  ( .D(\DTP/NPCreg2/N21 ), .CP(Clk), 
        .Q(\DTP/NPC2[19] ) );
  HS65_LL_DFPQX4 \DTP/NPCreg2/d_out_reg[20]  ( .D(\DTP/NPCreg2/N22 ), .CP(Clk), 
        .Q(\DTP/NPC2[20] ) );
  HS65_LL_DFPQX4 \DTP/NPCreg2/d_out_reg[21]  ( .D(\DTP/NPCreg2/N23 ), .CP(Clk), 
        .Q(\DTP/NPC2[21] ) );
  HS65_LL_DFPQX4 \DTP/NPCreg2/d_out_reg[22]  ( .D(\DTP/NPCreg2/N24 ), .CP(Clk), 
        .Q(\DTP/NPC2[22] ) );
  HS65_LL_DFPQX4 \DTP/NPCreg2/d_out_reg[23]  ( .D(\DTP/NPCreg2/N25 ), .CP(Clk), 
        .Q(\DTP/NPC2[23] ) );
  HS65_LL_DFPQX4 \DTP/NPCreg2/d_out_reg[24]  ( .D(\DTP/NPCreg2/N26 ), .CP(Clk), 
        .Q(\DTP/NPC2[24] ) );
  HS65_LL_DFPQX4 \DTP/NPCreg2/d_out_reg[25]  ( .D(\DTP/NPCreg2/N27 ), .CP(Clk), 
        .Q(\DTP/NPC2[25] ) );
  HS65_LL_DFPQX4 \DTP/NPCreg2/d_out_reg[26]  ( .D(\DTP/NPCreg2/N28 ), .CP(Clk), 
        .Q(\DTP/NPC2[26] ) );
  HS65_LL_DFPQX4 \DTP/NPCreg2/d_out_reg[27]  ( .D(\DTP/NPCreg2/N29 ), .CP(Clk), 
        .Q(\DTP/NPC2[27] ) );
  HS65_LL_DFPQX4 \DTP/NPCreg2/d_out_reg[28]  ( .D(\DTP/NPCreg2/N30 ), .CP(Clk), 
        .Q(\DTP/NPC2[28] ) );
  HS65_LL_DFPQX4 \DTP/NPCreg2/d_out_reg[29]  ( .D(\DTP/NPCreg2/N31 ), .CP(Clk), 
        .Q(\DTP/NPC2[29] ) );
  HS65_LL_DFPQX4 \DTP/NPCreg2/d_out_reg[30]  ( .D(\DTP/NPCreg2/N32 ), .CP(Clk), 
        .Q(\DTP/NPC2[30] ) );
  HS65_LL_DFPQX4 \DTP/NPCreg2/d_out_reg[31]  ( .D(\DTP/NPCreg2/N33 ), .CP(Clk), 
        .Q(\DTP/NPC2[31] ) );
  HS65_LL_DFPRQX4 \DTP/cnt/i_reg[0]  ( .D(\DTP/cnt/N2 ), .CP(net7829), .RN(Rst), .Q(\DTP/cnt/i[0] ) );
  HS65_LL_DFPRQX4 \DTP/cnt/i_reg[2]  ( .D(\DTP/cnt/N4 ), .CP(net7829), .RN(Rst), .Q(\DTP/cnt/i[2] ) );
  HS65_LL_DFPRQX4 \DTP/cnt/i_reg[3]  ( .D(\DTP/cnt/N5 ), .CP(net7829), .RN(Rst), .Q(\DTP/cnt/i[3] ) );
  HS65_LL_DFPRQX4 \DTP/cnt/i_reg[4]  ( .D(\DTP/cnt/N6 ), .CP(net7829), .RN(Rst), .Q(\DTP/cnt/i[4] ) );
  HS65_LL_DFPRQX4 \DTP/cnt/i_reg[5]  ( .D(\DTP/cnt/N7 ), .CP(net7829), .RN(Rst), .Q(\DTP/cnt/i[5] ) );
  HS65_LL_DFPRQX4 \DTP/cnt/i_reg[6]  ( .D(\DTP/cnt/N8 ), .CP(net7829), .RN(Rst), .Q(\DTP/cnt/i[6] ) );
  HS65_LL_DFPRQX4 \DTP/cnt/i_reg[7]  ( .D(\DTP/cnt/N9 ), .CP(net7829), .RN(Rst), .Q(\DTP/cnt/i[7] ) );
  HS65_LL_DFPRQX4 \DTP/cnt/i_reg[8]  ( .D(\DTP/cnt/N10 ), .CP(net7829), .RN(
        Rst), .Q(\DTP/cnt/i[8] ) );
  HS65_LL_DFPRQX4 \DTP/cnt/i_reg[9]  ( .D(\DTP/cnt/N11 ), .CP(net7829), .RN(
        Rst), .Q(\DTP/cnt/i[9] ) );
  HS65_LL_DFPRQX4 \DTP/cnt/i_reg[10]  ( .D(\DTP/cnt/N12 ), .CP(net7829), .RN(
        Rst), .Q(\DTP/cnt/i[10] ) );
  HS65_LL_DFPRQX4 \DTP/cnt/i_reg[11]  ( .D(\DTP/cnt/N13 ), .CP(net7829), .RN(
        Rst), .Q(\DTP/cnt/i[11] ) );
  HS65_LL_DFPRQX4 \DTP/cnt/i_reg[12]  ( .D(\DTP/cnt/N14 ), .CP(net7829), .RN(
        Rst), .Q(\DTP/cnt/i[12] ) );
  HS65_LL_DFPRQX4 \DTP/cnt/i_reg[13]  ( .D(\DTP/cnt/N15 ), .CP(net7829), .RN(
        Rst), .Q(\DTP/cnt/i[13] ) );
  HS65_LL_DFPRQX4 \DTP/cnt/i_reg[14]  ( .D(\DTP/cnt/N16 ), .CP(net7829), .RN(
        Rst), .Q(\DTP/cnt/i[14] ) );
  HS65_LL_DFPRQX4 \DTP/cnt/i_reg[15]  ( .D(\DTP/cnt/N17 ), .CP(net7829), .RN(
        Rst), .Q(\DTP/cnt/i[15] ) );
  HS65_LL_DFPRQX4 \DTP/cnt/i_reg[16]  ( .D(\DTP/cnt/N18 ), .CP(net7829), .RN(
        Rst), .Q(\DTP/cnt/i[16] ) );
  HS65_LL_DFPRQX4 \DTP/cnt/i_reg[17]  ( .D(\DTP/cnt/N19 ), .CP(net7829), .RN(
        Rst), .Q(\DTP/cnt/i[17] ) );
  HS65_LL_DFPRQX4 \DTP/cnt/i_reg[18]  ( .D(\DTP/cnt/N20 ), .CP(net7829), .RN(
        Rst), .Q(\DTP/cnt/i[18] ) );
  HS65_LL_DFPRQX4 \DTP/cnt/i_reg[19]  ( .D(\DTP/cnt/N21 ), .CP(net7829), .RN(
        Rst), .Q(\DTP/cnt/i[19] ) );
  HS65_LL_DFPRQX4 \DTP/cnt/i_reg[20]  ( .D(\DTP/cnt/N22 ), .CP(net7829), .RN(
        Rst), .Q(\DTP/cnt/i[20] ) );
  HS65_LL_DFPRQX4 \DTP/cnt/i_reg[21]  ( .D(\DTP/cnt/N23 ), .CP(net7829), .RN(
        Rst), .Q(\DTP/cnt/i[21] ) );
  HS65_LL_DFPRQX4 \DTP/cnt/i_reg[22]  ( .D(\DTP/cnt/N24 ), .CP(net7829), .RN(
        Rst), .Q(\DTP/cnt/i[22] ) );
  HS65_LL_DFPRQX4 \DTP/cnt/i_reg[23]  ( .D(\DTP/cnt/N25 ), .CP(net7829), .RN(
        Rst), .Q(\DTP/cnt/i[23] ) );
  HS65_LL_DFPRQX4 \DTP/cnt/i_reg[24]  ( .D(\DTP/cnt/N26 ), .CP(net7829), .RN(
        Rst), .Q(\DTP/cnt/i[24] ) );
  HS65_LL_DFPRQX4 \DTP/cnt/i_reg[25]  ( .D(\DTP/cnt/N27 ), .CP(net7829), .RN(
        Rst), .Q(\DTP/cnt/i[25] ) );
  HS65_LL_DFPRQX4 \DTP/cnt/i_reg[26]  ( .D(\DTP/cnt/N28 ), .CP(net7829), .RN(
        Rst), .Q(\DTP/cnt/i[26] ) );
  HS65_LL_DFPRQX4 \DTP/cnt/i_reg[27]  ( .D(\DTP/cnt/N29 ), .CP(net7829), .RN(
        Rst), .Q(\DTP/cnt/i[27] ) );
  HS65_LL_DFPRQX4 \DTP/cnt/i_reg[28]  ( .D(\DTP/cnt/N30 ), .CP(net7829), .RN(
        Rst), .Q(\DTP/cnt/i[28] ) );
  HS65_LL_DFPRQX4 \DTP/cnt/i_reg[29]  ( .D(\DTP/cnt/N31 ), .CP(net7829), .RN(
        Rst), .Q(\DTP/cnt/i[29] ) );
  HS65_LL_DFPRQX4 \DTP/cnt/i_reg[30]  ( .D(\DTP/cnt/N32 ), .CP(net7829), .RN(
        Rst), .Q(\DTP/cnt/i[30] ) );
  HS65_LL_DFPSQX4 \DTP/cnt/tc_reg  ( .D(\DTP/cnt/N94 ), .CP(Clk), .SN(Rst), 
        .Q(\DTP/bootstrap ) );
  HS65_LL_DFPQX4 \DTP/forward_branchREG1/d_out_reg  ( .D(
        \DTP/forward_branchREG1/N2 ), .CP(Clk), .Q(\DTP/forward_branch1 ) );
  HS65_LL_DFPQX4 \DTP/forward_branchREG2/d_out_reg  ( .D(
        \DTP/forward_branchREG2/N2 ), .CP(Clk), .Q(\DTP/forward_branch2 ) );
  HS65_LL_DFPQX4 \DTP/pcen1/d_out_reg  ( .D(Rst), .CP(Clk), .Q(
        \DTP/PC_enable1 ) );
  HS65_LL_DFPQX4 \DTP/JALreg1/d_out_reg  ( .D(\DTP/JALreg1/N2 ), .CP(Clk), .Q(
        \DTP/JAL_op1 ) );
  HS65_LL_DFPQX4 \DTP/JRreg1/d_out_reg  ( .D(\DTP/JRreg1/N2 ), .CP(Clk), .Q(
        \DTP/JR_op1 ) );
  HS65_LL_DFPQX4 \DTP/BRANCH_opREG1/d_out_reg  ( .D(\DTP/BRANCH_opREG1/N2 ), 
        .CP(Clk), .Q(\DTP/BRANCH_op1 ) );
  HS65_LL_DFPQX4 \DTP/FWDBRANCH1/d_out_reg  ( .D(\DTP/FWDBRANCH1/N2 ), .CP(Clk), .Q(\DTP/FWD_exe_branch1 ) );
  HS65_LL_DFPQX4 \DTP/NPCreg1/d_out_reg[1]  ( .D(\DTP/NPCreg1/N3 ), .CP(Clk), 
        .Q(\DTP/NPC1 [1]) );
  HS65_LL_DFPQX4 \DTP/NPCreg2/d_out_reg[1]  ( .D(\DTP/NPCreg2/N3 ), .CP(Clk), 
        .Q(\DTP/NPC2[1] ) );
  HS65_LL_DFPQX4 \DTP/ALU_REG/d_out_reg[15]  ( .D(\DTP/ALU_REG/N17 ), .CP(Clk), 
        .Q(\DTP/ALU_reg_out[15] ) );
  HS65_LL_DFPQX4 \DTP/ALU_REG/d_out_reg[20]  ( .D(\DTP/ALU_REG/N22 ), .CP(Clk), 
        .Q(\DTP/ALU_reg_out[20] ) );
  HS65_LL_DFPQX4 \DTP/ALU_REG/d_out_reg[28]  ( .D(\DTP/ALU_REG/N30 ), .CP(Clk), 
        .Q(\DTP/ALU_reg_out[28] ) );
  HS65_LL_DFPQX4 \DTP/ALU_REG/d_out_reg[30]  ( .D(\DTP/ALU_REG/N32 ), .CP(Clk), 
        .Q(\DTP/ALU_reg_out[30] ) );
  HS65_LL_DFPQX4 \DTP/ALU_REG/d_out_reg[1]  ( .D(\DTP/ALU_REG/N3 ), .CP(Clk), 
        .Q(\DTP/ALU_reg_out[1] ) );
  HS65_LL_DFPQX4 \DTP/ALU_REG/d_out_reg[2]  ( .D(\DTP/ALU_REG/N4 ), .CP(Clk), 
        .Q(\DTP/ALU_reg_out[2] ) );
  HS65_LL_DFPQX4 \DTP/PC/d_out_reg[2]  ( .D(\DTP/PC/N5 ), .CP(net7824), .Q(
        PC[0]) );
  HS65_LL_DFPQX4 \DTP/NPCreg1/d_out_reg[2]  ( .D(\DTP/NPCreg1/N4 ), .CP(Clk), 
        .Q(\DTP/NPC1 [2]) );
  HS65_LL_DFPQX4 \DTP/NPCreg2/d_out_reg[2]  ( .D(\DTP/NPCreg2/N4 ), .CP(Clk), 
        .Q(\DTP/NPC2[2] ) );
  HS65_LL_DFPQX4 \DTP/PC/d_out_reg[3]  ( .D(\DTP/PC/N6 ), .CP(net7824), .Q(
        PC[1]) );
  HS65_LL_DFPQX4 \DTP/ALU_REG/d_out_reg[4]  ( .D(\DTP/ALU_REG/N6 ), .CP(Clk), 
        .Q(\DTP/ALU_reg_out[4] ) );
  HS65_LL_DFPQX4 \DTP/ALU_REG/d_out_reg[5]  ( .D(\DTP/ALU_REG/N7 ), .CP(Clk), 
        .Q(\DTP/ALU_reg_out[5] ) );
  HS65_LL_DFPQX4 \DTP/ALU_REG/d_out_reg[6]  ( .D(\DTP/ALU_REG/N8 ), .CP(Clk), 
        .Q(\DTP/ALU_reg_out[6] ) );
  HS65_LL_DFPQX4 \DTP/ALU_REG/d_out_reg[7]  ( .D(\DTP/ALU_REG/N9 ), .CP(Clk), 
        .Q(\DTP/ALU_reg_out[7] ) );
  HS65_LL_DFPQX4 \DTP/ALU_REG/d_out_reg[9]  ( .D(\DTP/ALU_REG/N11 ), .CP(Clk), 
        .Q(\DTP/ALU_reg_out[9] ) );
  HS65_LL_DFPQX4 \DTP/ALU_REG/d_out_reg[8]  ( .D(\DTP/ALU_REG/N10 ), .CP(Clk), 
        .Q(\DTP/ALU_reg_out[8] ) );
  HS65_LL_DFPQX4 \DTP/ALU_REG/d_out_reg[11]  ( .D(\DTP/ALU_REG/N13 ), .CP(Clk), 
        .Q(\DTP/ALU_reg_out[11] ) );
  HS65_LL_DFPQX4 \DTP/ALU_REG/d_out_reg[12]  ( .D(\DTP/ALU_REG/N14 ), .CP(Clk), 
        .Q(\DTP/ALU_reg_out[12] ) );
  HS65_LL_DFPQX4 \DTP/ALU_REG/d_out_reg[13]  ( .D(\DTP/ALU_REG/N15 ), .CP(Clk), 
        .Q(\DTP/ALU_reg_out[13] ) );
  HS65_LL_DFPQX4 \DTP/ALU_REG/d_out_reg[14]  ( .D(\DTP/ALU_REG/N16 ), .CP(Clk), 
        .Q(\DTP/ALU_reg_out[14] ) );
  HS65_LL_DFPQX4 \DTP/ALU_REG/d_out_reg[16]  ( .D(\DTP/ALU_REG/N18 ), .CP(Clk), 
        .Q(\DTP/ALU_reg_out[16] ) );
  HS65_LL_DFPQX4 \DTP/ALU_REG/d_out_reg[19]  ( .D(\DTP/ALU_REG/N21 ), .CP(Clk), 
        .Q(\DTP/ALU_reg_out[19] ) );
  HS65_LL_DFPQX4 \DTP/ALU_REG/d_out_reg[21]  ( .D(\DTP/ALU_REG/N23 ), .CP(Clk), 
        .Q(\DTP/ALU_reg_out[21] ) );
  HS65_LL_DFPQX4 \DTP/ALU_REG/d_out_reg[23]  ( .D(\DTP/ALU_REG/N25 ), .CP(Clk), 
        .Q(\DTP/ALU_reg_out[23] ) );
  HS65_LL_DFPQX4 \DTP/ALU_REG/d_out_reg[26]  ( .D(\DTP/ALU_REG/N28 ), .CP(Clk), 
        .Q(\DTP/ALU_reg_out[26] ) );
  HS65_LL_DFPQX4 \DTP/ALU_REG/d_out_reg[29]  ( .D(\DTP/ALU_REG/N31 ), .CP(Clk), 
        .Q(\DTP/ALU_reg_out[29] ) );
  HS65_LL_DFPQX4 \DTP/PC/d_out_reg[5]  ( .D(\DTP/PC/N8 ), .CP(net7824), .Q(
        PC[3]) );
  HS65_LL_DFPQX4 \DTP/PC/d_out_reg[13]  ( .D(\DTP/PC/N16 ), .CP(net7824), .Q(
        PC[11]) );
  HS65_LL_DFPQX4 \DTP/PC/d_out_reg[30]  ( .D(\DTP/PC/N33 ), .CP(net7824), .Q(
        PC[28]) );
  HS65_LL_DFPQX4 \DTP/PC/d_out_reg[29]  ( .D(\DTP/PC/N32 ), .CP(net7824), .Q(
        PC[27]) );
  HS65_LL_DFPQX4 \DTP/PC/d_out_reg[28]  ( .D(\DTP/PC/N31 ), .CP(net7824), .Q(
        PC[26]) );
  HS65_LL_DFPQX4 \DTP/PC/d_out_reg[24]  ( .D(\DTP/PC/N27 ), .CP(net7824), .Q(
        PC[22]) );
  HS65_LL_DFPQX4 \DTP/PC/d_out_reg[25]  ( .D(\DTP/PC/N28 ), .CP(net7824), .Q(
        PC[23]) );
  HS65_LL_DFPQX4 \DTP/PC/d_out_reg[26]  ( .D(\DTP/PC/N29 ), .CP(net7824), .Q(
        PC[24]) );
  HS65_LL_DFPQX4 \DTP/PC/d_out_reg[21]  ( .D(\DTP/PC/N24 ), .CP(net7824), .Q(
        PC[19]) );
  HS65_LL_DFPQX4 \DTP/PC/d_out_reg[23]  ( .D(\DTP/PC/N26 ), .CP(net7824), .Q(
        PC[21]) );
  HS65_LL_DFPQX4 \DTP/PC/d_out_reg[19]  ( .D(\DTP/PC/N22 ), .CP(net7824), .Q(
        PC[17]) );
  HS65_LL_DFPQX4 \DTP/PC/d_out_reg[17]  ( .D(\DTP/PC/N20 ), .CP(net7824), .Q(
        PC[15]) );
  HS65_LL_DFPQX4 \DTP/PC/d_out_reg[18]  ( .D(\DTP/PC/N21 ), .CP(net7824), .Q(
        PC[16]) );
  HS65_LL_DFPQX4 \DTP/PC/d_out_reg[9]  ( .D(\DTP/PC/N12 ), .CP(net7824), .Q(
        PC[7]) );
  HS65_LL_DFPQX4 \DTP/PC/d_out_reg[10]  ( .D(\DTP/PC/N13 ), .CP(net7824), .Q(
        PC[8]) );
  HS65_LL_DFPQX4 \DTP/PC/d_out_reg[0]  ( .D(\DTP/PC/N3 ), .CP(net7824), .Q(
        \DTP/NPC[0] ) );
  HS65_LL_DFPQX4 \DTP/PC/d_out_reg[4]  ( .D(\DTP/PC/N7 ), .CP(net7824), .Q(
        PC[2]) );
  HS65_LL_DFPQX4 \DTP/PC/d_out_reg[6]  ( .D(\DTP/PC/N9 ), .CP(net7824), .Q(
        PC[4]) );
  HS65_LL_DFPQX4 \DTP/PC/d_out_reg[7]  ( .D(\DTP/PC/N10 ), .CP(net7824), .Q(
        PC[5]) );
  HS65_LL_DFPQX4 \DTP/PC/d_out_reg[8]  ( .D(\DTP/PC/N11 ), .CP(net7824), .Q(
        PC[6]) );
  HS65_LL_DFPQX4 \DTP/PC/d_out_reg[11]  ( .D(\DTP/PC/N14 ), .CP(net7824), .Q(
        PC[9]) );
  HS65_LL_DFPQX4 \DTP/PC/d_out_reg[12]  ( .D(\DTP/PC/N15 ), .CP(net7824), .Q(
        PC[10]) );
  HS65_LL_DFPQX4 \DTP/PC/d_out_reg[14]  ( .D(\DTP/PC/N17 ), .CP(net7824), .Q(
        PC[12]) );
  HS65_LL_DFPQX4 \DTP/PC/d_out_reg[15]  ( .D(\DTP/PC/N18 ), .CP(net7824), .Q(
        PC[13]) );
  HS65_LL_DFPQX4 \DTP/PC/d_out_reg[16]  ( .D(\DTP/PC/N19 ), .CP(net7824), .Q(
        PC[14]) );
  HS65_LL_DFPQX4 \DTP/PC/d_out_reg[20]  ( .D(\DTP/PC/N23 ), .CP(net7824), .Q(
        PC[18]) );
  HS65_LL_DFPQX4 \DTP/PC/d_out_reg[22]  ( .D(\DTP/PC/N25 ), .CP(net7824), .Q(
        PC[20]) );
  HS65_LL_DFPQX4 \DTP/PC/d_out_reg[27]  ( .D(\DTP/PC/N30 ), .CP(net7824), .Q(
        PC[25]) );
  HS65_LL_DFPQX4 \DTP/PC/d_out_reg[31]  ( .D(\DTP/PC/N34 ), .CP(net7824), .Q(
        PC[31]) );
  HS65_LL_DFPQX9 \DTP/JALreg2/d_out_reg  ( .D(\DTP/JALreg2/N2 ), .CP(Clk), .Q(
        \DTP/JAL_op2 ) );
  HS65_LL_DFPQNX9 \DTP/RDreg2/d_out_reg[4]  ( .D(\DTP/RDreg2/N6 ), .CP(Clk), 
        .QN(n141) );
  HS65_LL_DFPQNX9 \DTP/RDreg2/d_out_reg[1]  ( .D(\DTP/RDreg2/N3 ), .CP(Clk), 
        .QN(n139) );
  HS65_LL_DFPQNX9 \DTP/BRANCH_opREG2/d_out_reg  ( .D(\DTP/BRANCH_opREG2/N2 ), 
        .CP(Clk), .QN(n128) );
  HS65_LL_DFPQNX9 \DTP/LOADREG1/d_out_reg  ( .D(\DTP/LOADREG1/N2 ), .CP(Clk), 
        .QN(n127) );
  HS65_LL_DFPQNX9 \DTP/ALU_REG/d_out_reg[18]  ( .D(\DTP/ALU_REG/N20 ), .CP(Clk), .QN(n80) );
  HS65_LL_DFPQNX9 \DTP/ALU_REG/d_out_reg[27]  ( .D(\DTP/ALU_REG/N29 ), .CP(Clk), .QN(n110) );
  HS65_LL_DFPQNX9 \DTP/ALU_REG/d_out_reg[22]  ( .D(\DTP/ALU_REG/N24 ), .CP(Clk), .QN(n72) );
  HS65_LL_DFPQNX9 \DTP/IR/d_out_reg[17]  ( .D(\DTP/IR/N19 ), .CP(Clk), .QN(
        n159) );
  HS65_LL_DFPQNX9 \DTP/IR/d_out_reg[18]  ( .D(\DTP/IR/N20 ), .CP(Clk), .QN(
        n158) );
  HS65_LL_DFPQNX9 \DTP/IR/d_out_reg[20]  ( .D(\DTP/IR/N22 ), .CP(Clk), .QN(
        n156) );
  HS65_LL_DFPQNX9 \DTP/IR/d_out_reg[26]  ( .D(\DTP/IR/N28 ), .CP(Clk), .QN(
        n150) );
  HS65_LL_DFPQNX9 \DTP/ALU_REG/d_out_reg[25]  ( .D(\DTP/ALU_REG/N27 ), .CP(Clk), .QN(n112) );
  HS65_LL_DFPQNX9 \DTP/RDreg2/d_out_reg[3]  ( .D(\DTP/RDreg2/N5 ), .CP(Clk), 
        .QN(n145) );
  HS65_LL_DFPQNX9 \DTP/ALU_REG/d_out_reg[17]  ( .D(\DTP/ALU_REG/N19 ), .CP(Clk), .QN(n83) );
  HS65_LL_DFPQNX9 \DTP/IR/d_out_reg[25]  ( .D(\DTP/IR/N27 ), .CP(Clk), .QN(
        n151) );
  HS65_LL_DFPQNX9 \DTP/ALU_REG/d_out_reg[24]  ( .D(\DTP/ALU_REG/N26 ), .CP(Clk), .QN(n69) );
  HS65_LL_DFPQNX9 \DTP/ALU_REG/d_out_reg[3]  ( .D(\DTP/ALU_REG/N5 ), .CP(Clk), 
        .QN(n103) );
  HS65_LL_DFPQNX9 \DTP/IR/d_out_reg[19]  ( .D(\DTP/IR/N21 ), .CP(Clk), .QN(
        n157) );
  HS65_LL_DFPQNX9 \DTP/RDreg1/d_out_reg[3]  ( .D(\DTP/RDreg1/N5 ), .CP(Clk), 
        .QN(n146) );
  HS65_LL_DFPQNX9 \DTP/ALU_REG/d_out_reg[10]  ( .D(\DTP/ALU_REG/N12 ), .CP(Clk), .QN(n93) );
  HS65_LL_DFPQNX9 \DTP/IR/d_out_reg[16]  ( .D(\DTP/IR/N18 ), .CP(Clk), .QN(
        n160) );
  HS65_LL_DFPQNX9 \DTP/ALU_REG/d_out_reg[0]  ( .D(\DTP/ALU_REG/N2 ), .CP(Clk), 
        .QN(n119) );
  HS65_LL_DFPQNX9 \DTP/IR/d_out_reg[28]  ( .D(\DTP/IR/N30 ), .CP(Clk), .QN(
        n148) );
  HS65_LL_DFPQNX9 \DTP/IR/d_out_reg[27]  ( .D(\DTP/IR/N29 ), .CP(Clk), .QN(
        n149) );
  HS65_LL_DFPQNX9 \DTP/PC/d_out_reg[1]  ( .D(\DTP/PC/N4 ), .CP(net7824), .QN(
        \intadd_0/A[0] ) );
  HS65_LL_DFPQNX9 \DTP/IR/d_out_reg[24]  ( .D(\DTP/IR/N26 ), .CP(Clk), .QN(
        n152) );
  HS65_LL_DFPQNX9 \DTP/RDreg1/d_out_reg[1]  ( .D(\DTP/RDreg1/N3 ), .CP(Clk), 
        .QN(n140) );
  HS65_LL_DFPQNX9 \DTP/RDreg1/d_out_reg[2]  ( .D(\DTP/RDreg1/N4 ), .CP(Clk), 
        .QN(n144) );
  HS65_LL_DFPQNX9 \DTP/IR/d_out_reg[21]  ( .D(\DTP/IR/N23 ), .CP(Clk), .QN(
        n155) );
  HS65_LL_DFPQNX9 \DTP/ALU_REG/d_out_reg[31]  ( .D(\DTP/ALU_REG/N33 ), .CP(Clk), .QN(n124) );
  HS65_LL_DFPQNX9 \DTP/IR/d_out_reg[23]  ( .D(\DTP/IR/N25 ), .CP(Clk), .QN(
        n153) );
  HS65_LL_DFPQNX9 \DTP/RDreg1/d_out_reg[4]  ( .D(\DTP/RDreg1/N6 ), .CP(Clk), 
        .QN(n142) );
  HS65_LL_DFPQNX9 \DTP/IR/d_out_reg[22]  ( .D(\DTP/IR/N24 ), .CP(Clk), .QN(
        n154) );
  HS65_LL_OR2X9 \sub_x_338/U9  ( .A(\DTP/cnt/i[26] ), .B(\sub_x_338/n12 ), .Z(
        \sub_x_338/n11 ) );
  HS65_LL_OR2X9 \sub_x_338/U7  ( .A(\DTP/cnt/i[27] ), .B(\sub_x_338/n11 ), .Z(
        \sub_x_338/n10 ) );
  HS65_LL_OR2X9 \sub_x_338/U5  ( .A(\DTP/cnt/i[28] ), .B(\sub_x_338/n10 ), .Z(
        \sub_x_338/n9 ) );
  HS65_LL_OR2X9 \sub_x_338/U85  ( .A(\DTP/cnt/i[1] ), .B(\DTP/cnt/i[0] ), .Z(
        \sub_x_338/n54 ) );
  HS65_LL_FA1X4 \intadd_0/U4  ( .A0(\intadd_0/A[0] ), .B0(\intadd_0/B[0] ), 
        .CI(\intadd_0/CI ), .CO(\intadd_0/n3 ), .S0(\intadd_0/SUM[0] ) );
  HS65_LL_FA1X4 \intadd_0/U3  ( .A0(\intadd_0/A[1] ), .B0(PC[0]), .CI(
        \intadd_0/n3 ), .CO(\intadd_0/n2 ), .S0(\intadd_0/SUM[1] ) );
  HS65_LL_FA1X4 \intadd_0/U2  ( .A0(\intadd_0/A[2] ), .B0(\intadd_0/B[2] ), 
        .CI(\intadd_0/n2 ), .CO(\intadd_0/n1 ), .S0(\intadd_0/SUM[2] ) );
  HS65_LL_FA1X4 \intadd_1/U4  ( .A0(IR[12]), .B0(\DTP/NPC[12] ), .CI(
        \intadd_1/CI ), .CO(\intadd_1/n3 ), .S0(\intadd_1/SUM[0] ) );
  HS65_LL_FA1X4 \intadd_1/U3  ( .A0(IR[13]), .B0(\DTP/NPC[13] ), .CI(
        \intadd_1/n3 ), .CO(\intadd_1/n2 ), .S0(\intadd_1/SUM[1] ) );
  HS65_LL_FA1X4 \intadd_1/U2  ( .A0(\DTP/NPC[14] ), .B0(IR[14]), .CI(
        \intadd_1/n2 ), .CO(\intadd_1/n1 ), .S0(\intadd_1/SUM[2] ) );
  HS65_LL_HA1X4 \add_x_320/U6  ( .A0(PC[24]), .B0(\add_x_320/n6 ), .CO(
        \add_x_320/n5 ), .S0(\DTP/NPC[26] ) );
  HS65_LL_HA1X4 \add_x_320/U5  ( .A0(PC[25]), .B0(\add_x_320/n5 ), .CO(
        \add_x_320/n4 ), .S0(\DTP/NPC[27] ) );
  HS65_LL_HA1X4 \add_x_320/U4  ( .A0(PC[26]), .B0(\add_x_320/n4 ), .CO(
        \add_x_320/n3 ), .S0(\DTP/NPC[28] ) );
  HS65_LL_HA1X4 \add_x_320/U3  ( .A0(PC[27]), .B0(\add_x_320/n3 ), .CO(
        \add_x_320/n2 ), .S0(\DTP/NPC[29] ) );
  HS65_LL_HA1X4 \add_x_320/U2  ( .A0(PC[28]), .B0(\add_x_320/n2 ), .CO(
        \add_x_320/n1 ), .S0(\DTP/NPC[30] ) );
  HS65_LL_NOR2X6 \sub_x_338/U61  ( .A(\DTP/cnt/i[4] ), .B(\DTP/cnt/i[5] ), .Z(
        \sub_x_338/n39 ) );
  HS65_LLS_XNOR2X6 \sub_x_338/U4  ( .A(\DTP/cnt/i[28] ), .B(\sub_x_338/n10 ), 
        .Z(\DTP/cnt/N30 ) );
  HS65_LLS_XNOR2X6 \sub_x_338/U8  ( .A(\DTP/cnt/i[26] ), .B(\sub_x_338/n12 ), 
        .Z(\DTP/cnt/N28 ) );
  HS65_LLS_XNOR2X6 \sub_x_338/U10  ( .A(\DTP/cnt/i[25] ), .B(\sub_x_338/n13 ), 
        .Z(\DTP/cnt/N27 ) );
  HS65_LLS_XNOR2X6 \sub_x_338/U14  ( .A(\DTP/cnt/i[23] ), .B(\sub_x_338/n15 ), 
        .Z(\DTP/cnt/N25 ) );
  HS65_LLS_XNOR2X6 \sub_x_338/U18  ( .A(\DTP/cnt/i[21] ), .B(\sub_x_338/n17 ), 
        .Z(\DTP/cnt/N23 ) );
  HS65_LLS_XNOR2X6 \sub_x_338/U24  ( .A(\DTP/cnt/i[18] ), .B(\sub_x_338/n20 ), 
        .Z(\DTP/cnt/N20 ) );
  HS65_LLS_XNOR2X6 \sub_x_338/U34  ( .A(\DTP/cnt/i[13] ), .B(\sub_x_338/n25 ), 
        .Z(\DTP/cnt/N15 ) );
  HS65_LLS_XNOR2X6 \sub_x_338/U38  ( .A(\DTP/cnt/i[11] ), .B(\sub_x_338/n27 ), 
        .Z(\DTP/cnt/N13 ) );
  HS65_LLS_XNOR2X6 \sub_x_338/U36  ( .A(\DTP/cnt/i[12] ), .B(\sub_x_338/n26 ), 
        .Z(\DTP/cnt/N14 ) );
  HS65_LLS_XOR2X6 \sub_x_338/U65  ( .A(\DTP/cnt/i[4] ), .B(\sub_x_338/n46 ), 
        .Z(\DTP/cnt/N6 ) );
  HS65_LLS_XNOR2X6 \sub_x_338/U79  ( .A(\DTP/cnt/i[2] ), .B(\sub_x_338/n54 ), 
        .Z(\DTP/cnt/N4 ) );
  HS65_LLS_XOR2X6 \sub_x_338/U71  ( .A(\DTP/cnt/i[3] ), .B(\sub_x_338/n51 ), 
        .Z(\DTP/cnt/N5 ) );
  HS65_LLS_XNOR2X6 \sub_x_338/U44  ( .A(\DTP/cnt/i[8] ), .B(n7196), .Z(
        \DTP/cnt/N10 ) );
  HS65_LL_NAND2X7 \sub_x_338/U60  ( .A(\sub_x_338/n39 ), .B(\sub_x_338/n46 ), 
        .Z(\sub_x_338/n38 ) );
  HS65_LLS_XOR2X6 \sub_x_338/U47  ( .A(\DTP/cnt/i[7] ), .B(\sub_x_338/n35 ), 
        .Z(\DTP/cnt/N9 ) );
  HS65_LLS_XNOR2X6 \sub_x_338/U54  ( .A(\DTP/cnt/i[6] ), .B(\sub_x_338/n38 ), 
        .Z(\DTP/cnt/N8 ) );
  HS65_LLS_XNOR2X6 \sub_x_338/U42  ( .A(\DTP/cnt/i[9] ), .B(\sub_x_338/n29 ), 
        .Z(\DTP/cnt/N11 ) );
  HS65_LLS_XNOR2X6 \sub_x_338/U40  ( .A(\DTP/cnt/i[10] ), .B(\sub_x_338/n28 ), 
        .Z(\DTP/cnt/N12 ) );
  HS65_LLS_XNOR2X6 \sub_x_338/U32  ( .A(\DTP/cnt/i[14] ), .B(\sub_x_338/n24 ), 
        .Z(\DTP/cnt/N16 ) );
  HS65_LLS_XNOR2X6 \sub_x_338/U26  ( .A(\DTP/cnt/i[17] ), .B(\sub_x_338/n21 ), 
        .Z(\DTP/cnt/N19 ) );
  HS65_LLS_XNOR2X6 \sub_x_338/U22  ( .A(\DTP/cnt/i[19] ), .B(\sub_x_338/n19 ), 
        .Z(\DTP/cnt/N21 ) );
  HS65_LLS_XNOR2X6 \sub_x_338/U16  ( .A(\DTP/cnt/i[22] ), .B(\sub_x_338/n16 ), 
        .Z(\DTP/cnt/N24 ) );
  HS65_LLS_XNOR2X6 \sub_x_338/U12  ( .A(\DTP/cnt/i[24] ), .B(\sub_x_338/n14 ), 
        .Z(\DTP/cnt/N26 ) );
  HS65_LLS_XNOR2X6 \sub_x_338/U6  ( .A(\DTP/cnt/i[27] ), .B(\sub_x_338/n11 ), 
        .Z(\DTP/cnt/N29 ) );
  HS65_LLS_XNOR2X6 \sub_x_338/U2  ( .A(\DTP/cnt/i[29] ), .B(\sub_x_338/n9 ), 
        .Z(\DTP/cnt/N31 ) );
  HS65_LL_OR2X9 \sub_x_338/U11  ( .A(\DTP/cnt/i[25] ), .B(\sub_x_338/n13 ), 
        .Z(\sub_x_338/n12 ) );
  HS65_LL_OR2X9 \sub_x_338/U45  ( .A(\DTP/cnt/i[8] ), .B(n7196), .Z(
        \sub_x_338/n29 ) );
  HS65_LL_OR2X9 \sub_x_338/U43  ( .A(\DTP/cnt/i[9] ), .B(\sub_x_338/n29 ), .Z(
        \sub_x_338/n28 ) );
  HS65_LL_OR2X9 \sub_x_338/U41  ( .A(\DTP/cnt/i[10] ), .B(\sub_x_338/n28 ), 
        .Z(\sub_x_338/n27 ) );
  HS65_LL_OR2X9 \sub_x_338/U39  ( .A(\DTP/cnt/i[11] ), .B(\sub_x_338/n27 ), 
        .Z(\sub_x_338/n26 ) );
  HS65_LL_OR2X9 \sub_x_338/U37  ( .A(\DTP/cnt/i[12] ), .B(\sub_x_338/n26 ), 
        .Z(\sub_x_338/n25 ) );
  HS65_LL_OR2X9 \sub_x_338/U35  ( .A(\DTP/cnt/i[13] ), .B(\sub_x_338/n25 ), 
        .Z(\sub_x_338/n24 ) );
  HS65_LL_OR2X9 \sub_x_338/U33  ( .A(\DTP/cnt/i[14] ), .B(\sub_x_338/n24 ), 
        .Z(\sub_x_338/n23 ) );
  HS65_LL_OR2X9 \sub_x_338/U31  ( .A(\DTP/cnt/i[15] ), .B(\sub_x_338/n23 ), 
        .Z(\sub_x_338/n22 ) );
  HS65_LL_OR2X9 \sub_x_338/U29  ( .A(\DTP/cnt/i[16] ), .B(\sub_x_338/n22 ), 
        .Z(\sub_x_338/n21 ) );
  HS65_LL_OR2X9 \sub_x_338/U27  ( .A(\DTP/cnt/i[17] ), .B(\sub_x_338/n21 ), 
        .Z(\sub_x_338/n20 ) );
  HS65_LL_OR2X9 \sub_x_338/U25  ( .A(\DTP/cnt/i[18] ), .B(\sub_x_338/n20 ), 
        .Z(\sub_x_338/n19 ) );
  HS65_LL_OR2X9 \sub_x_338/U23  ( .A(\DTP/cnt/i[19] ), .B(\sub_x_338/n19 ), 
        .Z(\sub_x_338/n18 ) );
  HS65_LL_OR2X9 \sub_x_338/U21  ( .A(\DTP/cnt/i[20] ), .B(\sub_x_338/n18 ), 
        .Z(\sub_x_338/n17 ) );
  HS65_LL_OR2X9 \sub_x_338/U19  ( .A(\DTP/cnt/i[21] ), .B(\sub_x_338/n17 ), 
        .Z(\sub_x_338/n16 ) );
  HS65_LL_OR2X9 \sub_x_338/U17  ( .A(\DTP/cnt/i[22] ), .B(\sub_x_338/n16 ), 
        .Z(\sub_x_338/n15 ) );
  HS65_LL_OR2X9 \sub_x_338/U15  ( .A(\DTP/cnt/i[23] ), .B(\sub_x_338/n15 ), 
        .Z(\sub_x_338/n14 ) );
  HS65_LL_OR2X9 \sub_x_338/U13  ( .A(\DTP/cnt/i[24] ), .B(\sub_x_338/n14 ), 
        .Z(\sub_x_338/n13 ) );
  HS65_LL_HA1X4 \add_x_320/U7  ( .A0(PC[23]), .B0(\add_x_320/n7 ), .CO(
        \add_x_320/n6 ), .S0(\DTP/NPC[25] ) );
  HS65_LL_HA1X4 \add_x_320/U8  ( .A0(PC[22]), .B0(\add_x_320/n8 ), .CO(
        \add_x_320/n7 ), .S0(\DTP/NPC[24] ) );
  HS65_LL_HA1X4 \add_x_320/U9  ( .A0(PC[21]), .B0(\add_x_320/n9 ), .CO(
        \add_x_320/n8 ), .S0(\DTP/NPC[23] ) );
  HS65_LL_HA1X4 \add_x_320/U14  ( .A0(PC[16]), .B0(\add_x_320/n14 ), .CO(
        \add_x_320/n13 ), .S0(\DTP/NPC[18] ) );
  HS65_LL_HA1X4 \add_x_320/U15  ( .A0(PC[15]), .B0(\add_x_320/n15 ), .CO(
        \add_x_320/n14 ), .S0(\DTP/NPC[17] ) );
  HS65_LL_HA1X4 \add_x_320/U16  ( .A0(PC[14]), .B0(\add_x_320/n16 ), .CO(
        \add_x_320/n15 ), .S0(\DTP/NPC[16] ) );
  HS65_LL_HA1X4 \add_x_320/U17  ( .A0(PC[13]), .B0(\add_x_320/n17 ), .CO(
        \add_x_320/n16 ), .S0(\DTP/NPC[15] ) );
  HS65_LL_HA1X4 \add_x_320/U18  ( .A0(PC[12]), .B0(\add_x_320/n18 ), .CO(
        \add_x_320/n17 ), .S0(\DTP/NPC[14] ) );
  HS65_LL_HA1X4 \add_x_320/U19  ( .A0(PC[11]), .B0(\add_x_320/n19 ), .CO(
        \add_x_320/n18 ), .S0(\DTP/NPC[13] ) );
  HS65_LL_HA1X4 \add_x_320/U20  ( .A0(PC[10]), .B0(\add_x_320/n20 ), .CO(
        \add_x_320/n19 ), .S0(\DTP/NPC[12] ) );
  HS65_LL_HA1X4 \add_x_320/U21  ( .A0(PC[9]), .B0(\add_x_320/n21 ), .CO(
        \add_x_320/n20 ), .S0(\DTP/NPC[11] ) );
  HS65_LL_HA1X4 \add_x_320/U22  ( .A0(PC[8]), .B0(\add_x_320/n22 ), .CO(
        \add_x_320/n21 ), .S0(\DTP/NPC[10] ) );
  HS65_LL_HA1X4 \add_x_320/U23  ( .A0(PC[7]), .B0(\add_x_320/n23 ), .CO(
        \add_x_320/n22 ), .S0(\DTP/NPC[9] ) );
  HS65_LL_HA1X4 \add_x_320/U13  ( .A0(PC[17]), .B0(\add_x_320/n13 ), .CO(
        \add_x_320/n12 ), .S0(\DTP/NPC[19] ) );
  HS65_LL_HA1X4 \add_x_320/U11  ( .A0(PC[19]), .B0(\add_x_320/n11 ), .CO(
        \add_x_320/n10 ), .S0(\DTP/NPC[21] ) );
  HS65_LL_HA1X4 \add_x_320/U10  ( .A0(PC[20]), .B0(\add_x_320/n10 ), .CO(
        \add_x_320/n9 ), .S0(\DTP/NPC[22] ) );
  HS65_LL_HA1X4 \add_x_320/U12  ( .A0(PC[18]), .B0(\add_x_320/n12 ), .CO(
        \add_x_320/n11 ), .S0(\DTP/NPC[20] ) );
  HS65_LL_HA1X4 \add_x_320/U24  ( .A0(PC[6]), .B0(\add_x_320/n24 ), .CO(
        \add_x_320/n23 ), .S0(\DTP/NPC[8] ) );
  HS65_LL_HA1X4 \add_x_320/U25  ( .A0(PC[5]), .B0(\add_x_320/n25 ), .CO(
        \add_x_320/n24 ), .S0(\DTP/NPC[7] ) );
  HS65_LL_HA1X4 \add_x_320/U26  ( .A0(PC[4]), .B0(\add_x_320/n26 ), .CO(
        \add_x_320/n25 ), .S0(\DTP/NPC[6] ) );
  HS65_LL_HA1X4 \add_x_320/U27  ( .A0(PC[3]), .B0(\add_x_320/n27 ), .CO(
        \add_x_320/n26 ), .S0(\DTP/NPC[5] ) );
  HS65_LL_HA1X4 \add_x_320/U28  ( .A0(PC[2]), .B0(\add_x_320/n28 ), .CO(
        \add_x_320/n27 ), .S0(\DTP/NPC[4] ) );
  HS65_LL_HA1X4 \add_x_320/U29  ( .A0(PC[1]), .B0(PC[0]), .CO(\add_x_320/n28 ), 
        .S0(\DTP/NPC[3] ) );
  HS65_LL_NOR2X5 \sub_x_338/U80  ( .A(\DTP/cnt/i[2] ), .B(\sub_x_338/n54 ), 
        .Z(\sub_x_338/n51 ) );
  HS65_LL_NOR2X5 \sub_x_338/U55  ( .A(\DTP/cnt/i[6] ), .B(\sub_x_338/n38 ), 
        .Z(\sub_x_338/n35 ) );
  HS65_LLS_XNOR2X3 \sub_x_338/U30  ( .A(\DTP/cnt/i[15] ), .B(\sub_x_338/n23 ), 
        .Z(\DTP/cnt/N17 ) );
  HS65_LLS_XNOR2X3 \sub_x_338/U28  ( .A(\DTP/cnt/i[16] ), .B(\sub_x_338/n22 ), 
        .Z(\DTP/cnt/N18 ) );
  HS65_LLS_XNOR2X3 \sub_x_338/U20  ( .A(\DTP/cnt/i[20] ), .B(\sub_x_338/n18 ), 
        .Z(\DTP/cnt/N22 ) );
  HS65_LH_DFPRQNX4 \DTP/cnt/i_reg[1]  ( .D(n7178), .CP(net7829), .RN(Rst), 
        .QN(\DTP/cnt/i[1] ) );
  HS65_LL_DFPQX9 R_22 ( .D(n7183), .CP(Clk), .Q(n7415) );
  HS65_LL_OA222X4 U10078 ( .A(n7207), .B(\intadd_0/B[2] ), .C(n7208), .D(1'b1), 
        .E(n7271), .F(\intadd_0/SUM[2] ), .Z(n7475) );
  HS65_LL_CB4I1X9 U10079 ( .A(n7348), .B(1'b0), .C(n7426), .D(Rst), .Z(
        \DTP/PC/N10 ) );
  HS65_LL_MX41X4 U10080 ( .D0(n7480), .S0(\DTP/NPC2[6] ), .D1(n7206), .S1(
        \DTP/NPC[6] ), .D2(n7278), .S2(n7350), .D3(1'b0), .S3(n7348), .Z(n7279) );
  HS65_LH_NOR3X1 U10081 ( .A(\DTP/cnt/i[16] ), .B(\DTP/cnt/i[17] ), .C(
        \DTP/cnt/i[26] ), .Z(n7127) );
  HS65_LH_NOR3X1 U10082 ( .A(\DTP/cnt/i[21] ), .B(\DTP/cnt/i[22] ), .C(
        \DTP/cnt/i[25] ), .Z(n7128) );
  HS65_LH_NOR3X1 U10083 ( .A(\DTP/cnt/i[10] ), .B(\DTP/cnt/i[24] ), .C(
        \DTP/cnt/i[23] ), .Z(n7129) );
  HS65_LH_NOR3X1 U10084 ( .A(\DTP/cnt/i[3] ), .B(\DTP/cnt/i[9] ), .C(
        \DTP/cnt/i[30] ), .Z(n7130) );
  HS65_LH_NAND4ABX3 U10085 ( .A(\DTP/cnt/i[8] ), .B(\DTP/cnt/i[15] ), .C(n7129), .D(n7130), .Z(n7131) );
  HS65_LH_NOR3X1 U10086 ( .A(\DTP/cnt/i[2] ), .B(\DTP/cnt/i[11] ), .C(
        \DTP/cnt/i[13] ), .Z(n7132) );
  HS65_LH_NOR3X1 U10087 ( .A(\DTP/cnt/i[0] ), .B(\DTP/cnt/i[29] ), .C(
        \DTP/cnt/i[12] ), .Z(n7133) );
  HS65_LH_NAND4ABX3 U10088 ( .A(\DTP/cnt/i[14] ), .B(n7131), .C(n7132), .D(
        n7133), .Z(n7134) );
  HS65_LH_NOR3X1 U10089 ( .A(\DTP/cnt/i[20] ), .B(\DTP/cnt/i[19] ), .C(
        \DTP/cnt/i[18] ), .Z(n7135) );
  HS65_LH_NOR3X1 U10090 ( .A(\DTP/cnt/i[7] ), .B(\DTP/cnt/i[6] ), .C(
        \DTP/cnt/i[27] ), .Z(n7136) );
  HS65_LH_NOR3AX2 U10091 ( .A(n7136), .B(\DTP/cnt/i[4] ), .C(\DTP/cnt/i[5] ), 
        .Z(n7137) );
  HS65_LH_NAND4ABX3 U10092 ( .A(\DTP/cnt/i[1] ), .B(\DTP/cnt/i[28] ), .C(n7135), .D(n7137), .Z(n7138) );
  HS65_LH_NOR4ABX2 U10093 ( .A(n7127), .B(n7128), .C(n7134), .D(n7138), .Z(
        n7488) );
  HS65_LH_IVX2 U10094 ( .A(n7317), .Z(n7139) );
  HS65_LH_AOI222X2 U10095 ( .A(n7139), .B(n7310), .C(\DTP/ALUWB/N30 ), .D(
        n7205), .E(n7480), .F(\DTP/NPCreg3/N30 ), .Z(n7140) );
  HS65_LH_IVX2 U10096 ( .A(n7308), .Z(n7141) );
  HS65_LH_CBI4I1X3 U10097 ( .A(n7350), .B(n7141), .C(n7347), .D(n7323), .Z(
        n7142) );
  HS65_LH_NAND2X2 U10098 ( .A(n7140), .B(n7142), .Z(\DTP/PC/N31 ) );
  HS65_LH_AND3X4 U10099 ( .A(\DTP/JAL_op2 ), .B(\DTP/NPC2[7] ), .C(Rst), .Z(
        \DTP/ALU_REG/N9 ) );
  HS65_LL_NAND4ABX3 U10100 ( .A(\sub_x_338/n47 ), .B(\DTP/cnt/i[6] ), .C(n7143), .D(\sub_x_338/n39 ), .Z(n7196) );
  HS65_LH_IVX2 U10101 ( .A(\DTP/cnt/i[7] ), .Z(n7143) );
  HS65_LH_IVX2 U10102 ( .A(n7479), .Z(n7144) );
  HS65_LL_OAI21X3 U10103 ( .A(n7310), .B(n7309), .C(n7312), .Z(n7145) );
  HS65_LH_IVX2 U10104 ( .A(n7317), .Z(n7146) );
  HS65_LH_MX41X4 U10105 ( .D0(n7144), .S0(\DTP/NPCreg3/N31 ), .D1(n7145), .S1(
        n7146), .D2(n7205), .S2(\DTP/ALUWB/N31 ), .D3(n7206), .S3(n7322), .Z(
        \DTP/PC/N32 ) );
  HS65_LH_AND3X4 U10106 ( .A(\DTP/JAL_op2 ), .B(\DTP/NPC2[6] ), .C(Rst), .Z(
        \DTP/ALU_REG/N8 ) );
  HS65_LH_NAND2AX4 U10107 ( .A(n7273), .B(n7295), .Z(n7275) );
  HS65_LH_IVX2 U10108 ( .A(n7479), .Z(n7147) );
  HS65_LH_IVX2 U10109 ( .A(n7433), .Z(n7148) );
  HS65_LH_MX41X4 U10110 ( .D0(n7147), .S0(n7148), .D1(n7346), .S1(
        \intadd_1/SUM[1] ), .D2(\DTP/ALUWB/N15 ), .S2(n7205), .D3(n7206), .S3(
        n7319), .Z(\DTP/PC/N16 ) );
  HS65_LH_AND3X4 U10111 ( .A(\DTP/JAL_op2 ), .B(\DTP/NPC2[4] ), .C(Rst), .Z(
        \DTP/ALU_REG/N6 ) );
  HS65_LH_NOR4ABX2 U10112 ( .A(n7178), .B(\DTP/cnt/i[0] ), .C(\DTP/cnt/N4 ), 
        .D(\DTP/cnt/N5 ), .Z(n7149) );
  HS65_LH_NOR3X1 U10113 ( .A(\DTP/cnt/N11 ), .B(\DTP/cnt/N9 ), .C(\DTP/cnt/N8 ), .Z(n7150) );
  HS65_LH_NOR4ABX2 U10114 ( .A(n7149), .B(n7150), .C(\DTP/cnt/N10 ), .D(
        \DTP/cnt/N6 ), .Z(n7151) );
  HS65_LH_NOR3X1 U10115 ( .A(\DTP/cnt/N13 ), .B(\DTP/cnt/N14 ), .C(
        \DTP/cnt/N12 ), .Z(n7152) );
  HS65_LH_NOR4ABX2 U10116 ( .A(n7151), .B(n7152), .C(\DTP/cnt/N7 ), .D(
        \DTP/cnt/N15 ), .Z(n7153) );
  HS65_LH_NOR3X1 U10117 ( .A(\DTP/cnt/N18 ), .B(\DTP/cnt/N17 ), .C(
        \DTP/cnt/N19 ), .Z(n7154) );
  HS65_LH_NOR4ABX2 U10118 ( .A(n7153), .B(n7154), .C(\DTP/cnt/N16 ), .D(
        \DTP/cnt/N20 ), .Z(n7155) );
  HS65_LH_NOR3X1 U10119 ( .A(\DTP/cnt/N23 ), .B(\DTP/cnt/N22 ), .C(
        \DTP/cnt/N24 ), .Z(n7156) );
  HS65_LH_NOR4ABX2 U10120 ( .A(n7155), .B(n7156), .C(\DTP/cnt/N21 ), .D(
        \DTP/cnt/N25 ), .Z(n7157) );
  HS65_LH_NOR3X1 U10121 ( .A(\DTP/cnt/N28 ), .B(\DTP/cnt/N27 ), .C(
        \DTP/cnt/N29 ), .Z(n7158) );
  HS65_LH_NAND4ABX3 U10122 ( .A(\DTP/cnt/N26 ), .B(\DTP/cnt/N30 ), .C(n7157), 
        .D(n7158), .Z(n7159) );
  HS65_LH_NOR3X1 U10123 ( .A(\DTP/cnt/N32 ), .B(\DTP/cnt/N31 ), .C(n7159), .Z(
        n7160) );
  HS65_LH_NOR2X2 U10124 ( .A(n7160), .B(n7488), .Z(\DTP/cnt/N94 ) );
  HS65_LH_OR3X4 U10125 ( .A(\DTP/cnt/i[2] ), .B(\DTP/cnt/i[3] ), .C(
        \sub_x_338/n54 ), .Z(\sub_x_338/n47 ) );
  HS65_LH_IVX2 U10126 ( .A(n7276), .Z(n7161) );
  HS65_LH_AOI12X2 U10127 ( .A(n7274), .B(n7161), .C(n7275), .Z(n7162) );
  HS65_LH_AOI311X2 U10128 ( .A(n7275), .B(n7161), .C(n7274), .D(n7317), .E(
        n7162), .Z(n7163) );
  HS65_LH_AOI12X2 U10129 ( .A(\DTP/ALUWB/N7 ), .B(n7205), .C(n7163), .Z(n7164)
         );
  HS65_LH_NAND2X2 U10130 ( .A(n7347), .B(n7332), .Z(n7165) );
  HS65_LH_OAI112X1 U10131 ( .A(n7479), .B(n7478), .C(n7164), .D(n7165), .Z(
        \DTP/PC/N8 ) );
  HS65_LH_AND3X4 U10132 ( .A(\DTP/JAL_op2 ), .B(\DTP/NPC2[2] ), .C(Rst), .Z(
        \DTP/ALU_REG/N4 ) );
  HS65_LH_OAI12X2 U10133 ( .A(\sub_x_338/n9 ), .B(\DTP/cnt/i[29] ), .C(
        \DTP/cnt/i[30] ), .Z(n7166) );
  HS65_LH_OAI13X1 U10134 ( .A(\sub_x_338/n9 ), .B(\DTP/cnt/i[30] ), .C(
        \DTP/cnt/i[29] ), .D(n7166), .Z(\DTP/cnt/N32 ) );
  HS65_LH_OR2X4 U10135 ( .A(IR[5]), .B(\DTP/NPC[5] ), .Z(n7274) );
  HS65_LH_NOR3X1 U10136 ( .A(IR[31]), .B(IR[29]), .C(IR[28]), .Z(n7167) );
  HS65_LH_NAND3X2 U10137 ( .A(\DTP/PC_enable1 ), .B(\DTP/IR/N29 ), .C(n7167), 
        .Z(n7388) );
  HS65_LH_NAND3X2 U10138 ( .A(\DTP/Instr_reg_out[31] ), .B(n7390), .C(Rst), 
        .Z(n7168) );
  HS65_LH_NOR3X1 U10139 ( .A(n7392), .B(\DTP/Instr_reg_out[29] ), .C(n7168), 
        .Z(\DTP/LOADREG1/N2 ) );
  HS65_LH_IVX2 U10140 ( .A(n7206), .Z(n7169) );
  HS65_LH_OAI22X1 U10141 ( .A(n7474), .B(n7195), .C(\intadd_0/SUM[1] ), .D(
        n7271), .Z(n7170) );
  HS65_LH_AOI12X2 U10142 ( .A(n7480), .B(\DTP/NPC2[2] ), .C(n7170), .Z(n7171)
         );
  HS65_LH_CBI4I6X2 U10143 ( .A(PC[0]), .B(n7169), .C(n7171), .D(n7211), .Z(
        \DTP/PC/N5 ) );
  HS65_LH_AND3X4 U10144 ( .A(\DTP/JAL_op2 ), .B(\DTP/NPC2[15] ), .C(Rst), .Z(
        \DTP/ALU_REG/N17 ) );
  HS65_LH_NOR2AX3 U10145 ( .A(\sub_x_338/n46 ), .B(\DTP/cnt/i[4] ), .Z(n7172)
         );
  HS65_LHS_XOR2X3 U10146 ( .A(\DTP/cnt/i[5] ), .B(n7172), .Z(\DTP/cnt/N7 ) );
  HS65_LH_NOR2AX3 U10147 ( .A(\DTP/NPC[20] ), .B(n7209), .Z(n7340) );
  HS65_LL_OR2X9 U10148 ( .A(n119), .B(n7209), .Z(n7173) );
  HS65_LL_NOR2X6 U10149 ( .A(n93), .B(n7209), .Z(n7174) );
  HS65_LL_OR2X9 U10150 ( .A(n7210), .B(n7425), .Z(n7175) );
  HS65_LL_OR2X9 U10151 ( .A(n103), .B(n7211), .Z(n7176) );
  HS65_LL_NAND2X7 U10152 ( .A(\DTP/ALU_reg_out[8] ), .B(Rst), .Z(n7177) );
  HS65_LLS_XOR2X6 U10153 ( .A(\DTP/cnt/i[1] ), .B(\DTP/cnt/i[0] ), .Z(n7178)
         );
  HS65_LL_OR2X9 U10154 ( .A(n7210), .B(n7482), .Z(n7179) );
  HS65_LL_OR2X9 U10155 ( .A(n7211), .B(n7427), .Z(n7180) );
  HS65_LL_NOR2X6 U10156 ( .A(n7209), .B(n7477), .Z(n7181) );
  HS65_LL_AND2X4 U10157 ( .A(\DTP/ALU_reg_out[15] ), .B(Rst), .Z(n7182) );
  HS65_LL_IVX9 U10158 ( .A(\DTP/ALUWB/N18 ), .Z(n85) );
  HS65_LL_IVX9 U10159 ( .A(\DTP/ALUWB/N19 ), .Z(n82) );
  HS65_LL_IVX9 U10160 ( .A(\DTP/ALUWB/N28 ), .Z(n66) );
  HS65_LL_IVX9 U10161 ( .A(\DTP/ALUWB/N31 ), .Z(n65) );
  HS65_LL_IVX9 U10162 ( .A(\DTP/ALUWB/N30 ), .Z(n108) );
  HS65_LL_IVX9 U10163 ( .A(n7320), .Z(n107) );
  HS65_LL_IVX9 U10164 ( .A(\DTP/ALUWB/N7 ), .Z(n100) );
  HS65_LL_IVX9 U10165 ( .A(\DTP/ALUWB/N15 ), .Z(n88) );
  HS65_LL_IVX9 U10166 ( .A(\DTP/ALUWB/N16 ), .Z(n86) );
  HS65_LL_IVX9 U10167 ( .A(\DTP/ALUWB/N25 ), .Z(n70) );
  HS65_LL_IVX9 U10168 ( .A(\DTP/ALUWB/N26 ), .Z(n68) );
  HS65_LL_IVX9 U10169 ( .A(\DTP/ALUWB/N27 ), .Z(n111) );
  HS65_LL_IVX9 U10170 ( .A(\DTP/ALUWB/N29 ), .Z(n109) );
  HS65_LL_IVX9 U10171 ( .A(n7330), .Z(n123) );
  HS65_LL_IVX9 U10172 ( .A(\DTP/ALUWB/N3 ), .Z(n105) );
  HS65_LL_IVX9 U10173 ( .A(\DTP/ALUWB/N13 ), .Z(n91) );
  HS65_LL_IVX9 U10174 ( .A(\DTP/ALUWB/N23 ), .Z(n74) );
  HS65_LL_IVX9 U10175 ( .A(\DTP/ALUWB/N20 ), .Z(n79) );
  HS65_LL_OAI12X3 U10176 ( .A(n7318), .B(n7317), .C(n7316), .Z(\DTP/PC/N33 )
         );
  HS65_LL_OAI12X3 U10177 ( .A(n7317), .B(n7285), .C(n7284), .Z(\DTP/PC/N34 )
         );
  HS65_LL_AOI21X2 U10178 ( .A(\DTP/NPC[30] ), .B(n7312), .C(n7311), .Z(n7318)
         );
  HS65_LL_NOR2X5 U10179 ( .A(n7312), .B(\DTP/NPC[30] ), .Z(n7311) );
  HS65_LL_NAND2X5 U10180 ( .A(n7346), .B(n7270), .Z(n7470) );
  HS65_LL_NOR2AX3 U10181 ( .A(n7308), .B(\DTP/NPC[28] ), .Z(n7310) );
  HS65_LL_AOI22X4 U10182 ( .A(n7204), .B(\DTP/ALUWB/N28 ), .C(n7346), .D(n7265), .Z(n7466) );
  HS65_LL_NOR2X5 U10183 ( .A(n7280), .B(\DTP/NPC[27] ), .Z(n7308) );
  HS65_LLS_XOR2X3 U10184 ( .A(n7269), .B(\DTP/NPC[26] ), .Z(n7265) );
  HS65_LL_AOI22X4 U10185 ( .A(n7204), .B(\DTP/ALUWB/N27 ), .C(n7346), .D(n7263), .Z(n7463) );
  HS65_LL_OAI211X4 U10186 ( .A(n7479), .B(n7455), .C(n7454), .D(n7453), .Z(
        \DTP/PC/N25 ) );
  HS65_LL_AOI22X4 U10187 ( .A(n7204), .B(\DTP/ALUWB/N26 ), .C(n7346), .D(n7260), .Z(n7460) );
  HS65_LL_IVX7 U10188 ( .A(\DTP/NPC[29] ), .Z(n7309) );
  HS65_LL_OAI211X4 U10189 ( .A(n7479), .B(n7452), .C(n7451), .D(n7450), .Z(
        \DTP/PC/N24 ) );
  HS65_LL_NAND2X5 U10190 ( .A(n7346), .B(n7258), .Z(n7457) );
  HS65_LLS_XOR2X3 U10191 ( .A(n7262), .B(\DTP/NPC[24] ), .Z(n7260) );
  HS65_LL_AOI21X2 U10192 ( .A(n7204), .B(\DTP/ALUWB/N24 ), .C(n7256), .Z(n7454) );
  HS65_LL_CBI4I6X2 U10193 ( .A(n7255), .B(n7257), .C(n7259), .D(n7317), .Z(
        n7256) );
  HS65_LL_OAI211X4 U10194 ( .A(n7479), .B(n7449), .C(n7448), .D(n7447), .Z(
        \DTP/PC/N23 ) );
  HS65_LL_AOI22X4 U10195 ( .A(n7204), .B(\DTP/ALUWB/N29 ), .C(n7206), .D(n7333), .Z(n7469) );
  HS65_LL_NAND2X5 U10196 ( .A(n7206), .B(n7334), .Z(n7465) );
  HS65_LL_AOI22X4 U10197 ( .A(n7204), .B(\DTP/ALUWB/N23 ), .C(n7346), .D(n7253), .Z(n7451) );
  HS65_LL_AOI22X4 U10198 ( .A(n7204), .B(\DTP/ALUWB/N22 ), .C(n7346), .D(n7251), .Z(n7448) );
  HS65_LL_OAI211X4 U10199 ( .A(n7479), .B(n7446), .C(n7445), .D(n7444), .Z(
        \DTP/PC/N22 ) );
  HS65_LLS_XOR2X3 U10200 ( .A(n7252), .B(\DTP/NPC[21] ), .Z(n7253) );
  HS65_LL_NOR2X5 U10201 ( .A(n7254), .B(\DTP/NPC[20] ), .Z(n7252) );
  HS65_LL_OAI211X4 U10202 ( .A(n7479), .B(n7443), .C(n7442), .D(n7441), .Z(
        \DTP/PC/N21 ) );
  HS65_LL_NAND2X4 U10203 ( .A(n7206), .B(n7336), .Z(n7459) );
  HS65_LL_AOI22X4 U10204 ( .A(n7204), .B(\DTP/ALUWB/N21 ), .C(n7346), .D(n7248), .Z(n7445) );
  HS65_LL_NAND2X4 U10205 ( .A(n7206), .B(n7335), .Z(n7462) );
  HS65_LLS_XOR2X3 U10206 ( .A(n7250), .B(\DTP/NPC[19] ), .Z(n7248) );
  HS65_LL_NAND2X4 U10207 ( .A(n7346), .B(n7246), .Z(n7442) );
  HS65_LL_AOI22X4 U10208 ( .A(n7204), .B(\DTP/ALUWB/N25 ), .C(n7206), .D(n7337), .Z(n7456) );
  HS65_LL_NAND2X4 U10209 ( .A(n7206), .B(n7338), .Z(n7453) );
  HS65_LL_AOI21X2 U10210 ( .A(n7436), .B(n7435), .C(n7210), .Z(\DTP/PC/N18 )
         );
  HS65_LL_NAND2X2 U10211 ( .A(n7350), .B(n7240), .Z(n7436) );
  HS65_LL_OAI211X4 U10212 ( .A(n7479), .B(n7434), .C(n7287), .D(n7286), .Z(
        \DTP/PC/N17 ) );
  HS65_LL_NAND2X4 U10213 ( .A(n7206), .B(n7340), .Z(n7447) );
  HS65_LL_AOI21X2 U10214 ( .A(n7346), .B(\intadd_1/SUM[2] ), .C(n7198), .Z(
        n7287) );
  HS65_LL_NAND2X4 U10215 ( .A(n7206), .B(n7339), .Z(n7450) );
  HS65_LL_OAI211X4 U10216 ( .A(n7479), .B(n7432), .C(n7289), .D(n7288), .Z(
        \DTP/PC/N15 ) );
  HS65_LL_NAND2X2 U10217 ( .A(n7341), .B(n7347), .Z(n7444) );
  HS65_LL_AOI21X2 U10218 ( .A(n7346), .B(\intadd_1/SUM[0] ), .C(n7199), .Z(
        n7289) );
  HS65_LL_OAI211X4 U10219 ( .A(n7479), .B(n7431), .C(n7430), .D(n7429), .Z(
        \DTP/PC/N14 ) );
  HS65_LL_NAND2X2 U10220 ( .A(n7346), .B(n7428), .Z(n7430) );
  HS65_LL_AOI22X3 U10221 ( .A(n7205), .B(\DTP/ALUWB/N19 ), .C(n7343), .D(n7206), .Z(n7439) );
  HS65_LL_AOI22X3 U10222 ( .A(n7204), .B(\DTP/ALUWB/N20 ), .C(n7342), .D(n7206), .Z(n7441) );
  HS65_LL_OAI12X3 U10223 ( .A(n7239), .B(n7238), .C(n7237), .Z(\intadd_1/CI )
         );
  HS65_LL_CBI4I6X2 U10224 ( .A(n119), .B(n7195), .C(n7468), .D(n7209), .Z(
        \DTP/PC/N3 ) );
  HS65_LL_CBI4I6X2 U10225 ( .A(n7195), .B(n7482), .C(n7481), .D(n7211), .Z(
        \DTP/PC/N9 ) );
  HS65_LL_AOI21X6 U10226 ( .A(IR[10]), .B(\DTP/NPC[10] ), .C(n7236), .Z(n7238)
         );
  HS65_LL_AOI21X2 U10227 ( .A(\DTP/NPC[0] ), .B(n7347), .C(n7267), .Z(n7468)
         );
  HS65_LL_AOI22X3 U10228 ( .A(n7205), .B(\DTP/ALUWB/N18 ), .C(n7344), .D(n7206), .Z(n7437) );
  HS65_LL_OAI12X3 U10229 ( .A(n7266), .B(n7479), .C(n7200), .Z(n7267) );
  HS65_LL_OAI12X3 U10230 ( .A(n7282), .B(n7479), .C(n7281), .Z(n7283) );
  HS65_LL_OAI12X3 U10231 ( .A(n7314), .B(n7479), .C(n7313), .Z(n7315) );
  HS65_LL_OAI211X4 U10232 ( .A(n7194), .B(n7473), .C(n7202), .D(n7472), .Z(
        \DTP/PC/N4 ) );
  HS65_LL_AOI21X2 U10233 ( .A(n7235), .B(n7234), .C(n7300), .Z(n7236) );
  HS65_LL_AOI22X1 U10234 ( .A(n7480), .B(\DTP/NPC2[8] ), .C(
        \DTP/ALU_reg_out[8] ), .D(n7204), .Z(n7292) );
  HS65_LL_NAND2X4 U10235 ( .A(n7329), .B(n7206), .Z(n7286) );
  HS65_LL_AOI22X1 U10236 ( .A(\DTP/ALU_reg_out[4] ), .B(n7204), .C(n7480), .D(
        \DTP/NPC2[4] ), .Z(n7298) );
  HS65_LL_AOI22X1 U10237 ( .A(n7480), .B(\DTP/NPC2[10] ), .C(
        \DTP/ALU_reg_out[10] ), .D(n7204), .Z(n7302) );
  HS65_LL_AOI21X4 U10238 ( .A(IR[9]), .B(\DTP/NPC[9] ), .C(n7233), .Z(n7300)
         );
  HS65_LL_IVX4 U10239 ( .A(n7480), .Z(n7194) );
  HS65_LL_AOI22X1 U10240 ( .A(\DTP/ALU_reg_out[9] ), .B(n7204), .C(n7480), .D(
        \DTP/NPC2[9] ), .Z(n7306) );
  HS65_LL_MX41X4 U10241 ( .D0(\DTP/ALU_reg_out[7] ), .S0(n7205), .D1(n7480), 
        .S1(\DTP/NPC2[7] ), .D2(\DTP/NPC[7] ), .S2(n7206), .D3(n7350), .S3(
        n7223), .Z(n7426) );
  HS65_LL_AOI21X2 U10242 ( .A(n7232), .B(n7231), .C(n7304), .Z(n7233) );
  HS65_LL_OAI21X3 U10243 ( .A(n103), .B(n7195), .C(n7475), .Z(n7476) );
  HS65_LL_AOI22X3 U10244 ( .A(n7205), .B(\DTP/ALUWB/N3 ), .C(n7206), .D(
        \DTP/NPCreg1/N3 ), .Z(n7472) );
  HS65_LL_AOI22X3 U10245 ( .A(n7205), .B(\DTP/ALUWB/N13 ), .C(n7345), .D(n7206), .Z(n7429) );
  HS65_LL_NAND2X4 U10246 ( .A(n7328), .B(n7206), .Z(n7288) );
  HS65_LL_NAND2AX7 U10247 ( .A(n7424), .B(\DTP/JAL_op2 ), .Z(n7214) );
  HS65_LL_AOI21X2 U10248 ( .A(IR[8]), .B(\DTP/NPC[8] ), .C(n7230), .Z(n7304)
         );
  HS65_LL_AOI21X2 U10249 ( .A(n7229), .B(n7228), .C(n7290), .Z(n7230) );
  HS65_LL_IVX4 U10250 ( .A(n7325), .Z(n7303) );
  HS65_LL_AOI21X6 U10251 ( .A(IR[7]), .B(\DTP/NPC[7] ), .C(n7227), .Z(n7290)
         );
  HS65_LL_NAND2X5 U10252 ( .A(IR[11]), .B(\DTP/NPC[11] ), .Z(n7237) );
  HS65_LL_IVX4 U10253 ( .A(n7216), .Z(n7349) );
  HS65_LL_IVX4 U10254 ( .A(n7217), .Z(n7418) );
  HS65_LL_IVX2 U10255 ( .A(\DTP/NPC[10] ), .Z(n7235) );
  HS65_LL_OAI12X3 U10256 ( .A(n7221), .B(n7225), .C(n7220), .Z(n7222) );
  HS65_LL_IVX4 U10257 ( .A(n7324), .Z(n7307) );
  HS65_LL_OAI21X3 U10258 ( .A(n7294), .B(n7219), .C(n7218), .Z(n7220) );
  HS65_LL_IVX2 U10259 ( .A(\DTP/NPC[9] ), .Z(n7231) );
  HS65_LL_OAI211X1 U10260 ( .A(\DTP/NPC[0] ), .B(IR[0]), .C(\intadd_0/CI ), 
        .D(n7350), .Z(n7200) );
  HS65_LL_IVX4 U10261 ( .A(n7327), .Z(n7293) );
  HS65_LL_OAI12X3 U10262 ( .A(n7276), .B(n7275), .C(n7274), .Z(n7277) );
  HS65_LL_NOR2X2 U10263 ( .A(n7350), .B(\DTP/JR_op1 ), .Z(n7421) );
  HS65_LL_OAI13X4 U10264 ( .A(n128), .B(\DTP/forward_branch2 ), .C(n7417), .D(
        n7416), .Z(n7422) );
  HS65_LL_IVX4 U10265 ( .A(\DTP/NPC[8] ), .Z(n7229) );
  HS65_LL_AOI22X4 U10266 ( .A(IR[6]), .B(\DTP/NPC[6] ), .C(n7276), .D(n7226), 
        .Z(n7218) );
  HS65_LL_IVX4 U10267 ( .A(n7396), .Z(n7420) );
  HS65_LL_IVX7 U10268 ( .A(n7488), .Z(\DTP/cnt/N1 ) );
  HS65_LL_NOR2X5 U10269 ( .A(n7483), .B(n7211), .Z(\DTP/RDreg1/N2 ) );
  HS65_LL_NOR2X5 U10270 ( .A(n7484), .B(n7211), .Z(\DTP/RDreg1/N3 ) );
  HS65_LL_NOR2X5 U10271 ( .A(n7486), .B(n7211), .Z(\DTP/RDreg1/N5 ) );
  HS65_LL_NOR2X5 U10272 ( .A(n7485), .B(n7210), .Z(\DTP/RDreg1/N4 ) );
  HS65_LL_NOR2X5 U10273 ( .A(n7487), .B(n7210), .Z(\DTP/RDreg1/N6 ) );
  HS65_LL_IVX2 U10274 ( .A(\intadd_0/n1 ), .Z(n7221) );
  HS65_LL_AOI212X2 U10275 ( .A(\DTP/Immediate_26_extended [12]), .B(n7371), 
        .C(n7384), .D(n7370), .E(n7369), .Z(n7484) );
  HS65_LL_AOI212X2 U10276 ( .A(\DTP/Immediate_26_extended [13]), .B(n7371), 
        .C(n7381), .D(n7370), .E(n7369), .Z(n7485) );
  HS65_LL_AOI212X2 U10277 ( .A(\DTP/Immediate_26_extended [14]), .B(n7371), 
        .C(n7372), .D(n7370), .E(n7369), .Z(n7486) );
  HS65_LL_AOI212X2 U10278 ( .A(\DTP/Immediate_26_extended [11]), .B(n7371), 
        .C(n7373), .D(n7370), .E(n7369), .Z(n7483) );
  HS65_LL_IVX4 U10279 ( .A(n7326), .Z(n7299) );
  HS65_LL_AOI212X2 U10280 ( .A(\DTP/Immediate_26_extended [15]), .B(n7371), 
        .C(n7387), .D(n7370), .E(n7369), .Z(n7487) );
  HS65_LL_NOR2X5 U10281 ( .A(IR[4]), .B(\DTP/NPC[4] ), .Z(n7294) );
  HS65_LL_OAI212X3 U10282 ( .A(n144), .B(n7381), .C(n7380), .D(n158), .E(n7379), .Z(n7382) );
  HS65_LL_NAND2X5 U10283 ( .A(IR[4]), .B(\DTP/NPC[4] ), .Z(n7295) );
  HS65_LL_NOR2X5 U10284 ( .A(n7209), .B(\intadd_0/B[2] ), .Z(\DTP/NPCreg1/N5 )
         );
  HS65_LL_AOI212X2 U10285 ( .A(n7378), .B(n157), .C(\DTP/RD1[0] ), .D(n160), 
        .E(n7377), .Z(n7379) );
  HS65_LL_NOR3X1 U10286 ( .A(\DTP/ALU_reg_out[30] ), .B(\DTP/ALU_reg_out[29] ), 
        .C(n7405), .Z(n7409) );
  HS65_LL_NAND3X3 U10287 ( .A(n80), .B(n112), .C(n7402), .Z(n7411) );
  HS65_LL_NOR3X1 U10288 ( .A(\DTP/ALU_reg_out[15] ), .B(\DTP/ALU_reg_out[14] ), 
        .C(n7407), .Z(n7408) );
  HS65_LL_OAI22X4 U10289 ( .A(n7367), .B(n142), .C(\DTP/RD1[0] ), .D(n155), 
        .Z(n7355) );
  HS65_LL_OAI22X3 U10290 ( .A(n7361), .B(n145), .C(n153), .D(\DTP/RD2[2] ), 
        .Z(n7360) );
  HS65_LL_NOR2X3 U10291 ( .A(n7423), .B(n7461), .Z(\DTP/ALU_REG/N26 ) );
  HS65_LL_NOR2X3 U10292 ( .A(n7423), .B(n7449), .Z(\DTP/ALU_REG/N22 ) );
  HS65_LL_NOR2X3 U10293 ( .A(n7423), .B(n7440), .Z(\DTP/ALU_REG/N19 ) );
  HS65_LL_NOR2X3 U10294 ( .A(n7423), .B(n7464), .Z(\DTP/ALU_REG/N27 ) );
  HS65_LL_NOR2X3 U10295 ( .A(n7423), .B(n7467), .Z(\DTP/ALU_REG/N28 ) );
  HS65_LL_NOR2X5 U10296 ( .A(n7423), .B(n7473), .Z(\DTP/ALU_REG/N3 ) );
  HS65_LL_NOR2X5 U10297 ( .A(n7423), .B(n7431), .Z(\DTP/ALU_REG/N13 ) );
  HS65_LL_NOR2X5 U10298 ( .A(n7423), .B(n7458), .Z(\DTP/ALU_REG/N25 ) );
  HS65_LL_OAI22X1 U10299 ( .A(n7378), .B(n157), .C(n160), .D(\DTP/RD1[0] ), 
        .Z(n7377) );
  HS65_LL_NOR2X3 U10300 ( .A(n7423), .B(n7455), .Z(\DTP/ALU_REG/N24 ) );
  HS65_LL_NOR2X3 U10301 ( .A(n7423), .B(n7471), .Z(\DTP/ALU_REG/N29 ) );
  HS65_LL_NOR2X5 U10302 ( .A(n7423), .B(n7443), .Z(\DTP/ALU_REG/N20 ) );
  HS65_LL_IVX7 U10303 ( .A(\DTP/cnt/i[0] ), .Z(\DTP/cnt/N2 ) );
  HS65_LL_AOI21X2 U10304 ( .A(n148), .B(n7389), .C(n149), .Z(n7392) );
  HS65_LL_NOR2X5 U10305 ( .A(n7423), .B(n7478), .Z(\DTP/ALU_REG/N7 ) );
  HS65_LL_NOR2X5 U10306 ( .A(n7423), .B(n7438), .Z(\DTP/ALU_REG/N18 ) );
  HS65_LL_IVX7 U10307 ( .A(n7352), .Z(n7314) );
  HS65_LL_NOR2X5 U10308 ( .A(n7423), .B(n7434), .Z(\DTP/ALU_REG/N16 ) );
  HS65_LL_NOR2X3 U10309 ( .A(PC[0]), .B(n7210), .Z(\DTP/NPCreg1/N4 ) );
  HS65_LL_NOR2X5 U10310 ( .A(n7423), .B(n7433), .Z(\DTP/ALU_REG/N15 ) );
  HS65_LL_NOR2X5 U10311 ( .A(n7423), .B(n7452), .Z(\DTP/ALU_REG/N23 ) );
  HS65_LL_IVX7 U10312 ( .A(n7351), .Z(n7282) );
  HS65_LL_NOR2X5 U10313 ( .A(n7423), .B(n7446), .Z(\DTP/ALU_REG/N21 ) );
  HS65_LL_NOR2X5 U10314 ( .A(n7423), .B(n7432), .Z(\DTP/ALU_REG/N14 ) );
  HS65_LL_OR3X4 U10315 ( .A(\DTP/PC_enable1 ), .B(\DTP/bootstrap ), .C(n7211), 
        .Z(\DTP/PC/N2 ) );
  HS65_LL_IVX7 U10316 ( .A(n142), .Z(n7386) );
  HS65_LL_IVX4 U10317 ( .A(n103), .Z(\DTP/ALU_reg_out[3] ) );
  HS65_LL_NOR2X3 U10318 ( .A(n140), .B(n7210), .Z(\DTP/RDreg2/N3 ) );
  HS65_LL_IVX7 U10319 ( .A(\DTP/JR_op1 ), .Z(n7213) );
  HS65_LL_IVX2 U10320 ( .A(n110), .Z(n7401) );
  HS65_LL_IVX4 U10321 ( .A(n93), .Z(\DTP/ALU_reg_out[10] ) );
  HS65_LL_NOR2X5 U10322 ( .A(n142), .B(n7210), .Z(\DTP/RDreg2/N6 ) );
  HS65_LL_IVX7 U10323 ( .A(n155), .Z(n7363) );
  HS65_LL_IVX7 U10324 ( .A(\DTP/RD2[0] ), .Z(n7376) );
  HS65_LL_NOR2X2 U10325 ( .A(n146), .B(n7211), .Z(\DTP/RDreg2/N5 ) );
  HS65_LL_NOR2X2 U10326 ( .A(\DTP/ALU_reg_out[26] ), .B(\DTP/ALU_reg_out[23] ), 
        .Z(n7404) );
  HS65_LL_NOR2X2 U10327 ( .A(\DTP/ALU_reg_out[21] ), .B(\DTP/ALU_reg_out[20] ), 
        .Z(n7403) );
  HS65_LL_IVX7 U10328 ( .A(\DTP/ALU_reg_out[7] ), .Z(n7425) );
  HS65_LL_NOR2X5 U10329 ( .A(\DTP/Instr_reg_out[31] ), .B(
        \DTP/Instr_reg_out[29] ), .Z(n7368) );
  HS65_LL_IVX7 U10330 ( .A(\DTP/NPC2[0] ), .Z(n7266) );
  HS65_LL_NOR2X5 U10331 ( .A(n144), .B(n7211), .Z(\DTP/RDreg2/N4 ) );
  HS65_LL_NOR2AX3 U10332 ( .A(n7217), .B(n7216), .Z(n7347) );
  HS65_LL_AND2X4 U10333 ( .A(n7212), .B(n7416), .Z(n7350) );
  HS65_LL_IVX9 U10334 ( .A(n7480), .Z(n7479) );
  HS65_LL_OAI21X3 U10335 ( .A(n7219), .B(n7295), .C(n7218), .Z(n7225) );
  HS65_LL_AND2X4 U10336 ( .A(Rst), .B(n7350), .Z(n7346) );
  HS65_LL_IVX9 U10337 ( .A(n7207), .Z(n7206) );
  HS65_LL_NAND2AX7 U10338 ( .A(n7197), .B(n7214), .Z(n7480) );
  HS65_LL_NOR4ABX2 U10339 ( .A(n7482), .B(n7413), .C(\DTP/ALU_reg_out[0] ), 
        .D(n7412), .Z(n7414) );
  HS65_LL_NOR4ABX2 U10340 ( .A(\DTP/Instr_reg_out[31] ), .B(
        \DTP/Instr_reg_out[29] ), .C(n7392), .D(n7391), .Z(n7394) );
  HS65_LL_NAND4ABX3 U10341 ( .A(IR[27]), .B(IR[30]), .C(IR[28]), .D(
        \DTP/PC_enable1 ), .Z(n7354) );
  HS65_LL_IVX9 U10342 ( .A(\DTP/JAL_op2 ), .Z(n7423) );
  HS65_LL_NOR4ABX2 U10343 ( .A(n148), .B(n7368), .C(n150), .D(n149), .Z(n7369)
         );
  HS65_LL_NAND4ABX3 U10344 ( .A(n7391), .B(n7389), .C(n149), .D(n7368), .Z(
        n7370) );
  HS65_LL_AND2X4 U10345 ( .A(\DTP/BRANCH_op1 ), .B(Rst), .Z(
        \DTP/BRANCH_opREG2/N2 ) );
  HS65_LL_IVX9 U10346 ( .A(n7347), .Z(n7207) );
  HS65_LL_IVX9 U10347 ( .A(n7346), .Z(n7317) );
  HS65_LL_NOR2X6 U10348 ( .A(n7210), .B(n7353), .Z(\DTP/IR/N17 ) );
  HS65_LL_NOR2X6 U10349 ( .A(IR[15]), .B(n7211), .Z(
        \DTP/forward_branchREG1/N2 ) );
  HS65_LL_IVX9 U10350 ( .A(\DTP/ALU_reg_out[4] ), .Z(n7477) );
  HS65_LL_NOR2X6 U10351 ( .A(n7211), .B(n7474), .Z(\DTP/ALUWB/N4 ) );
  HS65_LL_IVX9 U10352 ( .A(n157), .Z(n7372) );
  HS65_LL_IVX9 U10353 ( .A(n160), .Z(n7373) );
  HS65_LL_IVX9 U10354 ( .A(n7370), .Z(n7371) );
  HS65_LL_IVX9 U10355 ( .A(\sub_x_338/n47 ), .Z(\sub_x_338/n46 ) );
  HS65_LL_NAND2X7 U10356 ( .A(\DTP/NPC2[12] ), .B(Rst), .Z(n7432) );
  HS65_LL_NAND2X7 U10357 ( .A(\DTP/NPC2[14] ), .B(Rst), .Z(n7434) );
  HS65_LL_NAND2X7 U10358 ( .A(\DTP/NPC2[13] ), .B(Rst), .Z(n7433) );
  HS65_LL_NOR2X6 U10359 ( .A(n7211), .B(n7249), .Z(n7341) );
  HS65_LL_NAND2X7 U10360 ( .A(\DTP/NPC2[19] ), .B(Rst), .Z(n7446) );
  HS65_LL_NAND2X7 U10361 ( .A(\DTP/NPC2[5] ), .B(Rst), .Z(n7478) );
  HS65_LL_CB4I1X9 U10362 ( .A(\DTP/NPC2[3] ), .B(n7480), .C(n7476), .D(Rst), 
        .Z(\DTP/PC/N6 ) );
  HS65_LL_IVX9 U10363 ( .A(n7348), .Z(n7208) );
  HS65_LL_NAND2X7 U10364 ( .A(\DTP/NPC2[21] ), .B(Rst), .Z(n7452) );
  HS65_LL_NAND2X7 U10365 ( .A(\DTP/NPC2[20] ), .B(Rst), .Z(n7449) );
  HS65_LL_OAI211X5 U10366 ( .A(n7479), .B(n7464), .C(n7463), .D(n7462), .Z(
        \DTP/PC/N28 ) );
  HS65_LL_NOR2X6 U10367 ( .A(n112), .B(n7210), .Z(\DTP/ALUWB/N27 ) );
  HS65_LL_NAND2X7 U10368 ( .A(\DTP/NPC2[25] ), .B(Rst), .Z(n7464) );
  HS65_LL_OAI211X5 U10369 ( .A(n7479), .B(n7461), .C(n7460), .D(n7459), .Z(
        \DTP/PC/N27 ) );
  HS65_LL_NOR2X6 U10370 ( .A(n7209), .B(n7261), .Z(n7336) );
  HS65_LL_NOR2X6 U10371 ( .A(n69), .B(n7210), .Z(\DTP/ALUWB/N26 ) );
  HS65_LL_NAND2X7 U10372 ( .A(\DTP/NPC2[24] ), .B(Rst), .Z(n7461) );
  HS65_LL_NOR2X6 U10373 ( .A(n7209), .B(n7257), .Z(n7338) );
  HS65_LL_NOR2X6 U10374 ( .A(n72), .B(n7210), .Z(\DTP/ALUWB/N24 ) );
  HS65_LL_NAND2X7 U10375 ( .A(\DTP/NPC2[22] ), .B(Rst), .Z(n7455) );
  HS65_LL_IVX9 U10376 ( .A(n7279), .Z(n7481) );
  HS65_LL_NOR2X6 U10377 ( .A(n80), .B(n7210), .Z(\DTP/ALUWB/N20 ) );
  HS65_LL_NAND2X7 U10378 ( .A(\DTP/NPC2[18] ), .B(Rst), .Z(n7443) );
  HS65_LL_OAI211X5 U10379 ( .A(n7479), .B(n7438), .C(n7201), .D(n7437), .Z(
        \DTP/PC/N19 ) );
  HS65_LL_NAND2X7 U10380 ( .A(\DTP/NPC2[16] ), .B(Rst), .Z(n7438) );
  HS65_LL_NOR2X6 U10381 ( .A(n7209), .B(n7406), .Z(\DTP/ALUWB/N13 ) );
  HS65_LL_NAND2X7 U10382 ( .A(\DTP/NPC2[11] ), .B(Rst), .Z(n7431) );
  HS65_LL_OAI211X5 U10383 ( .A(n7479), .B(n7440), .C(n7203), .D(n7439), .Z(
        \DTP/PC/N20 ) );
  HS65_LL_NOR2X6 U10384 ( .A(n7210), .B(n7245), .Z(n7343) );
  HS65_LL_NOR2X6 U10385 ( .A(n83), .B(n7209), .Z(\DTP/ALUWB/N19 ) );
  HS65_LL_NAND2X7 U10386 ( .A(n7244), .B(n7243), .Z(n7241) );
  HS65_LL_NAND2X7 U10387 ( .A(\DTP/NPC2[17] ), .B(Rst), .Z(n7440) );
  HS65_LL_OAI211X5 U10388 ( .A(n7479), .B(n7458), .C(n7457), .D(n7456), .Z(
        \DTP/PC/N26 ) );
  HS65_LL_NAND2X7 U10389 ( .A(\DTP/NPC2[23] ), .B(Rst), .Z(n7458) );
  HS65_LL_OAI211X5 U10390 ( .A(n7479), .B(n7467), .C(n7466), .D(n7465), .Z(
        \DTP/PC/N29 ) );
  HS65_LL_NOR2X6 U10391 ( .A(n7211), .B(n7268), .Z(n7334) );
  HS65_LL_NAND2X7 U10392 ( .A(\DTP/NPC2[26] ), .B(Rst), .Z(n7467) );
  HS65_LL_OAI211X5 U10393 ( .A(n7194), .B(n7471), .C(n7470), .D(n7469), .Z(
        \DTP/PC/N30 ) );
  HS65_LL_NOR2X6 U10394 ( .A(n110), .B(n7209), .Z(\DTP/ALUWB/N29 ) );
  HS65_LL_IVX9 U10395 ( .A(Rst), .Z(n7209) );
  HS65_LL_IVX9 U10396 ( .A(n7195), .Z(n7204) );
  HS65_LL_NAND2X7 U10397 ( .A(\DTP/NPC2[27] ), .B(Rst), .Z(n7471) );
  HS65_LL_NAND2X7 U10398 ( .A(n7205), .B(n7320), .Z(n7313) );
  HS65_LL_NOR2X6 U10399 ( .A(\intadd_0/A[0] ), .B(n7211), .Z(\DTP/NPCreg1/N3 )
         );
  HS65_LL_NAND2X7 U10400 ( .A(\DTP/NPC2[1] ), .B(Rst), .Z(n7473) );
  HS65_LL_NAND2X7 U10401 ( .A(n7205), .B(n7330), .Z(n7281) );
  HS65_LL_NOR2X6 U10402 ( .A(n7209), .B(n124), .Z(n7330) );
  HS65_LL_IVX9 U10403 ( .A(n7195), .Z(n7205) );
  HS65_LL_OAI212X5 U10404 ( .A(n151), .B(n7375), .C(n7367), .D(n141), .E(n7366), .Z(n7397) );
  HS65_LL_AOI212X4 U10405 ( .A(n154), .B(n7374), .C(n7365), .D(n139), .E(n7364), .Z(n7366) );
  HS65_LL_OAI212X5 U10406 ( .A(n155), .B(\DTP/RD2[0] ), .C(n7363), .D(n7376), 
        .E(n7362), .Z(n7364) );
  HS65_LL_AOI212X4 U10407 ( .A(n7361), .B(n145), .C(\DTP/RD2[2] ), .D(n153), 
        .E(n7360), .Z(n7362) );
  HS65_LL_IVX9 U10408 ( .A(n139), .Z(n7374) );
  HS65_LL_IVX9 U10409 ( .A(n141), .Z(n7375) );
  HS65_LL_NAND2X7 U10410 ( .A(\DTP/JR_op1 ), .B(n7396), .Z(n7215) );
  HS65_LL_AOI22X6 U10411 ( .A(n7420), .B(n7419), .C(n7349), .D(n7418), .Z(
        n7424) );
  HS65_LL_NAND3AX6 U10412 ( .A(n7422), .B(n7271), .C(n7213), .Z(n7216) );
  HS65_LL_IVX9 U10413 ( .A(n7350), .Z(n7271) );
  HS65_LL_NAND3AX6 U10414 ( .A(n128), .B(\DTP/forward_branch2 ), .C(n7417), 
        .Z(n7217) );
  HS65_LL_IVX9 U10415 ( .A(\DTP/ALU_reg_out[9] ), .Z(n7427) );
  HS65_LL_IVX9 U10416 ( .A(\DTP/ALU_reg_out[11] ), .Z(n7406) );
  HS65_LL_IVX9 U10417 ( .A(n119), .Z(\DTP/ALU_reg_out[0] ) );
  HS65_LL_NOR3X4 U10418 ( .A(\DTP/ALU_reg_out[7] ), .B(\DTP/ALU_reg_out[5] ), 
        .C(n7400), .Z(n7413) );
  HS65_LL_IVX9 U10419 ( .A(\DTP/ALU_reg_out[2] ), .Z(n7474) );
  HS65_LL_IVX9 U10420 ( .A(\DTP/ALU_reg_out[6] ), .Z(n7482) );
  HS65_LL_NAND2X7 U10421 ( .A(\DTP/FWDBRANCH2/N2 ), .B(n7184), .Z(n7183) );
  HS65_LL_NAND2X7 U10422 ( .A(n111), .B(n109), .Z(n7189) );
  HS65_LL_NAND3X5 U10423 ( .A(n100), .B(n7179), .C(n7191), .Z(n7186) );
  HS65_LL_NAND3X5 U10424 ( .A(n88), .B(n86), .C(n7192), .Z(n7187) );
  HS65_LL_NAND3X5 U10425 ( .A(n70), .B(n68), .C(n7193), .Z(n7188) );
  HS65_LL_NAND2X7 U10426 ( .A(n7310), .B(n7309), .Z(n7312) );
  HS65_LL_NAND2X7 U10427 ( .A(n7269), .B(n7268), .Z(n7280) );
  HS65_LL_IVX9 U10428 ( .A(\DTP/NPC[26] ), .Z(n7268) );
  HS65_LL_NOR2X6 U10429 ( .A(n7264), .B(\DTP/NPC[25] ), .Z(n7269) );
  HS65_LL_NAND2X7 U10430 ( .A(n7262), .B(n7261), .Z(n7264) );
  HS65_LL_IVX9 U10431 ( .A(\DTP/NPC[24] ), .Z(n7261) );
  HS65_LL_NOR2X6 U10432 ( .A(n7259), .B(\DTP/NPC[23] ), .Z(n7262) );
  HS65_LL_NAND2X7 U10433 ( .A(n7255), .B(n7257), .Z(n7259) );
  HS65_LL_IVX9 U10434 ( .A(\DTP/NPC[22] ), .Z(n7257) );
  HS65_LL_NOR3X4 U10435 ( .A(\DTP/NPC[20] ), .B(n7254), .C(\DTP/NPC[21] ), .Z(
        n7255) );
  HS65_LL_NAND2X7 U10436 ( .A(n7250), .B(n7249), .Z(n7254) );
  HS65_LL_IVX9 U10437 ( .A(\DTP/NPC[19] ), .Z(n7249) );
  HS65_LL_NOR2X6 U10438 ( .A(\DTP/NPC[18] ), .B(n7247), .Z(n7250) );
  HS65_LL_NAND3X5 U10439 ( .A(n7245), .B(n7244), .C(n7243), .Z(n7247) );
  HS65_LL_NOR2X6 U10440 ( .A(\DTP/NPC[15] ), .B(\intadd_1/n1 ), .Z(n7243) );
  HS65_LL_CB4I1X9 U10441 ( .A(n7226), .B(n7273), .C(n7225), .D(n7224), .Z(
        n7227) );
  HS65_LL_IVX9 U10442 ( .A(n7226), .Z(n7219) );
  HS65_LL_NOR2X6 U10443 ( .A(n7294), .B(\intadd_0/n1 ), .Z(n7273) );
  HS65_LL_NAND2X7 U10444 ( .A(IR[0]), .B(\DTP/NPC[0] ), .Z(\intadd_0/CI ) );
  HS65_LL_IVX9 U10445 ( .A(IR[1]), .Z(\intadd_0/B[0] ) );
  HS65_LL_IVX9 U10446 ( .A(IR[2]), .Z(\intadd_0/A[1] ) );
  HS65_LL_IVX9 U10447 ( .A(\DTP/NPC[3] ), .Z(\intadd_0/B[2] ) );
  HS65_LL_IVX9 U10448 ( .A(IR[3]), .Z(\intadd_0/A[2] ) );
  HS65_LL_OA12X9 U10449 ( .A(IR[6]), .B(\DTP/NPC[6] ), .C(n7274), .Z(n7226) );
  HS65_LL_IVX9 U10450 ( .A(IR[8]), .Z(n7228) );
  HS65_LL_IVX9 U10451 ( .A(IR[9]), .Z(n7232) );
  HS65_LL_IVX9 U10452 ( .A(IR[10]), .Z(n7234) );
  HS65_LL_IVX9 U10453 ( .A(\DTP/NPC[16] ), .Z(n7244) );
  HS65_LL_IVX9 U10454 ( .A(\DTP/NPC[17] ), .Z(n7245) );
  HS65_LL_OAI212X5 U10455 ( .A(n152), .B(n7378), .C(n7361), .D(n146), .E(n7359), .Z(n7396) );
  HS65_LL_AOI212X4 U10456 ( .A(n154), .B(n7383), .C(n7365), .D(n140), .E(n7358), .Z(n7359) );
  HS65_LL_OAI212X5 U10457 ( .A(n153), .B(n7380), .C(n7357), .D(n144), .E(n7356), .Z(n7358) );
  HS65_LL_AOI212X4 U10458 ( .A(n7367), .B(n142), .C(n155), .D(\DTP/RD1[0] ), 
        .E(n7355), .Z(n7356) );
  HS65_LL_IVX9 U10459 ( .A(n151), .Z(n7367) );
  HS65_LL_IVX9 U10460 ( .A(n153), .Z(n7357) );
  HS65_LL_IVX9 U10461 ( .A(n154), .Z(n7365) );
  HS65_LL_IVX9 U10462 ( .A(n152), .Z(n7361) );
  HS65_LL_OAI212X5 U10463 ( .A(n142), .B(n7387), .C(n7386), .D(n156), .E(n7385), .Z(n7393) );
  HS65_LL_AOI212X4 U10464 ( .A(n140), .B(n7384), .C(n7383), .D(n159), .E(n7382), .Z(n7385) );
  HS65_LL_IVX9 U10465 ( .A(n146), .Z(n7378) );
  HS65_LL_IVX9 U10466 ( .A(n144), .Z(n7380) );
  HS65_LL_IVX9 U10467 ( .A(n158), .Z(n7381) );
  HS65_LL_IVX9 U10468 ( .A(n140), .Z(n7383) );
  HS65_LL_IVX9 U10469 ( .A(n159), .Z(n7384) );
  HS65_LL_IVX9 U10470 ( .A(n156), .Z(n7387) );
  HS65_LL_NAND2X7 U10471 ( .A(n148), .B(n7390), .Z(n7391) );
  HS65_LL_IVX9 U10472 ( .A(\DTP/Instr_reg_out[30] ), .Z(n7390) );
  HS65_LL_IVX9 U10473 ( .A(n150), .Z(n7389) );
  HS65_LL_IVX9 U10474 ( .A(IR[15]), .Z(n7353) );
  HS65_LL_NOR3X4 U10475 ( .A(IR[29]), .B(IR[31]), .C(n7354), .Z(n7395) );
  HS65_LLS_XNOR2X6 U10476 ( .A(n7311), .B(\DTP/NPC[31] ), .Z(n7285) );
  HS65_LLS_XOR2X6 U10477 ( .A(\add_x_320/n1 ), .B(PC[31]), .Z(\DTP/NPC[31] )
         );
  HS65_LL_AND2X4 U10478 ( .A(IR[12]), .B(Rst), .Z(\DTP/IR/N14 ) );
  HS65_LL_AND2X4 U10479 ( .A(IR[13]), .B(Rst), .Z(\DTP/IR/N15 ) );
  HS65_LL_AND2X4 U10480 ( .A(IR[22]), .B(Rst), .Z(\DTP/IR/N24 ) );
  HS65_LL_AND2X4 U10481 ( .A(IR[14]), .B(Rst), .Z(\DTP/IR/N16 ) );
  HS65_LL_AND2X4 U10482 ( .A(IR[23]), .B(Rst), .Z(\DTP/IR/N25 ) );
  HS65_LL_AND2X4 U10483 ( .A(IR[21]), .B(Rst), .Z(\DTP/IR/N23 ) );
  HS65_LL_AND2X4 U10484 ( .A(IR[29]), .B(Rst), .Z(\DTP/IR/N31 ) );
  HS65_LL_AND2X4 U10485 ( .A(IR[30]), .B(Rst), .Z(\DTP/IR/N32 ) );
  HS65_LL_AND2X4 U10486 ( .A(IR[24]), .B(Rst), .Z(\DTP/IR/N26 ) );
  HS65_LL_AND2X4 U10487 ( .A(IR[31]), .B(Rst), .Z(\DTP/IR/N33 ) );
  HS65_LL_AND2X4 U10488 ( .A(IR[28]), .B(Rst), .Z(\DTP/IR/N30 ) );
  HS65_LL_AND2X4 U10489 ( .A(IR[16]), .B(Rst), .Z(\DTP/IR/N18 ) );
  HS65_LL_AND2X4 U10490 ( .A(IR[18]), .B(Rst), .Z(\DTP/IR/N20 ) );
  HS65_LL_AND2X4 U10491 ( .A(IR[26]), .B(Rst), .Z(\DTP/IR/N28 ) );
  HS65_LL_AND2X4 U10492 ( .A(IR[19]), .B(Rst), .Z(\DTP/IR/N21 ) );
  HS65_LL_AND2X4 U10493 ( .A(IR[17]), .B(Rst), .Z(\DTP/IR/N19 ) );
  HS65_LL_AND2X4 U10494 ( .A(IR[25]), .B(Rst), .Z(\DTP/IR/N27 ) );
  HS65_LL_AND2X4 U10495 ( .A(IR[20]), .B(Rst), .Z(\DTP/IR/N22 ) );
  HS65_LL_AND2X4 U10496 ( .A(IR[11]), .B(Rst), .Z(\DTP/IR/N13 ) );
  HS65_LL_AND2X4 U10497 ( .A(\DTP/JAL_op1 ), .B(Rst), .Z(\DTP/JALreg2/N2 ) );
  HS65_LL_AND2X4 U10498 ( .A(\DTP/NPC1 [14]), .B(Rst), .Z(\DTP/NPCreg2/N16 )
         );
  HS65_LL_AND2X4 U10499 ( .A(\DTP/NPC1 [15]), .B(Rst), .Z(\DTP/NPCreg2/N17 )
         );
  HS65_LL_AND2X4 U10500 ( .A(\DTP/NPC1 [4]), .B(Rst), .Z(\DTP/NPCreg2/N6 ) );
  HS65_LL_AND2X4 U10501 ( .A(\DTP/NPC1 [0]), .B(Rst), .Z(\DTP/NPCreg2/N2 ) );
  HS65_LL_AND2X4 U10502 ( .A(\DTP/NPC1 [27]), .B(Rst), .Z(\DTP/NPCreg2/N29 )
         );
  HS65_LL_AND2X4 U10503 ( .A(\DTP/NPC1 [6]), .B(Rst), .Z(\DTP/NPCreg2/N8 ) );
  HS65_LL_AND2X4 U10504 ( .A(\DTP/NPC1 [21]), .B(Rst), .Z(\DTP/NPCreg2/N23 )
         );
  HS65_LL_AND2X4 U10505 ( .A(\DTP/NPC1 [18]), .B(Rst), .Z(\DTP/NPCreg2/N20 )
         );
  HS65_LL_AND2X4 U10506 ( .A(\DTP/NPC1 [23]), .B(Rst), .Z(\DTP/NPCreg2/N25 )
         );
  HS65_LL_AND2X4 U10507 ( .A(\DTP/NPC1 [24]), .B(Rst), .Z(\DTP/NPCreg2/N26 )
         );
  HS65_LL_AND2X4 U10508 ( .A(\DTP/NPC1 [25]), .B(Rst), .Z(\DTP/NPCreg2/N27 )
         );
  HS65_LL_AND2X4 U10509 ( .A(\DTP/NPC1 [7]), .B(Rst), .Z(\DTP/NPCreg2/N9 ) );
  HS65_LL_AND2X4 U10510 ( .A(\DTP/NPC1 [22]), .B(Rst), .Z(\DTP/NPCreg2/N24 )
         );
  HS65_LL_AND2X4 U10511 ( .A(\DTP/NPC1 [8]), .B(Rst), .Z(\DTP/NPCreg2/N10 ) );
  HS65_LL_AND2X4 U10512 ( .A(\DTP/NPC1 [29]), .B(Rst), .Z(\DTP/NPCreg2/N31 )
         );
  HS65_LL_AND2X4 U10513 ( .A(\DTP/NPC1 [3]), .B(Rst), .Z(\DTP/NPCreg2/N5 ) );
  HS65_LL_AND2X4 U10514 ( .A(\DTP/NPC1 [12]), .B(Rst), .Z(\DTP/NPCreg2/N14 )
         );
  HS65_LL_AND2X4 U10515 ( .A(\DTP/NPC1 [9]), .B(Rst), .Z(\DTP/NPCreg2/N11 ) );
  HS65_LL_AND2X4 U10516 ( .A(\DTP/NPC1 [26]), .B(Rst), .Z(\DTP/NPCreg2/N28 )
         );
  HS65_LL_AND2X4 U10517 ( .A(\DTP/NPC1 [30]), .B(Rst), .Z(\DTP/NPCreg2/N32 )
         );
  HS65_LL_AND2X4 U10518 ( .A(\DTP/NPC1 [20]), .B(Rst), .Z(\DTP/NPCreg2/N22 )
         );
  HS65_LL_AND2X4 U10519 ( .A(\DTP/NPC1 [10]), .B(Rst), .Z(\DTP/NPCreg2/N12 )
         );
  HS65_LL_AND2X4 U10520 ( .A(\DTP/NPC1 [1]), .B(Rst), .Z(\DTP/NPCreg2/N3 ) );
  HS65_LL_AND2X4 U10521 ( .A(\DTP/NPC1 [5]), .B(Rst), .Z(\DTP/NPCreg2/N7 ) );
  HS65_LL_AND2X4 U10522 ( .A(\DTP/NPC1 [19]), .B(Rst), .Z(\DTP/NPCreg2/N21 )
         );
  HS65_LL_AND2X4 U10523 ( .A(\DTP/NPC1 [2]), .B(Rst), .Z(\DTP/NPCreg2/N4 ) );
  HS65_LL_AND2X4 U10524 ( .A(\DTP/NPC1 [11]), .B(Rst), .Z(\DTP/NPCreg2/N13 )
         );
  HS65_LL_AND2X4 U10525 ( .A(\DTP/NPC1 [17]), .B(Rst), .Z(\DTP/NPCreg2/N19 )
         );
  HS65_LL_AND2X4 U10526 ( .A(\DTP/NPC1 [28]), .B(Rst), .Z(\DTP/NPCreg2/N30 )
         );
  HS65_LL_AND2X4 U10527 ( .A(\DTP/NPC1 [13]), .B(Rst), .Z(\DTP/NPCreg2/N15 )
         );
  HS65_LL_AND2X4 U10528 ( .A(\DTP/forward_branch1 ), .B(Rst), .Z(
        \DTP/forward_branchREG2/N2 ) );
  HS65_LL_AND2X4 U10529 ( .A(\DTP/NPC1 [31]), .B(Rst), .Z(\DTP/NPCreg2/N33 )
         );
  HS65_LL_AND2X4 U10530 ( .A(\DTP/NPC1 [16]), .B(Rst), .Z(\DTP/NPCreg2/N18 )
         );
  HS65_LL_AND2X4 U10531 ( .A(Rst), .B(\DTP/NPC[0] ), .Z(\DTP/NPCreg1/N2 ) );
  HS65_LL_AND2X4 U10532 ( .A(\DTP/RD1[0] ), .B(Rst), .Z(\DTP/RDreg2/N2 ) );
  HS65_LL_NOR2AX3 U10533 ( .A(IR[30]), .B(n7388), .Z(\DTP/JRreg1/N2 ) );
  HS65_LL_NOR2AX3 U10534 ( .A(IR[26]), .B(n7388), .Z(\DTP/JALreg1/N2 ) );
  HS65_LL_AND2X4 U10535 ( .A(IR[27]), .B(Rst), .Z(\DTP/IR/N29 ) );
  HS65_LL_AND2X4 U10536 ( .A(\DTP/NPCreg3/N5 ), .B(\DTP/JAL_op2 ), .Z(
        \DTP/ALU_REG/N5 ) );
  HS65_LL_AND2X4 U10537 ( .A(\DTP/NPC2[3] ), .B(Rst), .Z(\DTP/NPCreg3/N5 ) );
  HS65_LL_AND2X4 U10538 ( .A(n7351), .B(\DTP/JAL_op2 ), .Z(\DTP/ALU_REG/N33 )
         );
  HS65_LL_AND2X4 U10539 ( .A(\DTP/NPCreg3/N12 ), .B(\DTP/JAL_op2 ), .Z(
        \DTP/ALU_REG/N12 ) );
  HS65_LL_AND2X4 U10540 ( .A(\DTP/NPC2[10] ), .B(Rst), .Z(\DTP/NPCreg3/N12 )
         );
  HS65_LL_AND2X4 U10541 ( .A(\DTP/NPCreg3/N2 ), .B(\DTP/JAL_op2 ), .Z(
        \DTP/ALU_REG/N2 ) );
  HS65_LL_AND2X4 U10542 ( .A(\DTP/NPC2[0] ), .B(Rst), .Z(\DTP/NPCreg3/N2 ) );
  HS65_LL_AND2X4 U10543 ( .A(\DTP/NPCreg3/N10 ), .B(\DTP/JAL_op2 ), .Z(
        \DTP/ALU_REG/N10 ) );
  HS65_LL_AND2X4 U10544 ( .A(\DTP/NPC2[8] ), .B(Rst), .Z(\DTP/NPCreg3/N10 ) );
  HS65_LL_AND2X4 U10545 ( .A(n7352), .B(\DTP/JAL_op2 ), .Z(\DTP/ALU_REG/N32 )
         );
  HS65_LL_AND2X4 U10546 ( .A(\DTP/NPCreg3/N11 ), .B(\DTP/JAL_op2 ), .Z(
        \DTP/ALU_REG/N11 ) );
  HS65_LL_AND2X4 U10547 ( .A(\DTP/NPC2[9] ), .B(Rst), .Z(\DTP/NPCreg3/N11 ) );
  HS65_LL_AND2X4 U10548 ( .A(\DTP/NPCreg3/N31 ), .B(\DTP/JAL_op2 ), .Z(
        \DTP/ALU_REG/N31 ) );
  HS65_LL_AND2X4 U10549 ( .A(\DTP/NPCreg3/N30 ), .B(\DTP/JAL_op2 ), .Z(
        \DTP/ALU_REG/N30 ) );
  HS65_LL_AND2X4 U10550 ( .A(n7395), .B(Rst), .Z(\DTP/BRANCH_opREG1/N2 ) );
  HS65_LL_AND2X4 U10551 ( .A(Rst), .B(\DTP/NPC[6] ), .Z(\DTP/NPCreg1/N8 ) );
  HS65_LL_AND2X4 U10552 ( .A(Rst), .B(\DTP/NPC[7] ), .Z(\DTP/NPCreg1/N9 ) );
  HS65_LL_NOR2AX3 U10553 ( .A(\DTP/BRANCH_opREG2/N2 ), .B(n7397), .Z(
        \DTP/FWDBRANCH2/N2 ) );
  HS65_LL_AND2X4 U10554 ( .A(Rst), .B(\DTP/NPC[15] ), .Z(\DTP/NPCreg1/N17 ) );
  HS65_LL_AND2X4 U10555 ( .A(\DTP/BRANCH_opREG2/N2 ), .B(n7420), .Z(
        \DTP/FWDBRANCH1/N2 ) );
  HS65_LL_OAI222X2 U10556 ( .A(n7299), .B(n7207), .C(n7209), .D(n7298), .E(
        n7317), .F(n7297), .Z(\DTP/PC/N7 ) );
  HS65_LLS_XOR2X6 U10557 ( .A(n7296), .B(\intadd_0/n1 ), .Z(n7297) );
  HS65_LL_NOR2AX3 U10558 ( .A(n7295), .B(n7294), .Z(n7296) );
  HS65_LL_AND2X4 U10559 ( .A(Rst), .B(\DTP/NPC[4] ), .Z(n7326) );
  HS65_LL_OAI222X2 U10560 ( .A(n7307), .B(n7207), .C(n7211), .D(n7306), .E(
        n7317), .F(n7305), .Z(\DTP/PC/N12 ) );
  HS65_LLS_XOR3X2 U10561 ( .A(IR[9]), .B(\DTP/NPC[9] ), .C(n7304), .Z(n7305)
         );
  HS65_LL_AND2X4 U10562 ( .A(Rst), .B(\DTP/NPC[9] ), .Z(n7324) );
  HS65_LL_OAI222X2 U10563 ( .A(n7293), .B(n7207), .C(n7209), .D(n7292), .E(
        n7317), .F(n7291), .Z(\DTP/PC/N11 ) );
  HS65_LLS_XOR3X2 U10564 ( .A(\DTP/NPC[8] ), .B(IR[8]), .C(n7290), .Z(n7291)
         );
  HS65_LL_AND2X4 U10565 ( .A(Rst), .B(\DTP/NPC[8] ), .Z(n7327) );
  HS65_LL_OAI222X2 U10566 ( .A(n7303), .B(n7207), .C(n7210), .D(n7302), .E(
        n7317), .F(n7301), .Z(\DTP/PC/N13 ) );
  HS65_LLS_XOR3X2 U10567 ( .A(\DTP/NPC[10] ), .B(IR[10]), .C(n7300), .Z(n7301)
         );
  HS65_LL_AND2X4 U10568 ( .A(Rst), .B(\DTP/NPC[10] ), .Z(n7325) );
  HS65_LL_AND2X4 U10569 ( .A(Rst), .B(\DTP/NPC[12] ), .Z(n7328) );
  HS65_LL_AND2X4 U10570 ( .A(\DTP/ALU_reg_out[12] ), .B(Rst), .Z(
        \DTP/ALUWB/N14 ) );
  HS65_LL_AND2X4 U10571 ( .A(Rst), .B(\DTP/NPC[14] ), .Z(n7329) );
  HS65_LL_AND2X4 U10572 ( .A(\DTP/ALU_reg_out[14] ), .B(Rst), .Z(
        \DTP/ALUWB/N16 ) );
  HS65_LL_AND2X4 U10573 ( .A(Rst), .B(\DTP/NPC[13] ), .Z(n7319) );
  HS65_LL_AND2X4 U10574 ( .A(\DTP/ALU_reg_out[13] ), .B(Rst), .Z(
        \DTP/ALUWB/N15 ) );
  HS65_LL_AOI222X2 U10575 ( .A(n7480), .B(\DTP/NPC2[15] ), .C(n7204), .D(
        \DTP/ALU_reg_out[15] ), .E(n7347), .F(\DTP/NPC[15] ), .Z(n7435) );
  HS65_LLS_XNOR2X6 U10576 ( .A(\DTP/NPC[15] ), .B(\intadd_1/n1 ), .Z(n7240) );
  HS65_LL_AND2X4 U10577 ( .A(\DTP/ALU_reg_out[19] ), .B(Rst), .Z(
        \DTP/ALUWB/N21 ) );
  HS65_LL_AND2X4 U10578 ( .A(Rst), .B(\DTP/NPC[5] ), .Z(n7332) );
  HS65_LL_AND2X4 U10579 ( .A(\DTP/ALU_reg_out[5] ), .B(Rst), .Z(\DTP/ALUWB/N7 ) );
  HS65_LL_AND2X4 U10580 ( .A(Rst), .B(\DTP/NPC[21] ), .Z(n7339) );
  HS65_LL_AND2X4 U10581 ( .A(\DTP/ALU_reg_out[21] ), .B(Rst), .Z(
        \DTP/ALUWB/N23 ) );
  HS65_LLS_XNOR2X6 U10582 ( .A(n7254), .B(\DTP/NPC[20] ), .Z(n7251) );
  HS65_LL_AND2X4 U10583 ( .A(\DTP/ALU_reg_out[20] ), .B(Rst), .Z(
        \DTP/ALUWB/N22 ) );
  HS65_LL_AND2X4 U10584 ( .A(Rst), .B(\DTP/NPC[25] ), .Z(n7335) );
  HS65_LLS_XNOR2X6 U10585 ( .A(n7264), .B(\DTP/NPC[25] ), .Z(n7263) );
  HS65_LL_AND2X4 U10586 ( .A(Rst), .B(\DTP/NPC[28] ), .Z(n7323) );
  HS65_LL_AND2X4 U10587 ( .A(\DTP/ALU_reg_out[28] ), .B(Rst), .Z(
        \DTP/ALUWB/N30 ) );
  HS65_LL_AND2X4 U10588 ( .A(\DTP/NPC2[28] ), .B(Rst), .Z(\DTP/NPCreg3/N30 )
         );
  HS65_LLS_XNOR3X2 U10589 ( .A(\DTP/NPC[6] ), .B(IR[6]), .C(n7277), .Z(n7278)
         );
  HS65_LL_AND2X4 U10590 ( .A(Rst), .B(\DTP/NPC[18] ), .Z(n7342) );
  HS65_LLS_XNOR2X6 U10591 ( .A(\DTP/NPC[18] ), .B(n7247), .Z(n7246) );
  HS65_LL_AND2X4 U10592 ( .A(Rst), .B(\DTP/NPC[16] ), .Z(n7344) );
  HS65_LL_AND2X4 U10593 ( .A(\DTP/ALU_reg_out[16] ), .B(Rst), .Z(
        \DTP/ALUWB/N18 ) );
  HS65_LL_AND2X4 U10594 ( .A(Rst), .B(\DTP/NPC[11] ), .Z(n7345) );
  HS65_LLS_XOR2X6 U10595 ( .A(n7238), .B(n7239), .Z(n7428) );
  HS65_LLS_XNOR2X6 U10596 ( .A(n7245), .B(n7241), .Z(n7242) );
  HS65_LL_AND2X4 U10597 ( .A(Rst), .B(\DTP/NPC[23] ), .Z(n7337) );
  HS65_LL_AND2X4 U10598 ( .A(\DTP/ALU_reg_out[23] ), .B(Rst), .Z(
        \DTP/ALUWB/N25 ) );
  HS65_LLS_XNOR2X6 U10599 ( .A(n7259), .B(\DTP/NPC[23] ), .Z(n7258) );
  HS65_LL_AND2X4 U10600 ( .A(\DTP/ALU_reg_out[26] ), .B(Rst), .Z(
        \DTP/ALUWB/N28 ) );
  HS65_LLS_XNOR2X6 U10601 ( .A(n7222), .B(n7224), .Z(n7223) );
  HS65_LL_NOR3AX2 U10602 ( .A(n7397), .B(n7215), .C(n7350), .Z(n7348) );
  HS65_LL_AND2X4 U10603 ( .A(Rst), .B(\DTP/NPC[27] ), .Z(n7333) );
  HS65_LLS_XNOR2X6 U10604 ( .A(n7280), .B(\DTP/NPC[27] ), .Z(n7270) );
  HS65_LL_AND2X4 U10605 ( .A(\DTP/ALU_reg_out[29] ), .B(Rst), .Z(
        \DTP/ALUWB/N31 ) );
  HS65_LL_AND2X4 U10606 ( .A(\DTP/NPC2[29] ), .B(Rst), .Z(\DTP/NPCreg3/N31 )
         );
  HS65_LL_AND2X4 U10607 ( .A(Rst), .B(\DTP/NPC[29] ), .Z(n7322) );
  HS65_LL_AOI12X2 U10608 ( .A(n7347), .B(n7321), .C(n7315), .Z(n7316) );
  HS65_LL_AND2X4 U10609 ( .A(Rst), .B(\DTP/ALU_reg_out[30] ), .Z(n7320) );
  HS65_LL_AND2X4 U10610 ( .A(Rst), .B(\DTP/NPC2[30] ), .Z(n7352) );
  HS65_LL_AND2X4 U10611 ( .A(Rst), .B(\DTP/NPC[30] ), .Z(n7321) );
  HS65_LL_AND2X4 U10612 ( .A(\DTP/ALU_reg_out[1] ), .B(Rst), .Z(\DTP/ALUWB/N3 ) );
  HS65_LL_AOI12X2 U10613 ( .A(n7347), .B(n7331), .C(n7283), .Z(n7284) );
  HS65_LL_OR3X9 U10614 ( .A(n7215), .B(n7397), .C(n7350), .Z(n7195) );
  HS65_LL_NOR2AX3 U10615 ( .A(\DTP/JR_op1 ), .B(n7350), .Z(n7419) );
  HS65_LL_AND2X4 U10616 ( .A(Rst), .B(\DTP/NPC2[31] ), .Z(n7351) );
  HS65_LL_NOR2AX3 U10617 ( .A(\DTP/NPC[31] ), .B(n7209), .Z(n7331) );
  HS65_LL_MUXI21X2 U10618 ( .D0(n7415), .D1(n7414), .S0(\DTP/FWD_exe_branch1 ), 
        .Z(n7417) );
  HS65_LL_NAND4ABX3 U10619 ( .A(n7411), .B(n7410), .C(n69), .D(n83), .Z(n7412)
         );
  HS65_LL_NAND4ABX3 U10620 ( .A(\DTP/ALU_reg_out[16] ), .B(
        \DTP/ALU_reg_out[19] ), .C(n7409), .D(n7408), .Z(n7410) );
  HS65_LL_NAND4ABX3 U10621 ( .A(\DTP/ALU_reg_out[13] ), .B(
        \DTP/ALU_reg_out[12] ), .C(n7406), .D(n7427), .Z(n7407) );
  HS65_LL_NAND4ABX3 U10622 ( .A(\DTP/ALU_reg_out[28] ), .B(
        \DTP/ALU_reg_out[1] ), .C(n7404), .D(n7403), .Z(n7405) );
  HS65_LL_NOR4ABX2 U10623 ( .A(n72), .B(n124), .C(n7401), .D(
        \DTP/ALU_reg_out[8] ), .Z(n7402) );
  HS65_LL_NAND4ABX3 U10624 ( .A(\DTP/ALU_reg_out[4] ), .B(\DTP/ALU_reg_out[3] ), .C(n7474), .D(n93), .Z(n7400) );
  HS65_LL_NAND4ABX3 U10625 ( .A(n7188), .B(n7399), .C(n66), .D(n65), .Z(n7184)
         );
  HS65_LL_NAND4ABX3 U10626 ( .A(n7187), .B(n7185), .C(n85), .D(n82), .Z(n7399)
         );
  HS65_LL_NAND4ABX3 U10627 ( .A(n7186), .B(n7398), .C(n7175), .D(n7180), .Z(
        n7185) );
  HS65_LL_NAND4ABX3 U10628 ( .A(n7189), .B(n7190), .C(n108), .D(n107), .Z(
        n7398) );
  HS65_LL_NAND4ABX3 U10629 ( .A(n7182), .B(\DTP/ALUWB/N22 ), .C(n7173), .D(
        n123), .Z(n7190) );
  HS65_LL_NOR4ABX2 U10630 ( .A(n7176), .B(n105), .C(n7181), .D(\DTP/ALUWB/N4 ), 
        .Z(n7191) );
  HS65_LL_NOR4ABX2 U10631 ( .A(n91), .B(n7177), .C(\DTP/ALUWB/N14 ), .D(n7174), 
        .Z(n7192) );
  HS65_LL_NOR4ABX2 U10632 ( .A(n74), .B(n79), .C(\DTP/ALUWB/N24 ), .D(
        \DTP/ALUWB/N21 ), .Z(n7193) );
  HS65_LLS_XOR2X6 U10633 ( .A(IR[7]), .B(\DTP/NPC[7] ), .Z(n7224) );
  HS65_LL_AND2X4 U10634 ( .A(IR[5]), .B(\DTP/NPC[5] ), .Z(n7276) );
  HS65_LLS_XNOR2X6 U10635 ( .A(IR[11]), .B(\DTP/NPC[11] ), .Z(n7239) );
  HS65_LL_CB4I6X9 U10636 ( .A(n7394), .B(n7393), .C(n7396), .D(n127), .Z(n7416) );
  HS65_LL_NOR2AX3 U10637 ( .A(n7395), .B(n7353), .Z(n7212) );
  HS65_LL_AND2X4 U10638 ( .A(n7422), .B(n7421), .Z(n7197) );
  HS65_LL_AND2X4 U10639 ( .A(n7205), .B(\DTP/ALUWB/N16 ), .Z(n7198) );
  HS65_LL_AND2X4 U10640 ( .A(n7205), .B(\DTP/ALUWB/N14 ), .Z(n7199) );
  HS65_LL_CB4I6X9 U10641 ( .A(n7243), .B(n7244), .C(n7241), .D(n7317), .Z(
        n7201) );
  HS65_LL_OR2X9 U10642 ( .A(\intadd_0/SUM[0] ), .B(n7317), .Z(n7202) );
  HS65_LL_OR2X9 U10643 ( .A(n7317), .B(n7242), .Z(n7203) );
  HS65_LL_IVX9 U10644 ( .A(Rst), .Z(n7211) );
  HS65_LL_IVX9 U10645 ( .A(Rst), .Z(n7210) );
endmodule

