library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity  qudouqi  is
  port(
      clk        :   in    std_logic;
      key_in     :   in    std_logic;
      key_out    :   out   std_logic
);
end entity;

architecture   state_machine  of   qudouqi  is
type state is(s0,s1,s2,s3,s4,s5,s6,s7,s8,s9);
signal pre_s, next_s :state;
begin

p0:process(clk)
begin
  if rising_edge(clk) then
    pre_s<=next_s;
  end if;
end process;

p1:process(pre_s,next_s,key_in)
begin
  case pre_s is
    when s0 => key_out<='1';
	   if key_in='1' then
		  next_s<=s0;
		  else next_s<=s1;
		end if;
	 when s1 => key_out<='1';
	   if key_in='1' then
		  next_s<=s0;
		  else next_s<=s2;
		end if;
	 when s2 => key_out<='1';
	   if key_in='1' then
		  next_s<=s0;
		  else next_s<=s3;
		end if;
	 when s3 => key_out<='1';
	   if key_in='1' then
		  next_s<=s0;
		  else next_s<=s4;
		end if;
	 when s4 => key_out<='1';
	   if key_in='1' then
		  next_s<=s0;
		  else next_s<=s5;
		end if;
	 when s5 => key_out<='1';
	   if key_in='1' then
		  next_s<=s0;
		  else next_s<=s6;
		end if;
	 when s6 => key_out<='1';
	   if key_in='1' then
		  next_s<=s0;
		  else next_s<=s7;
		end if;
	 when s7 => key_out<='1';
	   if key_in='1' then
		  next_s<=s0;
		  else next_s<=s8;
		end if;
	 when s8 => key_out<='1';
	   if key_in='1' then
		  next_s<=s0;
		  else next_s<=s9;
		end if;
	 when s9 => key_out<='0';
	   if key_in='1' then
		  next_s<=s0;
		  else next_s<=s9;
		end if;
	end case;
end process;

end architecture   state_machine;
