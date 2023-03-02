----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.03.2023 19:16:28
-- Design Name: 
-- Module Name: ALUbb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;  
entity FullAdder is
port(
    A,B: in std_logic;
    Ci: in std_logic;
    Cout: out std_logic;
    S: out std_logic
);
end FullAdder;
architecture Behavioral of FullAdder is
signal ent: std_logic_vector(2 downto 0);
begin
    ent<=A&B&Ci;
    process
    begin
    case ent  is
        when "000" =>S<='0';Cout<='0';
        when "001" =>S<='1';Cout<='0';
        when "010" =>S<='1';Cout<='0';
        when "011" =>S<='0';Cout<='1';
        when "100" =>S<='1';Cout<='0';
        when "101" =>S<='0';Cout<='1';
        when "110" =>S<='0';Cout<='1';
        when "111" =>S<='1';Cout<='1';
      end case;
    end process;

end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;  
entity FullAdder4bits is
port(
    A,B: in std_logic_vector(3 downto 0);
    Ci: in std_logic;
    Cout: out std_logic;
    S: out std_logic_vector(3 downto 0)
);
end FullAdder4bits;
architecture Behavioral of FullAdder4bits is
    component FullAdder is
   port(
    A,B: in std_logic;
    Ci: in std_logic;
    Cout: out std_logic;
    S: out std_logic
);
    end component;
    signal carr: std_logic_vector (3 downto 0);
begin
    --FA1: FullAdder port map(A(0)=>A,B(0)=>B,Ci=>Ci,carr(0)=>Cout,S(0)=>S);
    FA1: FullAdder port map(A(0),B(0),Ci,carr(0),S(0));
    FA2: FullAdder port map(A(1),B(1),carr(0),carr(1),S(1));
    FA3: FullAdder port map(A(2),B(2),carr(1),carr(2),S(2));
    FA4: FullAdder port map(A(3),B(3),carr(2),carr(3),S(3));
end Behavioral;



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;  
entity ALUbb is
port(
    A,B: in std_logic_vector(2 downto 0);
    F: in std_logic_vector(1 downto 0);
    Z: out std_logic_vector(3 downto 0)
);
end ALUbb;
architecture Behavioral of ALUbb is
component FullAdder4bits is
port(
    A,B: in std_logic_vector(3 downto 0);
    Ci: in std_logic;
    Cout: out std_logic;
    S: out std_logic_vector(3 downto 0)
);
end component;
signal suma: std_logic_vector(3 downto 0);
signal carry: std_logic;
signal Neg: std_logic_vector(3 downto 0);
begin
Neg<='1'&not(A);
FA4B: FullAdder4bits port map(Neg,"0001",'0',carry,suma);
    
    process(A,B,F)
    begin
        case F is
            when "00" => Z <= '0'&(A and B);
            when "01" => Z <= '0'&(A or B);
            when "10" => Z <= '0'&not B;
            when "11" => Z <= suma;

            when others => Z <= (others => '0');
        end case;
    end process;
    
end Behavioral;