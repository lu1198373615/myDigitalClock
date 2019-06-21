library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity  hextodec_31  is
  port(
      hex       :   in    std_logic_vector(4 downto 0);
      dec       :   out   std_logic_vector(7 downto 0)
);
end entity;

architecture   transverter  of  hextodec_31  is
 signal temp  :  std_logic_vector(5 downto 0);
 signal hex_in : integer range 1 to 31;
begin

hex_in<=CONV_INTEGER(hex);

process(hex_in)
begin
  case hex_in is
    when 1 to 9 =>
	   temp<=CONV_STD_LOGIC_VECTOR(hex_in,6);
	 when 10 to 19 =>
	   temp<=CONV_STD_LOGIC_VECTOR(hex_in,6)+"000110";
	 when 20 to 29 =>
	   temp<=CONV_STD_LOGIC_VECTOR(hex_in,6)+"001100";
	 when 30 to 31 =>
	   temp<=CONV_STD_LOGIC_VECTOR(hex_in,6)+"010010";
	 when others=>temp<="000001";
	end case;
end process;

dec<="00"&temp;
end architecture   transverter;
