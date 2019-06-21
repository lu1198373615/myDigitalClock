--扫描输出数码管
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity  scan  is
  port(
      clk      :   in    std_logic;
      data_in  :   in    std_logic_vector(23 downto 0);
      reset    :   in    std_logic;
		
		data_out :   out   std_logic_vector(3 downto 0);
		scan     :   out   std_logic_vector(5 downto 0)
);
end entity;

architecture   rtl  of  scan  is
 signal   cnt   :  integer range 0 to 49999;
 signal    i    :  integer range 0 to 5;
 constant t_1ms :  integer:=49998;
begin

process(clk,cnt,reset)
begin
  if reset='0' then cnt<=0;
    elsif clk'event and clk='1' then
	   if cnt=49999 then cnt<=0;
		  else cnt<=cnt+1;
		end if;
  end if;
end process;

process(cnt,reset,i,data_in,clk)
begin
if reset='0' then i<=0;
  elsif clk'event and clk='1' then
    case i is
	   when 0 =>if cnt=t_1ms then i<=1;
		           else data_out<=data_in(23 downto 20);
					end if;
		when 1 =>if cnt=t_1ms then i<=2;
		           else data_out<=data_in(19 downto 16);
					end if;
      when 2 =>if cnt=t_1ms then i<=3;
		           else data_out<=data_in(15 downto 12);
					end if;
      when 3 =>if cnt=t_1ms then i<=4;
		           else data_out<=data_in(11 downto 8);
					end if;
      when 4 =>if cnt=t_1ms then i<=5;
		           else data_out<=data_in(7 downto 4);
					end if;
      when 5 =>if cnt=t_1ms then i<=0;
		           else data_out<=data_in(3 downto 0);
					end if;
		when others=> i<=0;
    end case;
end if;
end process;

process(cnt,reset,i,data_in,clk)
begin
if clk'event and clk='1' then
    case i is
	   when 0 => scan<="011111";
		when 1 => scan<="101111";
      when 2 => scan<="110111";
      when 3 => scan<="111011";
      when 4 => scan<="111101";
      when 5 => scan<="111110";
		when others=> scan<="111111";
    end case;
end if;
end process;

end architecture   rtl;
