-- exemplo de média

select reg.descricao, round(avg (itm.valor_bruto), 2)
	from item itm
	join pedido ped on itm.ped_codigo = ped.ped_codigo
	join consumidor con on ped.con_codigo = con.con_codigo
	join cidade cid on con.cid_codigo = cid.cid_codigo
	join pais pai on cid.pai_codigo = pai.pai_codigo
	join regiao reg on pai.reg_codigo = reg.reg_codigo
   where itm.valor_bruto > 250
  group by 1 having avg(itm.valor_bruto)> 760



-- 1	Listar os nomes, bem como a descrição do segmento, o nome da cidade, o estado, o nome do pais,
--      do mercado e da região de cada consumidor cadastrados.

select con.nome, cid.nome, pai.nome,
	   mer.descricao, reg.descricao, seg.descricao 
	from consumidor con
	join cidade cid on con.cid_codigo = cid.cid_codigo
	join pais pai on cid.pai_codigo = pai.pai_codigo
	join mercado mer on pai.mer_codigo =  mer.mer_codigo
	join regiao reg on pai.reg_codigo = reg.reg_codigo
	join segmento seg on con.seg_codigo = seg.seg_codigo
	

-- 2	Listar os nomes, bem como a descrição do segmento, o nome da cidade, o estado, 
--      o nome do pais, do mercado e da região de cada consumidor que comprou no ano de 2013.

select distinct con.nome, cid.nome, pai.nome,
	   mer.descricao, reg.descricao, seg.descricao 
	from pedido ped
	join consumidor con on ped.con_codigo = con.con_codigo
	join cidade cid on con.cid_codigo = cid.cid_codigo
	join pais pai on cid.pai_codigo = pai.pai_codigo
	join mercado mer on pai.mer_codigo =  mer.mer_codigo
	join regiao reg on pai.reg_codigo = reg.reg_codigo
	join segmento seg on con.seg_codigo = seg.seg_codigo
where extract (year from ped.data_pedido) = 2013


-- 3	Listar os nomes, bem como a descrição do segmento, o nome da cidade, o estado, o nome do pais, 
--      do mercado e da região de cada consumidor que comprou no ano de 2013 algum produto da categoria Forniture. 

select con.nome, cid.nome, pai.nome,
	   mer.descricao, reg.descricao, seg.descricao, cat.descricao
	from item itm
	join pedido ped on itm.ped_codigo = ped.ped_codigo
	join consumidor con on ped.con_codigo = con.con_codigo
	join cidade cid on con.cid_codigo = cid.cid_codigo
	join pais pai on cid.pai_codigo = pai.pai_codigo
	join mercado mer on pai.mer_codigo =  mer.mer_codigo
	join regiao reg on pai.reg_codigo = reg.reg_codigo
	join segmento seg on con.seg_codigo = seg.seg_codigo
	join produto pro on itm.pro_codigo = pro.pro_codigo
	join subcategoria sub on pro.sub_codigo = sub.sub_codigo
	join categoria cat on sub.cat_codigo = cat.cat_codigo
  where extract (year from ped.data_pedido) = 2013
 and cat.descricao = 'Furniture'


 -- 4	Listar os pedidos dos clientes do mercado West no ano de 2012.
 
 select ped.interno, ped.data_pedido
	from pedido ped
	join consumidor con on ped.con_codigo = con.con_codigo
	join cidade cid on con.cid_codigo = cid.cid_codigo
	join pais pai on cid.pai_codigo = pai.pai_codigo
	join mercado mer on pai.mer_codigo =  mer.mer_codigo
where extract (year from ped.data_pedido) = 2012
 and mer.descricao = 'US'
  order by 2
  
  
-- 5	Listar os pedidos da categoria Technology no ano de 2014 no pais China. 

select ped.interno, ped.data_pedido, pai.nome, cat.descricao
	from item itm
	join pedido ped on itm.ped_codigo = ped.ped_codigo
	join consumidor con on ped.con_codigo = con.con_codigo
	join cidade cid on con.cid_codigo = cid.cid_codigo
	join pais pai on cid.pai_codigo = pai.pai_codigo
	join mercado mer on pai.mer_codigo =  mer.mer_codigo
	join regiao reg on pai.reg_codigo = reg.reg_codigo
	join segmento seg on con.seg_codigo = seg.seg_codigo
	join produto pro on itm.pro_codigo = pro.pro_codigo
	join subcategoria sub on pro.sub_codigo = sub.sub_codigo
	join categoria cat on sub.cat_codigo = cat.cat_codigo
  where extract (year from ped.data_pedido) = 2014
 and cat.descricao = 'Technology'
 and pai.nome = 'China'


-- 6	Listar os 10 países com maior quantidade de vendas.

select pai.nome, sum (itm.quantidade) as total
	from item itm
	join pedido ped on itm.ped_codigo = ped.ped_codigo
	join consumidor con on ped.con_codigo = con.con_codigo
	join cidade cid on con.cid_codigo = cid.cid_codigo
	join pais pai on cid.pai_codigo = pai.pai_codigo
  group by 1
 order by 2 desc
limit 10



-- 7	Listar as 10 cidades com maior lucro nas vendas no ano de 2014.

select cid.nome, sum(itm.valor_lucro) as total
	from item itm
	join pedido ped on itm.ped_codigo = ped.ped_codigo
	join consumidor con on ped.con_codigo = con.con_codigo
	join cidade cid on con.cid_codigo = cid.cid_codigo
	join pais pai on cid.pai_codigo = pai.pai_codigo
	where extract (year from ped.data_pedido) = 2014
  group by 1
 order by 2 desc
limit 10


-- 8	Listar o valor médio dos pedidos por região.


select reg.descricao, round(avg (itm.valor_bruto), 2)
	from item itm
	join pedido ped on itm.ped_codigo = ped.ped_codigo
	join consumidor con on ped.con_codigo = con.con_codigo
	join cidade cid on con.cid_codigo = cid.cid_codigo
	join pais pai on cid.pai_codigo = pai.pai_codigo
	join regiao reg on pai.reg_codigo = reg.reg_codigo
  group by 1
  
 -- 9	Listar o valor médio dos pedidos por categoria quando o valor da entrega for maior que 20.
 
 select cat.descricao as categoria, round(avg(valor_bruto),3) as media
	from item itm
	join pedido ped on itm.ped_codigo = ped.ped_codigo
	join consumidor con on ped.con_codigo = con.con_codigo
	join cidade cid on con.cid_codigo = cid.cid_codigo
	join pais pai on cid.pai_codigo = pai.pai_codigo
	join mercado mer on pai.mer_codigo =  mer.mer_codigo
	join regiao reg on pai.reg_codigo = reg.reg_codigo
	join segmento seg on con.seg_codigo = seg.seg_codigo
	join produto pro on itm.pro_codigo = pro.pro_codigo
	join subcategoria sub on pro.sub_codigo = sub.sub_codigo
	join categoria cat on sub.cat_codigo = cat.cat_codigo
  where itm.valor_entrega > 20
group by 1
 
 
-- 10	Listar a soma das vendas por mês nos anos de 2011 e 2012.


select ped.data_pedido, sum(itm.quantidade) as total 
	from item itm
	join pedido ped on itm.ped_codigo = ped.ped_codigo      -- Errada
    WHERE EXTRACT (MONTH from ped.data_pedido)
   WHERE EXTRACT (year from ped.data_pedido) = 2011 or EXTRACT (YEAR from ped.data_pedido) = 2012
   GROUP by 1


-- 11 Listar a soma das vendas por subcategorias, com exceção do ano de 2014, nos itens que apresentaram lucro.

select sub.descricao, sum(itm.valor_lucro) as total
	from item itm 
	join produto pro on itm.pro_codigo = pro.pro_codigo         -- Errada
	join subcategoria sub on pro.sub_codigo = sub.sub_codigo
	join pedido ped on itm.ped_codigo = ped.ped_codigo
   where ped.data_pedido <> (2014);


--12 Listar a soma dos valores das entregas dos países (5 maiores), apenas quando o valor da entrega for maior que 20.

select pai.nome, sum(itm.valor_entrega) as total
	from item itm 
	join pedido ped on itm.ped_codigo = ped.ped_codigo
	join consumidor con on ped.con_codigo = con.con_codigo
	join cidade cid on con.cid_codigo = cid.cid_codigo
	join pais pai on cid.pai_codigo = pai.pai_codigo
   where itm.valor_entrega > 20
 group by 1
limit 5

-- 13 Listar a soma das vendas dos países no ano de 2014 cujo a soma das vendas for maior que 10000.

select pai.nome, sum(valor_bruto) as total
	from item itm 
	join pedido ped on itm.ped_codigo = ped.ped_codigo
	join consumidor con on ped.con_codigo = con.con_codigo
	join cidade cid on con.cid_codigo = cid.cid_codigo
	join pais pai on cid.pai_codigo = pai.pai_codigo
   where extract (year from ped.data_pedido) = 2014
 group by 1 HAVING sum(itm.quantidade) > 10000
limit 10


--14 Listar a soma das vendas dos países no ano de 2014 cujo a soma das vendas for maior que 10000, 
--   considerando os valores de entrega maiores que 20.


select pai.nome, sum(itm.quantidade) as total
	from item itm 
	join pedido ped on itm.ped_codigo = ped.ped_codigo
	join consumidor con on ped.con_codigo = con.con_codigo
	join cidade cid on con.cid_codigo = cid.cid_codigo
	join pais pai on cid.pai_codigo = pai.pai_codigo
   where extract (year from ped.data_pedido) = 2014
 group by 1 HAVING sum(itm.quantidade) > 10000 or sum(itm.valor_entrega) > 20
limit 10


--15 Listar a região e a categoria com os cinco maiores lucros nas vendas no ano de 2013.


select reg.descricao, cat.descricao, sum(itm.valor_lucro) as total
	from item itm 
	join pedido ped on itm.ped_codigo = ped.ped_codigo
	join consumidor con on ped.con_codigo = con.con_codigo
	join cidade cid on con.cid_codigo = cid.cid_codigo
	join pais pai on cid.pai_codigo = pai.pai_codigo
	join regiao reg on pai.reg_codigo = reg.reg_codigo    errada
	join produto pro on itm.pro_codigo = pro.pro_codigo
	join subcategoria sub on pro.sub_codigo = sub.sub_codigo
	join categoria cat on sub.cat_codigo = cat.cat_codigo
   where extract (year from ped.data_pedido) = 2013
   GROUP by 1
limit 5
