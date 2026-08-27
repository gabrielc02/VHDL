library ieee;
use ieee.numeric_bit.ALL;
use std.textio.all;

entity rom is
    generic(
        word_size : natural := 8;
        addr_size : natural := 4;
        datFileName : string := "rom.dat"
    );
    port(
        addr : in bit_vector(addr_size-1 downto 0);
        data : out bit_vector(word_size-1 downto 0)
    );
end rom;

architecture de_arquivo of rom32x4 is
  type mem_t is array (0 to addr_size-1) of bit_vector(word_size-1 downto 0);

  impure function inicializa(nome_do_arquivo : in string) return mem_t is
    file     arquivo  : text open read_mode is nome_do_arquivo;
    variable linha    : line;
    variable temp_bv  : bit_vector(word_size-1 downto 0);
    variable temp_mem : mem_t;
    begin
      for i in mem_t'range loop
        readline(arquivo, linha);
        read(linha, temp_bv);
        temp_mem(i) := temp_bv;
      end loop;
      return temp_mem;
    end;
  constant mem : mem_t := inicializa("rom.dat");
begin
  data <= mem(to_integer(unsigned(addr)));
end de_arquivo;