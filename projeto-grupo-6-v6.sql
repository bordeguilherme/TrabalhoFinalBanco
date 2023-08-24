DROP database IF EXISTS "projeto_grupo6";

DROP table IF EXISTS pedido_produto;
DROP table IF EXISTS estoque;
DROP table IF EXISTS pedido;
DROP table IF EXISTS produto;
DROP table IF EXISTS categoria;
DROP table IF EXISTS usuario;

-- CREATES

create database "projeto_grupo6";

create table usuario (
	usu_cd_id serial primary key,
	usu_tx_nome varchar(50),
	usu_tx_end varchar(40),
	usu_txt_telefone varchar(11),
	usu_int_numero_usu integer,
	usu_tx_email varchar(30),
	usu_tx_cpf varchar(11),
	usu_dt_data_nasc date
);

create table categoria (
	cat_cd_id serial primary key,
	cat_tx_nome varchar(20),
	cat_tx_descricao varchar(120)
);

create table produto (
	prodt_cd_id serial primary key,
	prodt_tx_nome varchar(50),
	prodt_tx_descricao varchar(120),
	prodt_dt_fab date,
	prodt_int_estoque integer,
	prodt_nm_valor decimal,
	fk_cat_cd_id int references categoria(cat_cd_id),
	fk_usu_cd_int int references usuario(usu_cd_id)
);

create table pedido (
	ped_cd_id serial primary key,
	ped_dt_data timestamp,
	fk_usu_cd_id int references usuario(usu_cd_id)
	--fk_prodt_cd_id int references produto(prodt_cd_id)
);


create table estoque (
	estq_cd_id serial primary key,
	estq_int_total integer,	
	fk_prodt_cd_id int references produto(prodt_cd_id)
);


create table pedido_produto (
	fk_ped_cd_id int references pedido(ped_cd_id),
	fk_prodt_cd_id int references produto(prodt_cd_id)
);

-- Roles
drop user cliente;
drop user vendedor;

-- Cria role de "cliente":
create user cliente;
revoke all privileges on all tables in schema public from cliente;
grant insert on pedido to cliente;
grant update on usuario to cliente;
grant select on produto, pedido to cliente;

-- Cria role de "vendedor":
create user vendedor;
revoke all privileges on all tables in schema public from vendedor;
grant select, insert, update, delete on produto, estoque to vendedor;
grant select on categoria, pedido to vendedor;

grant all
on all sequences in schema public
to vendedor, cliente;

-- INSERTS

-- Inserir usuários
insert into usuario (usu_tx_nome, usu_tx_end, usu_txt_telefone, usu_int_numero_usu, usu_tx_email, usu_tx_cpf, usu_dt_data_nasc )
values ('Maria', 'Rua do Limao', '2499998765', 1727, 'maria@email.com', '10363603777', '2000-09-12'),
       ('Guilherme Borde', 'Rua Cascatinha', '24988898765', 4533, 'gui@email.com', '10288878909', '1998-08-22'),
       ('Igor Moura', 'Rua Joao Pessoa', '24967548755', 7667, 'igao@email.com', '10897878912', '1988-03-22'),
       ('Estevao Montes', 'Rua Thouzet', '24988892764', 5462, 'estevao@email.com', '10275478901', '1991-02-04'),
       ('Jose Lourenco', 'Rua da Feira', '21988893456', 7809, 'zelo@email.com', '19888878653', '1972-01-12');

-- Inserir categorias
insert into categoria (cat_tx_nome, cat_tx_descricao)
values ('Eletronicos', 'Dispositivos eletronicos'),
       ('Moda e beleza', 'Roupas e acessorios diversos'),
       ('Esportes e lazer', 'Produtos e acessorios esportivos');

-- Inserir produtos
insert into produto (prodt_tx_nome, prodt_tx_descricao, prodt_dt_fab, prodt_int_estoque, prodt_nm_valor, fk_cat_cd_id, fk_usu_cd_int)
values('Laptop LG', 'Core i5, 500GB de SSD, 15.6 full HD', '2023-02-05', 10, 2200, 1, 4);

insert into estoque (estq_int_total, fk_prodt_cd_id) 
values (10,  1);

insert into produto (prodt_tx_nome, prodt_tx_descricao, prodt_dt_fab, prodt_int_estoque, prodt_nm_valor, fk_cat_cd_id, fk_usu_cd_int)
values('Samsung Galaxy', 'A8 Wi-Fi, 64 GB, 4GB RAM, Tela de 10.5" Grafite', '2022-01-09', 5, 3200, 1, 4),
      ('Computador Desktop Itautec', 'SM3330 AMD Phenom – 4GB RAM – 320GB HD - Linux', '2022-12-23', 7, 1800, 1, 4),
      ('Relogio Smartwatch', 'Feminino Fit Dourado - Glory Fit', '2021-11-11', 3, 6300, 1, 4),
      ('Receptor Adaptador', 'Bluetooth Conector P2 Áudio Stereo 5.1 Qualidade Usb - OPEN ZEE', '2021-12-17', 12, 1100, 1, 4),
      ('Jaqueta jeans', 'Jaqueta jeans, com botões, tamanho 14, infanto juvenil.', '2022-11-19', 3, 300, 2, 2),
      ('Short saia Zara', 'Short saia cor vermelha tamanho 40', '2019-11-22', 3, 200, 2, 2),
      ('Camisa social', 'Camisa social slim fit tamanho P', '2022-12-12', 4, 450, 2, 2),
      ('Bota North Face', 'Bota The North Face Storm III Mid WP Feminina', '2020-06-16', 2, 800, 2, 2),
      ('Bermuda Hurley', 'Bermuda Phantom da Hurley com bolsos laterais, tamanho 34', '2023-09-18', 4, 300, 2, 2),
      ('Bicicleta Groove', 'Bicicleta Groove riff 90 com suspensao rockshok com trava no guidao e cambio xt 11v', '2021-06-16', 1, 900, 3, 3),
      ('Chuteira Adidas', 'Chuteira Adidas Predator, tamanho 40', '2021-01-11', 2, 100, 3, 3),
      ('Bola de futevolei', 'Bola de futevolei Nikasa FT-5, produzida no Japao', '2022-02-15', 2, 160, 3, 3),
      ('Raquete de tenis Wilson', 'Raquete Wilson, modele Elite Roland Garros, edição limitada', '2023-06-11', 2, 700, 3, 3),
      ('Prancha de Surf', 'Prancha de Surf Invicta 5.11 de 27 litros', '2022-02-22', 6, 750, 3, 3);
     
insert into estoque (estq_int_total, fk_prodt_cd_id) 
values (25,  2),
       (15,  3),
       (20,  4),
       (32,  5),
       (65,  6),
       (60,  7),
       (110, 8),
       (55,  9),
       (80, 10),
       (8,  11),
       (48, 12),
       (35, 13),
       (47, 14),
       (21, 15);

-- Inserir pedidos
insert into pedido (ped_dt_data, fk_usu_cd_id) values (now(), 2);
insert into pedido (ped_dt_data, fk_usu_cd_id) values (now(), 2);
insert into pedido (ped_dt_data, fk_usu_cd_id) values (now(), 1);

insert into pedido_produto (fk_ped_cd_id, fk_prodt_cd_id) values (1, 1);
insert into pedido_produto (fk_ped_cd_id, fk_prodt_cd_id) values (2, 2);
insert into pedido_produto (fk_ped_cd_id, fk_prodt_cd_id) values (3, 8);

-- INDEX
select * from produto where prodt_tx_nome = 'Jaqueta jeans';
create index idx_produto_nome ON produto (prodt_tx_nome);

SELECT * FROM pedido_produto;
create index idx_produtos on pedido_produto (fk_prodt_cd_id);


-- QUERIES

-- mostra os pedidos com nome do comprador e do vendedor

select pr.prodt_tx_nome, pr.prodt_nm_valor as "valor", usc.usu_tx_nome as "comprador",  usv.usu_tx_nome as "vendedor", pe.ped_dt_data as "data"
from pedido pe
inner join pedido_produto pp
on pe.ped_cd_id = pp.fk_ped_cd_id
inner join produto pr
on pr.prodt_cd_id = pp.fk_prodt_cd_id
inner join usuario usv
on usv.usu_cd_id = pr.fk_cat_cd_id
inner join  usuario usc
on usc.usu_cd_id = pe.fk_usu_cd_id;

-- lista os produtos que custam mais que R$3.000,00

select prodt_tx_nome, prodt_nm_valor
from produto
where prodt_nm_valor > 3000

-- mostra a quantidade de produtos da categoria Eletronicos

select COUNT(fk_cat_cd_id) as "quantidade de produtos da categoria Eletronicos"
from produto
group by fk_cat_cd_id
having fk_cat_cd_id = 1;

-- mostra a quantidade de produtos vendidos por vendedor e seus respectivos nomes de usuario

select us.usu_tx_nome, COUNT(fk_usu_cd_int) as "quantidade de produto por vendedor"
from produto
inner join usuario us
on us.usu_cd_id = fk_usu_cd_int
group by us.usu_tx_nome;


-- VIEW

create view nota_fiscal
as select usc.usu_cd_id as "codigo do comprador", 
pr.prodt_tx_nome as "nome do produto", 
pr.prodt_nm_valor as "valor", 
usc.usu_tx_nome as "comprador",  
usv.usu_tx_nome as "vendedor", 
pe.ped_dt_data as "data"
from pedido pe
inner join pedido_produto pp
on pe.ped_cd_id = pp.fk_ped_cd_id
inner join produto pr
on pr.prodt_cd_id = pp.fk_prodt_cd_id
inner join usuario usv
on usv.usu_cd_id = pr.fk_usu_cd_int
inner join  usuario usc
on usc.usu_cd_id = pe.fk_usu_cd_id;

-- exemplo de nota fiscal por comprador
select * from nota_fiscal where "codigo do comprador" = 2;