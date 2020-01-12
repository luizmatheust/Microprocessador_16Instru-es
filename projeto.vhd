LIBRARY IEEE;
USE IEEE.STD_logic_1164.all;
USE WORK.ALL;

ENTITY projeto IS  
PORT( 
		-- ENTRADAS DE 1 BIT
		ld_Rin, clk, exec_inst, reset: IN STD_logic; 
		-- ENTRADA DE DADOS
		De: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		-- SAÍDA DE DADOS
		Ds: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		-- SINALIZAÇÃO VISUAL DE EXECUÇÃO DE INSTRUÇÃO
		exec_ed: OUT STD_LOGIC; 
		
		TESTE: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
);
END projeto;

ARCHITECTURE arch OF projeto IS

		--Sinais de Conexão entre Datapath e Controlador
		--Sinais de Load em Registradores
		SIGNAL ld_Raux, ld_IR, ld_Ra, ld_Rb, ld_Rc, ld_Rd, ld_Rout: STD_LOGIC;
		-- Clear All do Controlador para Datapath
		SIGNAL CLEAR_ALL: STD_LOGIC; 

		--Seletores de ALU e Multiplexadores
		SIGNAL Sel_Mux_0: STD_LOGIC_VECTOR(2 DOWNTO 0);
		SIGNAL Sel_Mux_1: STD_LOGIC_VECTOR(1 DOWNTO 0);
		SIGNAL Sel_Mux_2: STD_LOGIC_VECTOR(1 DOWNTO 0);
		SIGNAL Sel_ALU: STD_LOGIC_VECTOR(2 DOWNTO 0); 

		--Instrução para Controlador
		SIGNAL INST: STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN
		--Instanciando Datapath
		dtp_fsm: datapath PORT MAP(ld_Raux, ld_IR, ld_Ra, ld_Rb, ld_Rc, ld_Rd, ld_Rout,ld_Rin, Sel_Mux_0, Sel_Mux_1, Sel_Mux_2, Sel_ALU, De, Ds, INST, NOT reset, clk, TESTE); 
		--Instanciando Controlador
		controller: controlador PORT MAP(clk, NOT reset, ld_Raux, ld_IR, ld_Ra, ld_Rb, ld_Rc, ld_Rd, ld_Rout, Sel_Mux_0, Sel_Mux_1, Sel_Mux_2, Sel_ALU, INST, exec_inst, exec_ed);
END arch;