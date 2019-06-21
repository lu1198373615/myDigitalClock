library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity  CPU_4bit  is
  port(
      clk        :   in    std_logic;
      key_1      :   in    std_logic;
		key_2      :   in    std_logic;
		
		reset      :   in    std_logic;
		
      pointer    :   out   std_logic_vector(3 downto 0)
);
end entity;

architecture   state_machine  of  CPU_4bit  is
type state is(s0,s1,s2,s3,s4,s5,s6,s7,s8);
signal pre_s, next_s :state;
signal key1_buf1,key2_buf1,key1_buf2,key2_buf2,reset_buf1,reset_buf2 : std_logic;
signal ptr : integer range 0 to 8;
begin

process(clk,key_1,key1_buf1)
begin
if clk'event and clk='1' then
  key1_buf1<=key_1;
  key1_buf2<=key1_buf1;
end if;
end process;

process(clk,key_2,key2_buf1)
begin
if clk'event and clk='1' then
  key2_buf1<=key_2;
  key2_buf2<=key2_buf1;
end if;
end process;

process(clk,reset,next_s,reset_buf1,reset_buf2)
begin
if reset='0' then pre_s<=s0;
  elsif clk'event and clk='1' then
    pre_s<=next_s;
end if;
end process;

p1:process(reset,clk,pre_s,next_s,key1_buf1,key1_buf2,key2_buf1,key2_buf2,key_1,key_2)
begin
if reset='0' then next_s<=s0;
elsif clk'event and clk='1' then
  case pre_s is
    when s0 => ptr<=0;
	   if key1_buf1='1' and key1_buf2='0' then next_s<=s3;
  	     elsif key2_buf1='1' and key2_buf2='0' then next_s<=s1;
		end if;
	 when s1 => ptr<=1;
	   if key1_buf1='1' and key1_buf2='0' then next_s<=s3;
		  elsif key2_buf1='1' and key2_buf2='0' then next_s<=s2;
		end if;
	 when s2 => ptr<=2;
	   if key2_buf1='1' and key2_buf2='0' then next_s<=s0;
		end if;
	 when s3 => ptr<=3;
	   if key1_buf1='1' and key1_buf2='0' then next_s<=s4;
		end if;
	 when s4 => ptr<=4;
	   if key1_buf1='1' and key1_buf2='0' then next_s<=s5;
		end if;
	 when s5 => ptr<=5;
	   if key1_buf1='1' and key1_buf2='0' then next_s<=s6;
		end if;
	 when s6 => ptr<=6;
	   if key1_buf1='1' and key1_buf2='0' then next_s<=s7;
		end if;
	 when s7 => ptr<=7;
	   if key1_buf1='1' and key1_buf2='0' then next_s<=s8;
		end if;
	 when s8 => ptr<=8;
	   if key1_buf1='1' and key1_buf2='0' then next_s<=s0;
		end if;
	end case;
end if;
end process;

pointer<=CONV_STD_LOGIC_VECTOR(ptr,4);
end architecture   state_machine;
