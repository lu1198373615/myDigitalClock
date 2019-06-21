library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity  data_base  is
  port(
      clk           :   in  std_logic;
      key_1         :   in  std_logic;
      key_2         :   in   std_logic;
		pointer       :   in  std_logic_vector(3 downto 0);
		reset         :   in   std_logic;
      
		month         :   out   std_logic_vector(3  downto  0);--1to12
		day           :   out   std_logic_vector(4  downto  0);--1to31/30/29
		hour          :   out   std_logic_vector(4  downto  0);--1to24
		minute        :   out   std_logic_vector(5  downto  0);--1to60
		second        :   out   std_logic_vector(5  downto  0);--1to60
		alarm_hour    :   out   std_logic_vector(4  downto  0);--1to24
		alarm_minute  :   out   std_logic_vector(5  downto  0)--1to60
);
end data_base;

architecture   kernel  of   data_base  is
  signal  pre_month   :  integer range 1 to 13;
  signal  pre_day   :  integer range 1 to 32;
  signal  pre_hour    :  integer range 0 to 24;
  signal  pre_minute  :  integer range 0 to 60;
  signal  pre_second  :  integer range 0 to 60;
  signal  pre_alarm_hour    :  integer range 0 to 24;
  signal  pre_alarm_minute  :  integer range 0 to 60;
  constant fenpin : integer:=49999999;
  signal cnt : integer range 0 to 49999999;
  --下面是进位信号
  signal sec_to_min,min_to_h,h_to_day,day_to_month : std_logic;
  --再加一个清零信号
  signal day_clear, month_clear : std_logic;
  --下面是需要的5组buffer
  signal sec_to_min_buf1,sec_to_min_buf2 : std_logic;
  signal  min_to_h_buf1,min_to_h_buf2 : std_logic;
  signal  h_to_day_buf1,h_to_day_buf2 : std_logic;
  signal  day_to_month_buf1,day_to_month_buf2 : std_logic;
  signal  key2_buf1,key2_buf2 : std_logic;
begin

process(clk,cnt)--50m分频
begin
if clk'event and clk='1' then
  if cnt=fenpin then cnt<=0;
    else cnt<=cnt+1;
  end if;
end if;
end process;

process(clk,reset,cnt,pre_second,pointer,key_1)--对秒进行的操作
begin
if reset='0' then pre_second<=0;
  elsif pre_second=60 then pre_second<=0;
    elsif clk'event and clk='1' then
	   if cnt=24999999 then pre_second<=pre_second+1;
	     elsif (key_1='0' and pointer="0010")  then pre_second<=1;
      end if;
end if;
end process;

process(clk,pre_second)--进位信号产生
begin
if clk'event and clk='1' then
  if pre_second=0 then sec_to_min<='1';
    else sec_to_min<='0';
  end if;
end if;
end process;

process(clk,key_2,key2_buf1)--key2的buffer
begin
if clk'event and clk='1' then
  key2_buf1<=key_2;
  key2_buf2<=key2_buf1;
end if;
end process;

process(clk,sec_to_min,sec_to_min_buf1)--sec_to_min的buffer
begin
if clk'event and clk='1' then
  sec_to_min_buf1<=sec_to_min;
  sec_to_min_buf2<=sec_to_min_buf1;
end if;
end process;

process(clk,reset,pre_minute,sec_to_min_buf1,sec_to_min_buf2,pointer,key2_buf1,key2_buf2)--所有可以对分的操作
begin
if reset='0' then pre_minute<=0;
  elsif pre_minute=60 then pre_minute<=0;
    elsif clk'event and clk='1' then
	   if (sec_to_min_buf1='1' and sec_to_min_buf2='0') or (pointer="0110" and key2_buf1='1' and key2_buf2='0')
		  then pre_minute<=pre_minute+1;
		end if;
end if;
end process;

process(clk,pre_minute)--进位信号产生
begin
if clk'event and clk='1' then
  if pre_minute=0 then min_to_h<='1';
    else min_to_h<='0';
  end if;
end if;
end process;

process(clk,min_to_h,min_to_h_buf1)--min_to_h的buffer
begin
if clk'event and clk='1' then
  min_to_h_buf1<=min_to_h;
  min_to_h_buf2<=min_to_h_buf1;
end if;
end process;

process(clk,reset,pre_hour,min_to_h_buf1,min_to_h_buf2,pointer,key2_buf1,key2_buf2)--所有可以对时的操作
begin
if reset='0' then pre_hour<=9;
  elsif pre_hour=24 then pre_hour<=0;
    elsif clk'event and clk='1' then
	   if (min_to_h_buf1='1' and min_to_h_buf2='0') or (pointer="0101" and key2_buf1='1' and key2_buf2='0')
		  then pre_hour<=pre_hour+1;
		end if;
end if;
end process;

process(clk,pre_hour)--进位信号产生
begin
if clk'event and clk='1' then
  if pre_hour=0 then h_to_day<='1';
    else h_to_day<='0';
  end if;
end if;
end process;

process(clk,h_to_day,h_to_day_buf1)--h_to_day的buffer
begin
if clk'event and clk='1' then
  h_to_day_buf1<=h_to_day;
  h_to_day_buf2<=h_to_day_buf1;
end if;
end process;

process(clk,pre_month,pre_day)
begin
if clk'event and clk='1'then
  case pre_month is
    when 1|3|5|7|8|10|12=>if pre_day=32 then day_clear<='1';else day_clear<='0';end if;
	 when 4|6|9|11=>if pre_day=31 then day_clear<='1';else day_clear<='0';end if;
	 when others=>if pre_day=30 then day_clear<='1';else day_clear<='0';end if;
  end case;
end if;
end process;

process(clk,reset,pre_day,pre_month,h_to_day_buf1,h_to_day_buf2,pointer,key2_buf1,key2_buf2)--所有可以对日的操作
begin
if reset='0' then pre_day<=1;
  elsif pre_day=32 then pre_day<=1;
    elsif clk'event and clk='1' then
	   if day_clear='1' then pre_day<=1;
	     elsif (h_to_day_buf1='1' and h_to_day_buf2='0') or (pointer="0100" and key2_buf1='1' and key2_buf2='0')
		    then pre_day<=pre_day+1;
		end if;
end if;
end process;

process(clk,pre_day)--进位信号产生
begin
if clk'event and clk='1' then
  if pre_day=1 then day_to_month<='1';
    else day_to_month<='0';
  end if;
end if;
end process;

process(clk,day_to_month,day_to_month_buf1)--day_to_month的buffer
begin
if clk'event and clk='1' then
  day_to_month_buf1<=day_to_month;
  day_to_month_buf2<=day_to_month_buf1;
end if;
end process;

process(pre_month,clk)
begin
if clk'event and clk='1' then
  if pre_month>12 then month_clear<='1';
    else month_clear<='0';
  end if;
end if;
end process;

process(clk,reset,pre_month,day_to_month_buf1,day_to_month_buf2,pointer,key2_buf1,key2_buf2)--所有可以对月进行的操作
begin
if reset='0' then pre_month<=10;
  elsif month_clear='1' then pre_month<=1;
    elsif clk'event and clk='1' then
	   if (day_to_month_buf1='1' and day_to_month_buf2='0') or (pointer="0011" and key2_buf1='1' and key2_buf2='0')
		  then pre_month<=pre_month+1;
		end if;
end if;
end process;

process(reset,clk,pre_alarm_hour,pointer,key2_buf1,key2_buf2)--所有可以对闹钟的时进行的操作
begin
if reset='0' then pre_alarm_hour<=6;
  elsif pre_alarm_hour=24 then pre_alarm_hour<=0;
    elsif clk'event and clk='1' then
	   if (pointer="0111" and key2_buf1='1' and key2_buf2='0')
		  then pre_alarm_hour<=pre_alarm_hour+1;
		end if;
end if;
end process;

process(reset,clk,pre_alarm_minute,pointer,key2_buf1,key2_buf2)--所有可以对闹钟的分进行的操作
begin
if reset='0' then pre_alarm_minute<=0;
  elsif pre_alarm_minute=60 then pre_alarm_minute<=0;
    elsif clk'event and clk='1' then
	   if (pointer="1000" and key2_buf1='1' and key2_buf2='0')
		  then pre_alarm_minute<=pre_alarm_minute+1;
		end if;
end if;
end process;

--以下是将常数转化为向量
process(clk,pre_second)
begin
if clk'event and clk='1' then
  second<=CONV_STD_LOGIC_VECTOR(pre_second,6);
end if;
end process;

process(clk,pre_minute)
begin
if clk'event and clk='1' then
  minute<=CONV_STD_LOGIC_VECTOR(pre_minute,6);
end if;
end process;

process(clk,pre_hour)
begin
if clk'event and clk='1' then
  hour<=CONV_STD_LOGIC_VECTOR(pre_hour,5);
end if;
end process;

process(clk,pre_day)
begin
if clk'event and clk='1' then
  day<=CONV_STD_LOGIC_VECTOR(pre_day,5);
end if;
end process;

process(clk,pre_month)
begin
if clk'event and clk='1' then
  month<=CONV_STD_LOGIC_VECTOR(pre_month,4);
end if;
end process;

process(clk,pre_alarm_hour)
begin
if clk'event and clk='1' then
  alarm_hour<=CONV_STD_LOGIC_VECTOR(pre_alarm_hour,5);
end if;
end process;
process(clk,pre_alarm_minute)
begin
if clk'event and clk='1' then
  alarm_minute<=CONV_STD_LOGIC_VECTOR(pre_alarm_minute,6);
end if;
end process;

end architecture   kernel;