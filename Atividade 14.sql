create table faixa
(fxa_sequencia integer not null,
valor_minimo decimal(10,2) not null,
valor_maximo decimal(10,2) not null,
desconto decimal(10,5) not null,
constraint pk_faixa primary key (fxa_sequencia));

create table pedido
(ped_sequencia integer not null,
data timestamp not null,
valor  decimal(10,2) not null,
cli_sequencia integer not null,
sit_sequencia integer not null,
constraint pk_pedido primary key (ped_sequencia, sit_sequencia, cli_sequencia));

create table situacao
(sit_sequencia integer not null,
descricao varchar(10) not null,
constraint pk_situacao primary key (sit_sequencia));

create table cliente
(cli_sequencia integer not null,
nome varchar(30) not null,
contato varchar(50) not null,
saldo decimal(10,2) not null,
pago decimal(10,2) not null,
constraint pk_cliente primary key (cli_sequencia));

alter table pedido
add constraint cliente_pedido_fk
foreign key (cli_sequencia) references cliente
(cli_sequencia);

alter table pedido
add constraint situacao_pedido_fk
foreign key (sit_sequencia) references situacao
(sit_sequencia);

---------------------------------------------------------------

create table pedidoitem 
(pdi_sequencia integer not null,
ped_sequencia integer not null,
pro_sequencia integer not null,
quantidade integer not null
constraint pk_pedidoitem primary key (pdi_sequencia, pro_sequencia, ped_sequencia));

create table categoria
(cat_sequencia integer not null,
descricao varchar(50) not null,
desconto decimal(10,2) not null,
constraint pk_categoria primary key(cat_sequencia));

create table produto
(pro_sequencia integer not null,
descricao varchar(50) not null,
valorunitario decimal(10,2) not null,
preco decimal(10,2) not null,
estoque integer not null,
cat_sequencia integer not null,
constraint pk_produto primary key (pro_sequencia, cat_sequencia);)

create table encomendaitem
(eci_sequencia integer not null,
enc_sequencia integer not null,
pro_sequencia integer not null,
quantidade varchar not null,
constraint pk_encomendaitem primary key (eci_sequencia, enc_sequencia, pro_sequencia));

create table encomenda
(enc_sequencia integer not null,
data timestamp not null
valor decimal(10,2) not null,
sit_sequencia integer not null,
constraint pk_encomenda primary key(enc_sequencia, sit_sequencia));

alter table pedidoitem
add constraint pedido_pedidoitem_fk
foreign key (ped_sequencia) references pedido
(ped_sequencia);

alter table  pedidoitem
add constraint produto_pedidoitem_fk
foreign key (pro_sequencia) references produto
(pro_sequencia);

alter table encomenda
add constraint encomenda_situacao_fk
foreign key (sit_sequencia) references situacao
(sit_sequencia);

alter table encomendaitem
add constraint encomendaitem_produto_fk
foreign key (pro_sequencia) references produto
(pro_sequencia);

alter table encomendaitem
add constraint encomendaitem_encomenda_fk
foreign key (enc_sequencia) references encomenda
(enc_sequencia);

alter table produto
add constraint produto_categoria_fk
foreign key (cat_sequencia) references categoria
(cat_sequencia);