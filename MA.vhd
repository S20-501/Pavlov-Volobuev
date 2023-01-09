library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity MA is
	port (
		i_clk			: in	std_logic;
		i_nRst		: in	std_logic;
		IData_In		: in	std_logic_vector(10-1 downto 0);
		QData_In		: in	std_logic_vector(10-1 downto 0);
		
		MANumber		: in	std_logic_vector(5-1 downto 0);

		IData_Out		: out	std_logic_vector(10-1 downto 0);
		QData_out		: out	std_logic_vector(10-1 downto 0)
	);
end MA;

architecture rtl of MA is

	type moving_average_t is array (0 to 31) of std_logic_vector(10-1 downto 0);
	type int_array is array (2 to 31) of std_logic_vector(16-1 downto 0);

	signal moving_average1_r	: moving_average_t;
	signal moving_average2_r	: moving_average_t;
	signal acc1_r				: std_logic_vector(18-1 downto 0);
	signal acc2_r				: std_logic_vector(18-1 downto 0);

	signal IData_Out_r			: std_logic_vector(10-1 downto 0);
	signal QData_out_r			: std_logic_vector(10-1 downto 0);
	signal product1_r			: std_logic_vector(34-1 downto 0);
	signal product2_r			: std_logic_vector(34-1 downto 0);

	constant filterCoeff : int_array := (
		2 => X"8000",
		3 => X"5555",
		4 => X"4000",
		5 => X"3333",
		6 => X"2AAA",
		7 => X"2492",
		8 => X"2000",
		9 => X"1C71",
		10 => X"1999",
		11 => X"1745",
		12 => X"1555",
		13 => X"13B1",
		14 => X"1249",
		15 => X"1111",
		16 => X"1000",
		17 => X"0F0F",
		18 => X"0E38",
		19 => X"0D79",
		20 => X"0CCC",
		21 => X"0C30",
		22 => X"0BA2",
		23 => X"0B21",
		24 => X"0AAA",
		25 => X"0A3D",
		26 => X"09D8",
		27 => X"097B",
		28 => X"0924",
		29 => X"08D3",
		30 => X"0888",
		31 => X"0842",

		others => X"0000"
);

begin

	IData_Out	<= IData_Out_r;
	QData_out	<= QData_out_r;

	p_average : process(i_clk, i_nRst)
	begin
		if(i_nRst = '0') then
			acc1_r					<= (others => '0');
			moving_average1_r	<= (others => (others => '0'));
			IData_Out_r				<= (others => '0');
			product1_r			<= (others => '0');
			acc2_r					<= (others => '0');
			moving_average2_r	<= (others => (others => '0'));
			QData_out_r				<= (others => '0');
			product2_r			<= (others => '0');
		elsif(rising_edge(i_clk)) then
			if(MANumber = "00001") then
				IData_Out_r <= IData_In;
				QData_out_r <= QData_In;
			else
				moving_average1_r	<= IData_In & moving_average1_r(0 to moving_average1_r'length-2);
				acc1_r					<= acc1_r + IData_In - moving_average1_r(conv_integer(MANumber)-1);
				product1_r			<= acc1_r * filterCoeff(conv_integer(MANumber));
				IData_Out_r				<= product1_r(16+10-1 downto 16);
				
				moving_average2_r	<= QData_In & moving_average2_r(0 to moving_average2_r'length-2);
				acc2_r					<= acc2_r + QData_In - moving_average2_r(conv_integer(MANumber)-1);
				product2_r			<= acc2_r * filterCoeff(conv_integer(MANumber));
				QData_out_r				<= product2_r(16+10-1 downto 16);
			end if;
		end if;
	end process p_average;

end rtl;
