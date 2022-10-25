library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
-- **************************************
entity Timer is
port
(
	data_in :in std_logic_vector(7 downto 0);
	reset,clock,start:in std_logic;
	ring :out std_logic
);
end Timer;
-- **************************************
architecture behv of Timer is
type state is(st0,st1,st2,st3);
signal current_state,next_state:state;
signal counter :std_logic_vector(7 downto 0);
begin 

	COM1:process(clock,reset)
	begin 
		if reset='0' then current_state<=st0;		-- ?????
		elsif clock='1' and clock'event then 
			current_state<=next_state;
		end if;
	end process COM1;
-- **************************************	
	COM2:process(current_state,start,counter)   --????????????? ?????????
	begin 
		case current_state is
			when st0=> ring<='0';
				if start='1'then next_state<=st1;
				else next_state<=st0;
				end if;
			when st1=> 
				if start ='0' then next_state<=st2;
				else next_state<=st1;
				end if;
			when st2=>
				if counter=1 then next_state<=st3;
				else next_state<=st2;
				end if;
			when st3=> ring<='1';
				if counter /=1 then next_state<=st3;
				else next_state<=st0;
				end if;
			end case;
	end process COM2;
-- **************************************
	COM3:process(clock)								--???????
	begin 
		if clock='1' and clock'event then 
			case current_state is
				when st0=> counter<="00000000";
				when st1=> counter<=data_in;
				when st2=>
					if counter=1 then counter<="00001000";
					else
						counter<=counter-1;
					end if;
				when st3=> 
					if counter /=1 then
						counter<=counter-1;
					else counter<="00000000"; --????????
					end if;
				end case;
			end if;
	end process COM3;
end behv;
	
