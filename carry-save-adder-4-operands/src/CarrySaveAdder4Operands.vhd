library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity CarrySaveAdder4Operands is
	generic(
				n : integer := 16
			);
	port(
			op1, op2, op3, op4 : in std_logic_vector(n-1 downto 0);
			result : out std_logic_vector(n+4 downto 0)
		);
end CarrySaveAdder4Operands;


architecture Behavioral of CarrySaveAdder4Operands is
	component FullAdderVector is
		generic(
					n : integer := 8
				);
		port(
				op1, op2, op3 : in std_logic_vector(n-1 downto 0);
				sp, cv : out std_logic_vector(n downto 0)
			);
	end component;
	
	component RippleCarryAdder is
		generic(
					n : integer := 8
				);
		port(
				op1, op2 : in std_logic_vector(n-1 downto 0);
				cin : in std_logic;
				s : out std_logic_vector(n downto 0)
			);
	end component;
	
	-- ps123 : partial sum of the first, second and third operands
	-- cv123 : carry vector of the first, second and third operands
	-- op4_ex1 : sign extension of the fourth operand
	signal ps123, cv123, op4_ex1 : std_logic_vector(n downto 0);
	
	-- ps1234 : partial sum of the first, second, third and fourth operands
	-- cv1234 : carry vector of the first, second, third and fourth operands
	signal ps1234, cv1234 : std_logic_vector(n+1 downto 0); 
	
	signal results : std_logic_vector(n+2 downto 0);
	
	
	
	begin

		FullAdderVector_op1_op2_op3 : FullAdderVector generic map(n) port map(	
																			op1, op2, op3, 
																			ps123, cv123
																		);
		
		op4_ex1 <= op4(n-1) &  op4;
		FullAdderVector_ps123_cv123_op4ex1 : FullAdderVector generic map(n+1) port map(	
																						ps123, cv123, op4_ex1, 
																						ps1234, cv1234
																					);
		
		RippleCarryAdder_ps1234_cv1234 : RippleCarryAdder generic map(n+2) port map(	
																						ps1234, cv1234, '0', 
																						results
																					);
		result <= results(n+2) & results(n+2) & results;
		
		
end Behavioral;
