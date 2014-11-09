-- @author: Aditya Sundararajan
-- www.github.com/1143stuff

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity testcnt is
    
Port (clk : in std_logic;
         one : out std_logic);

end testcnt;

architecture Behavioral of testcnt is
 	signal cnt: std_logic_vector(7 downto 0):="00000000";
 	signal check: std_logic:='0';
 	signal t: std_logic:='0';

begin

process(clk)

begin

    if(clk'event and clk='1')then
	cnt<= cnt+'1';
    	
	if(cnt="00100101")then
  		check<= not check;
  		cnt<="00000000";
    
	end if;
    end if;

end process;

process(check)

begin

    if(check'event and check='1')then
	t<= not t;
	one<= t;

    end if;

end process;

end Behavioral;
