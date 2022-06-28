-- 1 Listar o nome do cliente, endereço, cep, valor_venda (preço_venda * unidade) das vendas
--  realizadas no ano 1997 e mês de janeiro ordenando por nome do cliente;

SELECT nome_completo, endereco, cep, round(sum(ven.preco_venda * ven.unidade), 2)
    from vendas ven 
    join cliente cli on ven.cliente_codigo = cli.codigo
    join periodo per on ven.periodo_codigo = per.codigo
where  per.ano = 1997 and per.mes = 1
GROUP by cli.nome_completo, cli. endereco, cli.cep
order by nome_completo


--2 Listar o país, estado, cidade, endereço, cep, nome do cliente, sexo, valor_venda das vendas
--  com custo unitário superiores a 50;

SELECT pais, estado, cidade, endereco, cep, nome_completo, sexo, preco_venda, sum(ven.preco_venda * ven.unidade)
    from vendas ven 
    join cliente cli on ven.cliente_codigo = cli.codigo
    join regiao reg on cli.regiao_codigo = reg.codigo
    join periodo per on ven.periodo_codigo = per.codigo
  WHERE (ven.preco_venda * ven.unidade) > 50
group by reg.pais, reg.estado, reg.cidade, cli.endereco, cli.cep, cli.nome_completo, cli.sexo, ven.preco_venda

--3 Listar a média das vendas por categoria, subcategoria no ano 1997;

SELECT categoria, subcategoria, ano, round(avg(ven.preco_venda),2) as média
    from vendas ven 
    join cliente cli on ven.cliente_codigo = cli.codigo
    join regiao reg on cli.regiao_codigo = reg.codigo
    join periodo per on ven.periodo_codigo = per.codigo
    join produto pro on ven.produto_codigo = pro.codigo
    join classe clas on pro.classe_codigo = clas.codigo
  where per.ano = 1997
group by clas.categoria, clas.subcategoria, per.ano


--4 Listar a média do lucro líquido por ano, mês, tipo_loja, somente quando a média for superior a 10;

SELECT ano, mes, tipo, round(avg ((ven.preco_venda - ven.custo_unitario) * ven.unidade),3)
    from vendas ven 
    join periodo per on ven.periodo_codigo = per.codigo
    join loja loj on ven.loja_codigo = loj.codigo
   group by per.ano, per.mes, loj.tipo 
  having avg ((ven.preco_venda - ven.custo_unitario) * ven.unidade) > 10
  


--5 Listar a soma das vendas por país, estado, cidade do ano de 1997 e que foram superiores a 1000.

SELECT reg.pais, reg.estado, reg.cidade, sum(ven.unidade)
    from vendas ven
    join periodo per on ven.periodo_codigo = per.codigo
    join cliente cli on ven.cliente_codigo = cli.codigo
    join regiao reg on cli.regiao_codigo = reg.codigo
  where per.ano = 1997
group by reg.estado, reg.pais, reg.cidade HAVING sum(ven.unidade) > 1000