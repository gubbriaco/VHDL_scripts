library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;


entity CarrySaveAdder4Operands_tb is
	generic(
				nbit_data : integer := 8
			);
end CarrySaveAdder4Operands_tb;


architecture Behavioral of CarrySaveAdder4Operands_tb is

	component CarrySaveAdder4Operands8bit is
		generic(
					n : integer := 8
				);
		port(
				op1, op2, op3, op4 : in std_logic_vector(n-1 downto 0);
				result : out std_logic_vector(n+4 downto 0)
			);
	end component;

	signal clk : std_logic := '0';
	signal op1, op2, op3, op4 : std_logic_vector(nbit_data-1 downto 0) := (others=>'0');
    signal result : std_logic_vector(nbit_data+4 downto 0);
	constant clock_period : Time := 20 ns;
	signal true_result, error_result : integer;
	
	begin
	
		clock_generation : process
			begin
				wait for clock_period/2;
                clk <= not clk;
		end process;
	
		UUT : CarrySaveAdder4Operands8bit generic map(nbit_data) port map(	
																	op1, op2, op3, op4,
																	result
																);
		
		testing : process
			begin
				wait for 2*clock_period + 100 ns;
				for vop1 in 0 to (2**(nbit_data-1)-1) loop
					op1 <= conv_std_logic_vector( vop1, nbit_data );
					for vop2 in 0 to (2**(nbit_data-1)-1) loop
						op2 <= conv_std_logic_vector( vop2, nbit_data );
						for vop3 in -(2**(nbit_data-1)) to (2**(nbit_data-1)-1) loop
							op3 <= conv_std_logic_vector( vop3, nbit_data );
							for vop4 in -(2**(nbit_data-1)) to (2**(nbit_data-1)-1) loop
								op4 <= conv_std_logic_vector( vop4, nbit_data );
								
								true_result <= vop1 + vop2 + vop3 + vop4;
								error_result <= true_result - conv_integer( signed( result ) );
								wait for 10 ns;
								
								assert( signed(result) = vop1 + vop2 + vop3 + vop4 ) 
										report "FAIL: expected sum is not equal to the result" 
										severity ERROR;
								wait for 10 ns;
								
							end loop;
						end loop;
					end loop;
				end loop;
		end process;


		

end Behavioral;
