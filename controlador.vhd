LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY controlador IS
port(
	-- Sinais Supremos
	clock, reset: IN STD_LOGIC;
	
	--Saida Suprema
	--clear: OUT STD_LOGIC; --OK1
	
	--Sinais de Controle dos Registadores do Datapath.
	ld_Raux, ld_IR, ld_Ra, ld_Rb, ld_Rc, ld_Rd, ld_Rout: OUT STD_LOGIC; --OK2
	
	--Sinais de controle dos Multiplexadores do Datapath
	Sel_Mux_0: OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
	Sel_Mux_1: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
	Sel_Mux_2: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
	
	--Sinais de controle da ALU do Datapath
	Sel_ALU: OUT STD_LOGIC_VECTOR(2 DOWNTO 0); --OK3 
	
	--INSTRUÇÃO PROVENIENTE DO REGISTRADOR DE INSTRUÇÃO
	INST: IN STD_LOGIC_VECTOR(7 DOWNTO 0); --OK4
	
	--Botão para executar instrução
	INST_EXEC: IN STD_LOGIC;
	
	--LED para demonstrar execução da instrução
	INST_EXEC_SIG: OUT STD_LOGIC
);
END controlador;

ARCHITECTURE arch OF controlador IS
TYPE estado IS (INICIO, BUSCA, DECODIFICA,SOMA, SUBTRAI, E, OU, NAO, NOU, MOV, LD, ST, ENTRA, SAI, MVI, JMP, JZ, NOP);
SIGNAL estado_atual : estado;

BEGIN
	maquina : PROCESS(clock, reset)
	BEGIN 
	IF(reset = '1') THEN
			estado_atual <= INICIO;
	ELSIF(clock'EVENT AND clock = '1') THEN
	CASE estado_atual IS
		WHEN INICIO =>
			estado_atual <= BUSCA; 
		WHEN BUSCA =>
			IF(INST_EXEC = '1') THEN 
				estado_atual <= DECODIFICA;
			ELSE
				estado_atual <= BUSCA;
			END IF;
		WHEN DECODIFICA =>
			IF(INST(7 DOWNTO 4) = "0000") THEN
				estado_atual <= SOMA;
			ELSIF(INST(7 DOWNTO 4) = "0001") THEN
				estado_atual <= SUBTRAI;
			ELSIF(INST(7 DOWNTO 4) = "0010") THEN
				estado_atual <= E;
			ELSIF(INST(7 DOWNTO 4) = "0011") THEN
				estado_atual <= OU;
			ELSIF(INST(7 DOWNTO 4) = "0100") THEN
				estado_atual <= NAO;
			ELSIF(INST(7 DOWNTO 4) = "0101") THEN
				estado_atual <= NOU;
			ELSIF(INST(7 DOWNTO 4) = "0110") THEN
				estado_atual <= MOV;
			ELSIF(INST(7 DOWNTO 4) = "0111") THEN
				estado_atual <= LD;
			ELSIF(INST(7 DOWNTO 4) = "1000") THEN
				estado_atual <= ST;
			ELSIF(INST(7 DOWNTO 4) = "1001") THEN
				estado_atual <= ENTRA;
			ELSIF(INST(7 DOWNTO 4) = "1010") THEN
				estado_atual <= SAI;
			ELSIF(INST(7 DOWNTO 4) = "1011") THEN
				estado_atual <= MVI;
			ELSIF(INST(7 DOWNTO 4) = "1100") THEN
				estado_atual <= JMP;
			ELSIF(INST(7 DOWNTO 4) = "1101") THEN
				estado_atual <= JZ;
			ELSIF(INST(7 DOWNTO 4) = "1110") THEN
				estado_atual <= NOP;
			ELSIF(INST(7 DOWNTO 4) = "1111") THEN
				estado_atual <= NOP;
			END IF; 
		WHEN SOMA =>
			estado_atual <= BUSCA;
		WHEN SUBTRAI =>
			estado_atual <= BUSCA;
		WHEN E =>
			estado_atual <= BUSCA;
		WHEN OU =>
			estado_atual <= BUSCA;
		WHEN NAO =>
			estado_atual <= BUSCA;
		WHEN NOU =>
			estado_atual <= BUSCA;
		WHEN MOV =>
			estado_atual <= BUSCA;
		WHEN LD =>
			estado_atual <= BUSCA;
		WHEN ST =>
			estado_atual <= BUSCA;
		WHEN ENTRA =>
			estado_atual <= BUSCA;
		WHEN SAI =>
			estado_atual <= BUSCA;
		WHEN MVI =>
			estado_atual <= BUSCA;
		WHEN JMP =>
			estado_atual <= BUSCA;
		WHEN JZ =>
			estado_atual <= BUSCA;
		WHEN NOP =>
			estado_atual <= BUSCA;
		END CASE;
		END IF;
	END PROCESS;
	
	sinais : PROCESS(estado_atual)
	BEGIN
		CASE estado_atual IS
			WHEN INICIO =>
				--clear <= '1';
				ld_Raux <= '0';
				ld_IR <= '0';
				ld_Ra <= '0';
				ld_Rb <= '0';
				ld_Rc <= '0';
				ld_Rd <= '0'; 
				ld_Rout <= '0';
				INST_EXEC_SIG <= '0';
			WHEN BUSCA =>
				ld_Raux <= '1';
				ld_IR <= '1';
				ld_Ra <= '0';
				ld_Rb <= '0';
				ld_Rc <= '0';
				ld_Rd <= '0'; 
				ld_Rout <= '0';
				INST_EXEC_SIG <= '0';
			WHEN DECODIFICA =>
				ld_Raux <= '0';
				ld_IR <= '0';
				ld_Ra <= '0';
				ld_Rb <= '0';
				ld_Rc <= '0';
				ld_Rd <= '0'; 
				ld_Rout <= '0';
			WHEN SOMA =>
				INST_EXEC_SIG <= '1';
				Sel_ALU <= "000";
				Sel_Mux_1 <= INST(3 DOWNTO 2);
				Sel_Mux_2 <= INST(1 DOWNTO 0);
				Sel_Mux_0 <= "011";
				IF(INST(3 DOWNTO 2)= "00")THEN 
					ld_Ra <= '1';
					ld_Rb <= '0';
					ld_Rc <= '0';
					ld_Rd <= '0';
				ELSIF(INST(3 DOWNTO 2)= "01")THEN 
					ld_Ra <= '0';
					ld_Rb <= '1';
					ld_Rc <= '0';
					ld_Rd <= '0';
				ELSIF(INST(3 DOWNTO 2)= "10")THEN 
					ld_Ra <= '0';
					ld_Rb <= '0';
					ld_Rc <= '1';
					ld_Rd <= '0';
				ELSIF(INST(3 DOWNTO 2)= "11")THEN 
					ld_Ra <= '0';
					ld_Rb <= '0';
					ld_Rc <= '0';
					ld_Rd <= '1';
				END IF;
				
			WHEN SUBTRAI =>
				INST_EXEC_SIG <= '1';
				Sel_ALU <= "001";
				Sel_Mux_1 <= INST(3 DOWNTO 2);
				Sel_Mux_2 <= INST(1 DOWNTO 0);
				Sel_Mux_0 <= "011";
				
				IF(INST(3 DOWNTO 2)= "00")THEN 
					ld_Ra <= '1';
					ld_Rb <= '0';
					ld_Rc <= '0';
					ld_Rd <= '0';
				ELSIF(INST(3 DOWNTO 2)= "01")THEN 
					ld_Ra <= '0';
					ld_Rb <= '1';
					ld_Rc <= '0';
					ld_Rd <= '0';
				ELSIF(INST(3 DOWNTO 2)= "10")THEN 
					ld_Ra <= '0';
					ld_Rb <= '0';
					ld_Rc <= '1';
					ld_Rd <= '0';
				ELSIF(INST(3 DOWNTO 2)= "11")THEN 
					ld_Ra <= '0';
					ld_Rb <= '0';
					ld_Rc <= '0';
					ld_Rd <= '1';
				END IF;
				
			WHEN E =>
				INST_EXEC_SIG <= '1';
				Sel_ALU <= "010";
				Sel_Mux_1 <= INST(3 DOWNTO 2);
				Sel_Mux_2 <= INST(1 DOWNTO 0);
				Sel_Mux_0 <= "011";
				IF(INST(3 DOWNTO 2)= "00")THEN 
					ld_Ra <= '1';
					ld_Rb <= '0';
					ld_Rc <= '0';
					ld_Rd <= '0';
				ELSIF(INST(3 DOWNTO 2)= "01")THEN 
					ld_Ra <= '0';
					ld_Rb <= '1';
					ld_Rc <= '0';
					ld_Rd <= '0';
				ELSIF(INST(3 DOWNTO 2)= "10")THEN 
					ld_Ra <= '0';
					ld_Rb <= '0';
					ld_Rc <= '1';
					ld_Rd <= '0';
				ELSIF(INST(3 DOWNTO 2)= "11")THEN 
					ld_Ra <= '0';
					ld_Rb <= '0';
					ld_Rc <= '0';
					ld_Rd <= '1';
				END IF;
				
			WHEN OU =>
				INST_EXEC_SIG <= '1';
				Sel_ALU <= "011";
				Sel_Mux_1 <= INST(3 DOWNTO 2);
				Sel_Mux_2 <= INST(1 DOWNTO 0);
				Sel_Mux_0 <= "011";
				IF(INST(3 DOWNTO 2)= "00")THEN 
					ld_Ra <= '1';
					ld_Rb <= '0';
					ld_Rc <= '0';
					ld_Rd <= '0';
				ELSIF(INST(3 DOWNTO 2)= "01")THEN 
					ld_Ra <= '0';
					ld_Rb <= '1';
					ld_Rc <= '0';
					ld_Rd <= '0';
				ELSIF(INST(3 DOWNTO 2)= "10")THEN 
					ld_Ra <= '0';
					ld_Rb <= '0';
					ld_Rc <= '1';
					ld_Rd <= '0';
				ELSIF(INST(3 DOWNTO 2)= "11")THEN 
					ld_Ra <= '0';
					ld_Rb <= '0';
					ld_Rc <= '0';
					ld_Rd <= '1';
				END IF;
				
			WHEN NAO =>
				INST_EXEC_SIG <= '1';
				Sel_ALU <= "100";
				Sel_Mux_1 <= INST(3 DOWNTO 2);
				Sel_Mux_2 <= INST(1 DOWNTO 0);
				Sel_Mux_0 <= "011";
				IF(INST(3 DOWNTO 2)= "00")THEN 
					ld_Ra <= '1';
					ld_Rb <= '0';
					ld_Rc <= '0';
					ld_Rd <= '0';
				ELSIF(INST(3 DOWNTO 2)= "01")THEN 
					ld_Ra <= '0';
					ld_Rb <= '1';
					ld_Rc <= '0';
					ld_Rd <= '0';
				ELSIF(INST(3 DOWNTO 2)= "10")THEN 
					ld_Ra <= '0';
					ld_Rb <= '0';
					ld_Rc <= '1';
					ld_Rd <= '0';
				ELSIF(INST(3 DOWNTO 2)= "11")THEN 
					ld_Ra <= '0';
					ld_Rb <= '0';
					ld_Rc <= '0';
					ld_Rd <= '1';
				END IF;
			
			WHEN NOU =>
				INST_EXEC_SIG <= '1';
				Sel_ALU <= "101";
				Sel_Mux_1 <= INST(3 DOWNTO 2);
				Sel_Mux_2 <= INST(1 DOWNTO 0);
				Sel_Mux_0 <= "011";
				IF(INST(3 DOWNTO 2)= "00")THEN 
					ld_Ra <= '1';
					ld_Rb <= '0';
					ld_Rc <= '0';
					ld_Rd <= '0';
				ELSIF(INST(3 DOWNTO 2)= "01")THEN 
					ld_Ra <= '0';
					ld_Rb <= '1';
					ld_Rc <= '0';
					ld_Rd <= '0';
				ELSIF(INST(3 DOWNTO 2)= "10")THEN 
					ld_Ra <= '0';
					ld_Rb <= '0';
					ld_Rc <= '1';
					ld_Rd <= '0';
				ELSIF(INST(3 DOWNTO 2)= "11")THEN 
					ld_Ra <= '0';
					ld_Rb <= '0';
					ld_Rc <= '0';
					ld_Rd <= '1';
				END IF;
			
			WHEN MOV => 
				INST_EXEC_SIG <= '1';
				Sel_Mux_0 <= "010";
				Sel_Mux_1 <= INST(3 DOWNTO 2);
				IF(INST(1 DOWNTO 0)= "00")THEN 
					ld_Ra <= '1';
					ld_Rb <= '0';
					ld_Rc <= '0';
					ld_Rd <= '0';
				ELSIF(INST(1 DOWNTO 0)= "01")THEN 
					ld_Ra <= '0';
					ld_Rb <= '1';
					ld_Rc <= '0';
					ld_Rd <= '0';
				ELSIF(INST(1 DOWNTO 0)= "10")THEN 
					ld_Ra <= '0';
					ld_Rb <= '0';
					ld_Rc <= '1';
					ld_Rd <= '0';
				ELSIF(INST(1 DOWNTO 0)= "11")THEN 
					ld_Ra <= '0';
					ld_Rb <= '0';
					ld_Rc <= '0';
					ld_Rd <= '1';
				END IF;
				
			WHEN LD =>
			
			WHEN ST => 
			
			WHEN ENTRA =>
			
			WHEN SAI => 
					INST_EXEC_SIG <= '1';
					Sel_Mux_1 <= INST(3 DOWNTO 2);
					ld_Rout <= '1';
					ld_Ra <= '0';
					ld_Rb <= '0';
					ld_Rc <= '0';
					ld_Rd <= '0';
			WHEN MVI =>
					INST_EXEC_SIG <= '1';
					Sel_Mux_0 <= "001";
					--ld_Raux <= '0'; 
					IF(INST(3 DOWNTO 2)= "00")THEN 
						ld_Ra <= '1';
						ld_Rb <= '0';
						ld_Rc <= '0';
						ld_Rd <= '0';
					ELSIF(INST(3 DOWNTO 2)= "01")THEN 
						ld_Ra <= '0';
						ld_Rb <= '1';
						ld_Rc <= '0';
						ld_Rd <= '0';
					ELSIF(INST(3 DOWNTO 2)= "10")THEN 
						ld_Ra <= '0';
						ld_Rb <= '0';
						ld_Rc <= '1';
						ld_Rd <= '0';
					ELSIF(INST(3 DOWNTO 2)= "11")THEN 
						ld_Ra <= '0';
						ld_Rb <= '0';
						ld_Rc <= '0';
						ld_Rd <= '1';
				END IF;
					
			WHEN JMP =>
			
			WHEN JZ => 
			
			WHEN NOP =>
		
		END CASE;
	END PROCESS;
END arch;
