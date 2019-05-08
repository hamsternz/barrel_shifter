library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_shifter is
    Port ( a : in STD_LOGIC);
end tb_shifter;

architecture Behavioral of tb_shifter is
    component shifter is
    Port ( clk : in STD_LOGIC;
           sign_extend : in  STD_LOGIC;
           left_shift  : in  STD_LOGIC;
           shift_amt   : in  STD_LOGIC_VECTOR (4 downto 0);           
           data_in     : in  STD_LOGIC_VECTOR (31 downto 0);
           data_out    : out STD_LOGIC_VECTOR (31 downto 0));
    end component;    
    signal clk         : STD_LOGIC                      := '0';
    signal sign_extend : STD_LOGIC                      := '0';
    signal left_shift  : STD_LOGIC                      := '0';
    signal shift_amt   : STD_LOGIC_VECTOR (4 downto 0)  := (others => '0');           
    signal data_in     : STD_LOGIC_VECTOR (31 downto 0) := x"FF0000FF";
    signal data_out    : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
begin

process
    begin
        clk <= not clk;
        wait for 5 ns;
    end process;
    
process(clk)
    begin
        if rising_edge(clk) then
            if shift_amt = "11111" and left_shift = '1' then
                sign_extend <= not sign_extend;
            end if;
            
            if shift_amt = "11111" then
                left_shift <= not left_shift; 
            end if;
            
            shift_amt <= std_logic_vector(unsigned(shift_amt)+1);
        end if;
    end process;
    
uut: shifter port map (
    clk => clk,
    sign_extend  => sign_extend,
    left_shift   => left_shift,
    shift_amt    => shift_amt,
    data_in      => data_in,
    data_out     => data_out);

end Behavioral;
