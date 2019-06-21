--扫描输出数码管
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity  decoder  is
  port(
      data_in  :   in    std_logic_vector(3 downto 0);
		
		decode_out :   out   std_logic_vector(7 downto 0)
);
end entity;

architecture   rtl  of  decoder  is
begin

process(data_in)
begin
case data_in is
 when "0000" =>decode_out<="11000000";
 when "0001" =>decode_out<="11111001";
 when "0010" =>decode_out<="10100100";
 when "0011" =>decode_out<="10110000";
 when "0100" =>decode_out<="10011001";
 when "0101" =>decode_out<="10010010";
 when "0110" =>decode_out<="10000010";
 when "0111" =>decode_out<="11111000";
 when "1000" =>decode_out<="10000000";
 when "1001" =>decode_out<="10010000";
 when "1010" =>decode_out<="10111111";
 when "1011" =>decode_out<="11111101";
 when "1100" =>decode_out<="11111110";
 when "1101" =>decode_out<="11011111";
 when "1110" =>decode_out<="10011100";
 when "1111" =>decode_out<="11111111";
 when others =>decode_out<="11111111";
end case;
end process;

end architecture   rtl;
