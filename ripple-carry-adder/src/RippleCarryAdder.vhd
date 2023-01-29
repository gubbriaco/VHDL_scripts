library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity RippleCarryAdder is
	generic(
				n : integer := 8
			);
	port(
			op1, op2 : in std_logic_vector(n-1 downto 0);
			cin : in std_logic;
			s : out std_logic_vector(n downto 0)
		);
end RippleCarryAdder;


architecture Behavioral of RippleCarryAdder is

	signal carry: std_logic_vector(n downto 0);

    component FullAdder is
		port(
				op1, op2, cin : in std_logic;
				s, cout : out std_logic
			);
	end component;

	begin
	
		carry(0) <= cin;
		
		for_generate: for i in 0 to n generate        
			if_generate: if( i < n ) generate
				FullAdder_generate: FullAdder port map(op1(i), op2(i), carry(i), s(i), carry(i+1));    
			end generate if_generate;
			if_generate_s: if( i = n ) generate
				FullAdder_generate_s: FullAdder port map(op1(i-1), op2(i-1), carry(i), s(i), open);      
			end generate if_generate_s;                                                
		end generate for_generate;


end Behavioral;
