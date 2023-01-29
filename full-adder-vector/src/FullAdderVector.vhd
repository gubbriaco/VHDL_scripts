library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity FullAdderVector is
	generic(
				n : integer := 8
			);
	port(
			op1, op2, op3 : in std_logic_vector(n-1 downto 0);
			sp, cv : out std_logic_vector(n downto 0)
		);
end FullAdderVector;


architecture Behavioral of FullAdderVector is

	component FullAdder is
		port(
				op1, op2, cin : in std_logic;
				s, cout : out std_logic
			);
	end component;
	
	signal sps, cvs : std_logic_vector(n-1 downto 0);

	begin
		
		for_generate: for i in 0 to n generate
			if_generate: if( i < n ) generate
				FullAdder_generate: FullAdder port map(op1(i), op2(i), op3(i), sps(i), cvs(i));
			end generate if_generate;
		end generate for_generate;
		
		sp <= sps(n-1) & sps;
		cv <= cvs & '0';

end Behavioral;
