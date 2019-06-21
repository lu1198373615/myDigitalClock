library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity  fenpin_6  is
  port(
      clk        :   in    std_logic;
		clk_out    :   out   std_logic
);
end entity;

architecture   rtl  of  fenpin_6  is
signal cnt  :  integer range 0 to 99999;
begin

process(clk,cnt)
begin
if clk'event and clk='1' then
  if cnt=99999 then cnt<=0;
    else cnt<=cnt+1;
  end if;
end if;
end process;

process(cnt)
begin
if cnt<49999 then clk_out<='1';
  else clk_out<='0';
end if;
end process;
end architecture   rtl;
