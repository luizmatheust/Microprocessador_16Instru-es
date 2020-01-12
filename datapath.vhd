LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE WORK.ALL;

ENTITY datapath IS
PORT(
		--Sinais de Controle dos Registradores do Datapath
		ld_Raux, ld_IR, ld_Ra, ld_Rb, ld_Rc, ld_Rd, ld_Rout,ld_Rin: IN STD_LOGIC; 
		
		--Sinais de controle dos Multiplexadores do Datapath
		Sel_Mux_0: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		Sel_Mux_1: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		Sel_Mux_2: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		
		--Sinais de controle da ALU do Datapath
		Sel_ALU: IN STD_LOGIC_VECTOR(2 DOWNTO 0); 
		
		--Sinais de Entrada do Datapath
		De: IN STD_LOGIC_VECTOR(15 DOWNTO 0); 
		
		--Sinais de Saída do Datapath
		Ds: OUT STD_LOGIC_VECTOR(15 DOWNTO 0); 
		INST: OUT STD_LOGIC_VECTOR(7 DOWNTO 0); 
		
		--Sinais Supremos
		clr_all, clk: IN STD_LOGIC;
		
		TESTE: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
);
END datapath;

ARCHITECTURE arch OF datapath IS
SIGNAL reg_in_out, reg_aux_out, m0_out, m1_out, m2_out, alu_out, reg_a_out, reg_b_out, reg_c_out, reg_d_out: STD_LOGIC_VECTOR(15 DOWNTO 0);

BEGIN
	--Registradores de Entrada de Dados e Instruções
	--                           IN      OUT        CLR   CLK    Load
	reg_in: registrador PORT MAP(De, reg_in_out, clr_all, clk, ld_Rin);
	reg_aux: registrador PORT MAP("00000000" & De(7 DOWNTO 0), reg_aux_out, clr_all, clk, ld_Raux); 
	reg_IR:  registrador8 PORT MAP(De(15 DOWNTO 8), INST, clr_all, clk, ld_IR);
	
	--Multiplexador das Entradas de Dados
	m0: mux8 PORT MAP(reg_in_out, reg_aux_out, m1_out, alu_out, x"0000", x"0000", x"0000", x"0000", m0_out, Sel_Mux_0); --
	
	--Registradores de Armazenamento de Dados
	--                           IN      OUT        CLR   CLK    Load
	reg_a: registrador PORT MAP(m0_out, reg_a_out, clr_all, clk, ld_Ra); --
	reg_b: registrador PORT MAP(m0_out, reg_b_out, clr_all, clk, ld_Rb);
	reg_c: registrador PORT MAP(m0_out, reg_c_out, clr_all, clk, ld_Rc);
	reg_d: registrador PORT MAP(m0_out, reg_d_out, clr_all, clk, ld_Rd);
	
	--Multiplexadores de Manipulação de Dados
	m1: mux2 PORT MAP(reg_a_out, reg_b_out, reg_c_out, reg_d_out, m1_out, Sel_Mux_1);--m1_out
	m2: mux2 PORT MAP(reg_a_out, reg_b_out, reg_c_out, reg_d_out, m2_out, Sel_Mux_2);
	
	--Unidade Lógico-Aritmética
	alu_final: alu PORT MAP(m1_out, m2_out, alu_out, Sel_ALU);
	
	--Registrador de Saída e Exibição de Dados
	--                              IN   OUT    CLR    CLK  Load
	reg_out: registrador PORT MAP(m1_out, Ds, clr_all, clk, ld_Rout);
	
	t : process(reg_b_out) is
	BEGIN
		TESTE <= reg_b_out;
	END PROCESS;
	
END arch;