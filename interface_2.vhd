--显示可以给秒清零的界面
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity  interface_2  is
  port(
      clk      :   in    std_logic;
      second   :   in    std_logic_vector(7 downto 0);
		
		num24    :   out   std_logic_vector(23 downto 0)
);
end entity;

architecture   rtl  of  interface_2  is
 signal cnt    :  integer range 0 to 49999999;
 constant t_1s :  integer:=49999999;
begin

process(clk,cnt)
begin
  if cnt=t_1s then cnt<=0;
    elsif clk'event and clk='1' then cnt<=cnt+1;
  end if;
end process;

process(cnt)
begin
if cnt>24999999 then num24(11 downto 8)<="1010";--左起第四个数码管闪烁
  else num24(11 downto 8)<="1111";
end if;
end process;

num24(23 downto 12)<="111111111111";                               --左起前三个数码管不显示
num24(7 downto 0)<=second;                                         --左起第五第六个显示秒

end architecture   rtl;
