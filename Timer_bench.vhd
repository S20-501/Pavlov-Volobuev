library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TimerTb is
end entity;

architecture tb_behav of TimerTb is


constant ClockFrequencyHz : integer := 10; -- 10 Hz
constant ClockPeriod      : time := 1000 ms / ClockFrequencyHz;
clock <= not clock after ClockPeriod / 2;


begin


component Timer is
port
(
	data_in :in std_logic_vector(7 downto 0);
	reset,clock,start:in std_logic;
	ring :out std_logic
);
end component Timer;





T: component Timer
  port map (
    data_in       => data_in,
    reset       => reset,
    clock       => clock,
    start       => start,
    ring        => ring,
  );



process is
begin
reset <= '0';
start <= '1';
data_in = "00001111"

end process;
  

end architecture;
