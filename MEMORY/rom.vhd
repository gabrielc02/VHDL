library ieee;
use ieee.numeric_bit.ALL;

entity rom is
    generic(
        word_size : natural := 8;
        addr_size : natural := 4
    );
    port(
        addr : in bit_vector(addr_size-1 downto 0);
        data : out bit_vector(word_size-1 downto 0)
    );
end rom;

architecture literais of rom16x8 is
  type mem_t is array (0 to 15) of bit_vector(7 downto 0);
  constant mem : mem_t := (
    "00000000", "00000011", "11000000", "00001100",
    "00110000", "01010101", "10101010", "11111111",
    "11100000", "11100111", "00000111", "00011000",
    "11000011", "00111100", "11110000", "00001111"
  );
begin
  data <= mem(to_integer(unsigned(addr)));
end literais;