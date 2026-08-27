entity d_register is
    generic(
        width : natural := 4;
        reset_value : natural := 0
    );
    port(
        clock, reset, load : in bit;
        d : in bit_vector(width-1 downto 0);
        q : out bit_vector(width-1 downto 0) 
    );
end d_register;

architecture rtl of d_register is
    
    signal q_registro : bit_vector(width-1 downto 0);
begin

    process(clock, reset)
        variable val_temp : natural;
        variable bit_v    : bit_vector(width-1 downto 0);
    begin
        if reset = '1' then
            val_temp := reset_value;
            for i in 0 to width-1 loop
                if (val_temp mod 2) = 1 then
                    bit_v(i) := '1';
                else
                    bit_v(i) := '0';
                end if;
                val_temp := val_temp / 2;
            end loop;
            q_registro <= bit_v;

        elsif clock'event and clock = '1' then
            if load = '1' then
                q_registro <= d;
            end if;
        end if;
    end process;

    q <= q_registro;

end architecture rtl;
