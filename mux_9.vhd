library ieee;
use ieee.std_logic_1164.all;

entity  mux_9  is
  port(
      sel  :  in  std_logic_vector(3 downto 0);
      d_out       :   out   std_logic_vector(23 downto 0);
      d0,d1,d2,d3,d4,d5,d6,d7,d8 : in  std_logic_vector(23 downto 0)		
);
end entity;

architecture   one  of  mux_9  is
begin

process(sel,d0,d1,d2,d3,d4,d5,d6,d7,d8)
begin
case sel is
  when "0000" => d_out<=d0;
  when "0001" => d_out<=d1;
  when "0010" => d_out<=d2;
  when "0011" => d_out<=d3;
  when "0100" => d_out<=d4;
  when "0101" => d_out<=d5;
  when "0110" => d_out<=d6;
  when "0111" => d_out<=d7;
  when "1000" => d_out<=d8;
  when others => d_out<="000000000000000000000000";
end case;
end process;

end architecture   one;
