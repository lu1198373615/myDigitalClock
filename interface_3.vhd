--显示调节月的界面
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity  interface_3  is
  port(
      clk      :   in    std_logic;
      month   :   in    std_logic_vector(7 downto 0);
		
		num24    :   out   std_logic_vector(23 downto 0)
);
end entity;

architecture   rtl  of  interface_3  is
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
if cnt>24999999 then num24(23 downto 20)<="1010";--左起第一个数码管闪烁
  else num24(23 downto 20)<="1111";
end if;
end process;

num24(19 downto 12)<=month;                                         --左起第二第三个显示月
num24(11 downto 0)<="111111111111";                                 --左起第四第五第六个无显示

end architecture   rtl;
