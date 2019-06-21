library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity  hextodec_60  is
  port(
      hex       :   in    std_logic_vector(5 downto 0);
      dec       :   out   std_logic_vector(7 downto 0)
);
end entity;

architecture   transverter  of  hextodec_60  is
 signal temp   : std_logic_vector(6 downto 0);
 signal hex_in : integer range 0 to 60;
begin

hex_in<=CONV_INTEGER(hex);

process(hex_in)
begin
  case hex_in is
    when 0 to 9 =>
	   temp<=CONV_STD_LOGIC_VECTOR(hex_in,7);
	 when 10 to 19 =>
	   temp<=CONV_STD_LOGIC_VECTOR(hex_in,7)+"0000110";
	 when 20 to 29 =>
	   temp<=CONV_STD_LOGIC_VECTOR(hex_in,7)+"0001100";
	 when 30 to 39 =>
	   temp<=CONV_STD_LOGIC_VECTOR(hex_in,7)+"0010010";
	 when 40 to 49 =>
	   temp<=CONV_STD_LOGIC_VECTOR(hex_in,7)+"0011000";
	 when 50 to 59 =>
	   temp<=CONV_STD_LOGIC_VECTOR(hex_in,7)+"0011110";
	 when others=>temp<="0000000";
	end case;
end process;

dec<="0"&temp;
end architecture   transverter;
