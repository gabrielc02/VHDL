library ieee;
use ieee.std_logic_1164.all;     
use ieee.numeric_std.all; 

entity alu is
    generic (
        size :  natural := 8
    );
    port(
        --inputs
        A, B : in bit_vector(size-1 downto 0);
        --outputs
        F : out bit_vector(size-1 downto 0);
        S : in bit_vector(2 downto 0);
        Z : out bit;
        Co : out bit;
        Ov : out bit
    );
end entity alu;

architecture dataflow of alu is
    signal F_interno : std_logic_vector(size-1 downto 0);
    signal soma      : std_logic_vector(size downto 0);
    signal sub       : std_logic_vector(size downto 0);
begin

    soma <= std_logic_vector(unsigned('0' & A) + unsigned('0' & B));
    sub  <= std_logic_vector(unsigned('0' & A) - unsigned('0' & B));

    with S select
        F_interno <= soma(size-1 downto 0) when "000",
                     sub(size-1 downto 0)  when "001",
                     (A and B)             when "010", 
                     (A or B)              when "011", 
                     (others => '0')       when others;

    F <= F_interno;

    
    Z <= '1' when (F_interno = (others => '0')) else '0';

    Co <= soma(size) when (S = "000") else
          sub(size)  when (S = "001") else
          '0';

    Ov <= (A(size-1) xor soma(size-1)) when (S = "000" and (A(size-1) = B(size-1))) else
          (A(size-1) xor sub(size-1))  when (S = "001" and (A(size-1) /= B(size-1))) else
          '0';

end architecture dataflow;