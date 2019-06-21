library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity  hextodec_12  is
  port(
      hex       :   in    std_logic_vector(3 downto 0);
      dec       :   out   std_logic_vector(7 downto 0)
);
end entity;

architecture   transverter  of  hextodec_12  is
 signal temp   :  std_logic_vector(4 downto 0);
 signal hex_in : integer range 1 to 13;
begin

hex_in<=CONV_INTEGER(hex);

process(hex_in)
begin
  case hex_in is
    when 1 to 9 =>
	   temp<=CONV_STD_LOGIC_VECTOR(hex_in,5);
	 when 10 to 13 =>
	   temp<=CONV_STD_LOGIC_VECTOR(hex_in,5)+"00110";
	 when others=>temp<="00001";
	end case;
end process;

dec<="000"&temp;
end architecture   transverter;
