library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity MA is
	port (
		i_clk			: in	std_logic;
		i_nRst		: in	std_logic;
		i_data		: in	std_logic_vector(10-1 downto 0);
		
		MANumber		: in	std_logic_vector(8-1 downto 0);
		FilterCoeff	: in	std_logic_vector(16-1 downto 0);

		o_data		: out	std_logic_vector(10-1 downto 0)
	);
end MA;

architecture rtl of MA is

type moving_average_t is array (0 to 32-1) of std_logic_vector(10-1 downto 0);

signal moving_average_r	: moving_average_t;
signal acc_r				: std_logic_vector(18-1 downto 0);

signal result_r			: std_logic_vector(34-1 downto 0);
--signal part_length_r		: std_logic_vector(32-1 downto 0);
signal part_length_r		: integer range 0 to 32;
signal last_index_r		: std_logic_vector(32-1 downto 0);

begin

	part_length_r <= to_integer(unsigned(MANumber - x"00000002"));

	p_average : process(i_clk, i_nRst)
	begin
		if(i_nRst = '0') then
			acc_r					<= (others=>'0');
			moving_average_r	<= (others=>(others=>'0'));
			o_data				<= (others=>'0');
		elsif(rising_edge(i_clk)) then
			moving_average_r	<= i_data & moving_average_r(0 to part_length_r);
			acc_r					<= std_logic_vector(unsigned(acc_r) + unsigned(i_data));
			acc_r					<= std_logic_vector(unsigned(acc_r) - unsigned(moving_average_r(to_integer(unsigned(last_index_r)))));
			result_r				<= acc_r * FilterCoeff;
		end if;
		o_data					<= result_r(34-1 downto 34-16);
	end process p_average;

end rtl;