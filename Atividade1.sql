create table cliente
(cli_codigo integer not null,
nome varchar(40) not null,
genero char(1) not null,
endereco varchar(100) not null,
constraint pk_cliente primary key (cli_codigo));

create table produto
(pro_codigo integer not null,
descricao varchar(40) not null,
valorunitario numeric(10,2) not null,
constraint pk_produto primary key
(pro_codigo));

create table venda
(cli_codigo integer not null,
pro_codigo integer not null,
ven_data timestamp not null,
quantidade integer not null,
constraint pk_venda primary key (cli_codigo, pro_codigo, ven_data)):

alter table venda
add constraint cliente_venda_fk
foreign key (cli_codigo) references cliente
(cli_codigo);

alter table venda
add constraint produto_venda_fk
foreign key (pro_codigo) references produto
(pro_codigo);