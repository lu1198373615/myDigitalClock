--显示月日的界面
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity  interface_1  is
  port(
      month     :   in    std_logic_vector(7 downto 0);
      day   :   in    std_logic_vector(7 downto 0);		
		num24    :   out   std_logic_vector(23 downto 0)
);
end entity;

architecture   rtl  of  interface_1  is
begin
num24(23 downto 12)<="1111"&month;                        --左起第一个数码管不显示，第二第三个显示月
num24(11 downto 0) <="1010"&day;                          --第四个横杠，第五第六个显示日

end architecture   rtl;
