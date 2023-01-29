library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity FullAdder is
	port(
			op1, op2, cin : in std_logic;
			s, cout : out std_logic
		);
end FullAdder;


architecture Behavioral of FullAdder is


	begin
		
		s  <= op1 xor op2 xor cin;
		cout <= (op1 and op2) or (op1 and cin) or (op2 and cin);

end Behavioral;
