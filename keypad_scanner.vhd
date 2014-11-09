-- @author: Aditya Sundararajan
-- www.github.com/1143stuff

library IEEE;
library UNISIM;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use UNISIM.VComponents.all;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.


entity keypad_scanner is

port(clk,rst: in std_logic;
        key0,key1,key2,key3:in std_logic;
        row:out bit_vector(3 downto 0);
        en:out std_logic_vector(3 downto 0);			        -- 'en' is used for enabling each 7-Segment Display
        disp:out std_logic_vector(7 downto 0));			        -- Final output will be seen on 7-Segment Display

end keypad_scanner;

architecture Behavioral of keypad_scanner is
	signal bkey0,bkey1,bkey2,bkey3: std_logic;
	signal bclk: std_logic;
	signal bclk1: std_logic;
	signal rowtemp: bit_vector(3 downto 0):="1110";
	signal disptemp: std_logic_vector(3 downto 0);

	component ibuf					        -- Component of ibuf
		port(i: in std_logic;
	       	       o: out std_logic);
                end component; 

	component testcnt					        -- Component of testcnt
	
		port(clk: in std_logic;
	                        one: out std_logic);
     
	end component;
begin

   	u1: ibuf port map(i=>key0,o=>bkey0);			       -- Port mapping with ibuf
	u2: ibuf port map(i=>key1,o=>bkey1);			       -- Port mapping with ibuf	
	u3: ibuf port map(i=>key2,o=>bkey2);			       -- Port mapping with ibuf
	u4: ibuf port map(i=>key3,o=>bkey3);			       -- Port mapping with ibuf
	u5: testcnt port map(clk=>clk,one=>bclk);		       -- Port mapping with testcnt
	u6: testcnt port map(clk=>bclk,one=>bclk1);		       -- Port mapping with testcnt

	en<="0000";

pp1:Process(bkey0,bkey1,bkey2,bkey3,rst,bclk1) 

begin
    
    if(rst='1')then  
    	disptemp<="0000";
    
    else
    if(bclk1'event and bclk1='1')then
    	row <= rowtemp;
    	
	if(rowtemp="1101")then				    -- Row 4 is checked
       		
		if(bkey0='0')then
       			disptemp<="0000";		    	    -- Display 'F'
       		
		elsif(bkey1='0')then
	  		disptemp<="0001";			    -- Display 'B'
       
		elsif(bkey2='0')then
       			disptemp<="0010";			    -- Display '7'
       
		elsif(bkey3='0')then
       			disptemp<="0011";			    -- Display '3'
	  	
		end if;
	end if;

    	if(rowtemp="1011")then				    -- Row 3 is checked
       
		if(bkey0='0')then
       			disptemp<="0100";			    -- Display 'E'
       
		elsif(bkey1='0')then
       			disptemp<="0101";			    -- Display 'A'
       
		elsif(bkey2='0')then
       			disptemp<="0110";			    -- Display '6'

       		elsif(bkey3='0')then
       			disptemp<="0111";			    -- Display '2'

	  	end if;
	  end if;
	
	if(rowtemp="0111")then				    -- Row 2 is checked
       
		if(bkey0='0')then
       			disptemp<="1000";			    -- Display 'D'
       
		elsif(bkey1='0')then
       			disptemp<="1001";			    -- Display '9'
       
		elsif(bkey2='0')then
       			disptemp<="1010";			    -- Display '5'

       		elsif(bkey3='0')then
       			disptemp<="1011";			    -- Display '1'
	  	
		end if;
	  end if;
	
	if(rowtemp="1110")then				    -- Row 1 is checked
       
		if(bkey0='0')then
       			disptemp<="1100";			    -- Display 'C'
       
		elsif(bkey1='0')then
       			disptemp<="1101";			    -- Display '8'

       		elsif(bkey2='0')then
       			disptemp<="1110";			    -- Display '4'

       		elsif(bkey3='0')then
       			disptemp<="1111";			    -- Display '0'

		end if;
	end if;
	
	rowtemp <= rowtemp rol 1;
	end if;
    end if;

end process pp1;	 

pp2:process(disptemp)
 
    begin
	
	if(disptemp="0000")then
	  	disp<="10001110";	  		    	     -- Display 'F'
       
	elsif(disptemp="0001")then
       		disp<="10000011";			    	     -- Display 'B'

	 elsif(disptemp="0010")then
       		disp<="11111000";			    	     -- Display '7'

	 elsif(disptemp="0011")then
       		disp<="10110000";			    	     -- Display '3'

	 elsif(disptemp="0100")then
	 	disp<="10000110";			    	     -- Display 'E'

	  elsif(disptemp="0101")then
       		disp<="10001000";			    	     -- Display 'A'

	  elsif(disptemp="0110")then
		disp<="10000010";			    	     -- Display '6'

	  elsif(disptemp="0111")then
       		disp<="10100100";			    	     -- Display '2'

	  elsif(disptemp="1000")then
       		disp<="10100001";			    	     -- Display 'D'

	  elsif(disptemp="1001")then
       		disp<="10010000";			    	     -- Display '9'

	  elsif(disptemp="1010")then
       		disp<="10010010";			    	     -- Display '5'

	  elsif(disptemp="1011")then
	       	disp<="11111001";			    	     -- Display '1'

	  elsif(disptemp="1100")then
       		disp<="11000110";			    	     -- Display 'C'

	  elsif(disptemp="1101")then
       		disp<="10000000";			    	     -- Display '8'

	  elsif(disptemp="1110")then
       		disp<="10011001";			    	     -- Display '4'

	  elsif(disptemp="1111")then
       		disp<="11000000";			    	     -- Display '0'

	  end if;
    
end process pp2;

end Behavioral;
