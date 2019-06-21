--闹钟控制
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity  bell  is
  port(
      clk           :   in    std_logic;
      in_hour_1     :   in    std_logic_vector(4 downto 0);
      in_hour_2     :   in    std_logic_vector(4 downto 0);
		in_minute_1   :   in    std_logic_vector(5 downto 0);
		in_minute_2   :   in    std_logic_vector(5 downto 0);
		key_1         :   in    std_logic;
		
		bell    :   out   std_logic
);
end entity;

architecture   rtl  of  bell  is
 signal data,contrl  :  std_logic;
 signal cnt : integer range 0 to 49999999;
begin

process(clk,cnt)
begin
  if cnt=49999999 then cnt<=0;
    elsif clk'event and clk='1' then cnt<=cnt+1;
  end if;
end process;

process(cnt,clk)
begin
if clk'event and clk='1' then
  if cnt<9999999  then contrl<='1';
    else contrl<='0';
  end if;
end if;
end process;

process(clk,in_hour_1,in_hour_2,in_minute_1,in_minute_2)
begin
if clk'event and clk='1' then
  if in_hour_1=in_hour_2 and in_minute_1=in_minute_2 then
      data<='1';
    else data<='0';
  end if;
end if;
end process;

process(clk,data,contrl)
begin
if clk'event and clk='1' then
  bell<=not(data and contrl and key_1);
end if;
end process;

end architecture   rtl;
