library ieee;
use ieee.std_logic_1164.all;

entity ma_tester is 
	port (
		i_clk			: out	std_logic;
		i_nRst		: out std_logic;
		IData_In		: out	std_logic_vector(10-1 downto 0);
		QData_In		: out	std_logic_vector(10-1 downto 0);
		MANumber		: out	std_logic_vector(5-1 downto 0)
	);
end entity ma_tester;

architecture a_ma_tester of ma_tester is 
	constant clk_period: time := 16 ns;
	signal i_clk_r: std_logic := '1';

	procedure skiptime_clk(time_count: in integer) is
	begin
		count_time: for k in 0 to time_count-1 loop
			wait until falling_edge(i_clk_r); 
			wait for 200 fs;
		end loop count_time ;
	end;
	
	begin 
		i_clk_r <= not i_clk_r after clk_period / 2;
		i_clk <= i_clk_r;
		
		tester_process: process 
			begin
				IData_In	<= (others => '0');
				QData_In	<= (others => '0');
				MANumber	<= b"00011"; -- 3
				
				skiptime_clk(2);
				
				-- Сброс
				i_nRst <= '0';
				skiptime_clk(1);
				i_nRst <= '1';
				
				IData_In <= b"0000001010"; -- 10
				QData_In <= b"0000001010"; -- 10
				skiptime_clk(1);
				IData_In <= b"0000001011"; -- 11
				QData_In <= b"0000001011"; -- 11
				skiptime_clk(1);
				IData_In <= b"0000001100"; -- 12
				QData_In <= b"0000001100"; -- 12
				skiptime_clk(1);
				IData_In <= b"0000001101"; -- 13
				QData_In <= b"0000001101"; -- 13
				skiptime_clk(1);
				IData_In <= b"0000001110"; -- 14
				QData_In <= b"0000001110"; -- 14
				skiptime_clk(1);
				IData_In <= b"0000001111"; -- 15
				QData_In <= b"0000001111"; -- 15
				skiptime_clk(1);
				IData_In <= b"0000010000"; -- 16
				QData_In <= b"0000010000"; -- 16
				skiptime_clk(1);
				IData_In <= b"0000010001"; -- 17
				QData_In <= b"0000010001"; -- 17
				skiptime_clk(1);
				IData_In <= b"0000010010"; -- 18
				QData_In <= b"0000010010"; -- 18
				skiptime_clk(1);
				IData_In <= b"0000010011"; -- 19
				QData_In <= b"0000010011"; -- 19
				skiptime_clk(1);
				IData_In <= b"0000010100"; -- 20
				QData_In <= b"0000010100"; -- 20
				skiptime_clk(1);
				IData_In <= b"0000010101"; -- 21
				QData_In <= b"0000010101"; -- 21
				skiptime_clk(30);
				
				MANumber	<= b"00100"; -- 4
				
				IData_In <= b"0000001010"; -- 10
				QData_In <= b"0000001010"; -- 10
				skiptime_clk(1);
				IData_In <= b"0000001011"; -- 11
				QData_In <= b"0000001011"; -- 11
				skiptime_clk(1);
				IData_In <= b"0000001100"; -- 12
				QData_In <= b"0000001100"; -- 12
				skiptime_clk(1);
				IData_In <= b"0000001101"; -- 13
				QData_In <= b"0000001101"; -- 13
				skiptime_clk(1);
				IData_In <= b"0000001110"; -- 14
				QData_In <= b"0000001110"; -- 14
				skiptime_clk(1);
				IData_In <= b"0000001111"; -- 15
				QData_In <= b"0000001111"; -- 15
				skiptime_clk(1);
				IData_In <= b"0000010000"; -- 16
				QData_In <= b"0000010000"; -- 16
				skiptime_clk(1);
				IData_In <= b"0000010001"; -- 17
				QData_In <= b"0000010001"; -- 17
				skiptime_clk(1);
				IData_In <= b"0000010010"; -- 18
				QData_In <= b"0000010010"; -- 18
				skiptime_clk(1);
				IData_In <= b"0000010011"; -- 19
				QData_In <= b"0000010011"; -- 19
				skiptime_clk(1);
				IData_In <= b"0000010100"; -- 20
				QData_In <= b"0000010100"; -- 20
				skiptime_clk(1);
				IData_In <= b"0000010101"; -- 21
				QData_In <= b"0000010101"; -- 21
				skiptime_clk(30);
				
				skiptime_clk(10000);
				
		end process;	

end architecture;
