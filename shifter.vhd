library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity shifter is
    Port ( clk : in STD_LOGIC;
           sign_extend : in  STD_LOGIC;
           left_shift  : in  STD_LOGIC;
           shift_amt   : in  STD_LOGIC_VECTOR (4 downto 0);           
           data_in     : in  STD_LOGIC_VECTOR (31 downto 0);
           data_out    : out STD_LOGIC_VECTOR (31 downto 0));
end shifter;

architecture Behavioral of shifter is
    constant padding     : STD_LOGIC_VECTOR (23 downto 0) := (others => '0');
begin

process(clk)
   variable temp : STD_LOGIC_VECTOR (31 downto 0);
   begin
      if rising_edge(clk) then

           ---------------------------------------------------------------------------------------
           -- Reverse bits depending on shift direction, or flip depending on sign and sign extention
           ---------------------------------------------------------------------------------------
           if sign_extend = '1' then
              if data_in(data_in'high) = '1' then
                  temp := not data_in;
              else
                  temp := data_in;
              end if;
           else
              if left_shift = '1' then
                 for i in 0 to 31 loop 
                    temp(i)  := data_in(31-i);
                 end loop; 
              else
                 temp := data_in;
              end if;
          end if; 
        
          --------------------
          -- unsigned shifter
          --------------------
          case shift_amt(4 downto 4) is
              when "0"    => temp := temp; 
              when others => temp := padding(15 downto 0) & temp(31 downto 16);
          end case;

          case shift_amt( 3 downto 2) is
              when "00"   => temp := temp; 
              when "01"   => temp := padding( 3 downto 0) & temp(31 downto  4);
              when "10"   => temp := padding( 7 downto 0) & temp(31 downto  8);
              when others => temp := padding(11 downto 0) & temp(31 downto 12);
          end case;

          case shift_amt( 1 downto 0) is
              when "00"   => temp := temp; 
              when "01"   => temp := padding( 0 downto 0) & temp(31 downto 1);
              when "10"   => temp := padding( 1 downto 0) & temp(31 downto 2);
              when others => temp := padding( 2 downto 0) & temp(31 downto 3);
          end case;

          ---------------------------------------------------------------------------------------
          -- Reverse bits depending on shift direction, or flip depending on sign and sign extention
          ---------------------------------------------------------------------------------------
          if sign_extend = '1' then
             if data_in(data_in'high) = '1' then
                data_out <= not temp;
             else
                data_out <= temp;
             end if;
          else
             if left_shift = '1' then
                for i in 0 to 31 loop 
                   data_out(i)  <= temp(31-i);
                end loop; 
             else
                data_out <= temp;
             end if;
          end if; 
      end if;
   end process;
end Behavioral;
