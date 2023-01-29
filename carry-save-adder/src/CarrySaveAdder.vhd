library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity CarrySaveAdder is
	generic(n : integer);
	port(
		A, B, C : in std_logic_vector(n-1 downto 0);
		Somma : out std_logic_vector(n+1 downto 0)
	);
end CarrySaveAdder;


architecture Behavioral of CarrySaveAdder is

	signal somma_parziale, carry : std_logic_vector(n-1 downto 0);
	signal se, cs : std_logic_vector(n downto 0);
	
	component RippleCarryAdder is
		generic(n : integer);
		port(
			A, B : in std_logic_vector(n-1 downto 0);
			Cin : in std_logic;
			S : out std_logic_vector(n downto 0)
		);
	end component;

	begin
	
		sp_c_generate : for i in 0 to n-1 generate
			carry(i) <= (A(i) and B(i)) or (A(i) and C(i)) or (B(i) and C(i));
			somma_parziale(i) <= A(i) xor B(i) xor C(i);
		end generate sp_c_generate;
		
		se <= somma_parziale(n-1) & somma_parziale;
		cs <= carry & '0';
		
		RCA : RippleCarryAdder generic map(n+1) port map(se, cs, '0', Somma);
		


end Behavioral;
