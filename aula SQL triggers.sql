create function inserir_vendas()returns trigger 
language plpgsql as
$$
declare
	vvalorunitario decimal(10,2);
begin
    update produto
        set estoque = estoque - new.quantidade
    where pro_codigo = new.pro_codigo;

    select valorunitario into vvalorunitario
        from produto
    where pro_codigo = new.pro_codigo;
    update cliente
        set saldo = saldo + (new.quantidade * vvalorunitario)
    where cli_codigo = new.cli_codigo;
	return new;
end
$$


create trigger tr_inserir_venda
	after insert
	on venda
	for each row execute procedure inserir_vendas()

--------------------------------------------------------------------


create function excluir_vendas()returns trigger 
language plpgsql as
$$
declare
	vvalorunitario decimal(10,2);
begin
    update produto
        set estoque = estoque + old.quantidade
    where pro_codigo = old.pro_codigo;

    select valorunitario into vvalorunitario
        from produto
    where pro_codigo = old.pro_codigo;
    update cliente
        set saldo = saldo - (new.quantidade * vvalorunitario)
    where cli_codigo = old.cli_codigo;
	return old;
end
$$


create trigger tr_excluir_venda
	before delete
	on venda
	for each row execute procedure excluir_vendas()


------------------------------------------------------------


create function alterar_vendas()returns trigger 
    language plpgsql as
    $$
    declare
        vvalorunitario decimal(10,2);
    begin
        update produto
            set estoque = estoque + old.quantidade - new.quantidade
        where pro_codigo = new.pro_codigo;

        select valorunitario into vvalorunitario
            from produto
        where pro_codigo = new.pro_codigo;
        update cliente
            set saldo = saldo - (new.quantidade * vvalorunitario) + (new.quantidade * vvalorunitario)
        where cli_codigo = new.cli_codigo;
    return new;
end
$$
