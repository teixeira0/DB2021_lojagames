create database lojagames_rodrigo;
use lojagames_rodrigo;

create table Desenvolvedor(
desenvolvedor_id integer not null auto_increment,
desenvolvedor_nome varchar(30) NOT NULL,
desenvolvedor_paginaweb varchar(50) NOT NULL,
primary key (desenvolvedor_id));

create table Distribuidora(
distribuidora_id integer not null auto_increment,
distribuidora_nome varchar(30) NOT NULL,
distribuidora_paginaweb varchar(50) NOT NULL,
primary key (distribuidora_id));

create table Jogo(
jogo_id integer not null auto_increment,
desenvolvedor_id integer not null,
distribuidora_id integer not null,
jogo_nome varchar(30) not null,
jogo_preco varchar(10) NOT NULL,
jogo_lancamento DATE NOT NULL,
jogo_foto BLOB NOT NULL,
jogo_classificacao varchar(10) NOT NULL,
primary key (jogo_id),
foreign key (desenvolvedor_id) references Desenvolvedor(desenvolvedor_id),
foreign key (distribuidora_id) references Distribuidora(distribuidora_id));

create table Genero(
genero_id integer not null auto_increment,
genero_nome varchar(30) NOT NULL,
primary key (genero_id));

create table JogoGenero(
jogo_id integer not null,
genero_id integer not null,
primary key (jogo_id, genero_id),
foreign key (jogo_id) references Jogo(jogo_id),
foreign key (genero_id) references Genero(genero_id));

create table Usuario(
usuario_username varchar(20) NOT NULL,
usuario_apelido varchar(20) NOT NULL,
primary key (usuario_username));

create table UsuarioAmigo(
usuario_username varchar(20) NOT NULL,
amigo_username varchar(20) NOT NULL,
primary key (usuario_username, amigo_username),
foreign key (usuario_username) references Usuario(usuario_username),
foreign key (amigo_username) references Usuario(usuario_username));

create table CarteiraVirtual(
carteira_id integer NOT NULL AUTO_INCREMENT,
usuario_username varchar(20) NOT NULL,
carteira_saldo FLOAT NOT NULL,
primary key (carteira_id, usuario_username),
foreign key (usuario_username) references Usuario(usuario_username));

create table Transacao(
transacao_id integer NOT NULL AUTO_INCREMENT,
carteira_id integer NOT NULL,
jogo_id integer NOT NULL,
transacao_datacompra DATE NOT NULL,
transacao_valorcompra FLOAT NOT NULL,
transacao_formapagamento varchar(30) NOT NULL,
primary key (transacao_id, carteira_id, jogo_id),
foreign key (carteira_id) references CarteiraVirtual(carteira_id),
foreign key (jogo_id) references Jogo(jogo_id));

create table Conquista(
conquista_id integer NOT NULL AUTO_INCREMENT,
jogo_id integer NOT NULL,
conquista_nome varchar(20) NOT NULL,
conquista_descricao varchar(50) NOT NULL,
primary key (conquista_id, jogo_id),
foreign key (jogo_id) references Jogo(jogo_id));

create table UsuarioConquista(
usuario_username varchar(20) NOT NULL,
conquista_id integer NOT NULL,
primary key (usuario_username, conquista_id),
foreign key (usuario_username) references Usuario(usuario_username),
foreign key (conquista_id) references Conquista(conquista_id));

create table ListaDesejosItem(
desejos_item_id integer NOT NULL AUTO_INCREMENT,
usuario_username varchar(20) NOT NULL,
jogo_id integer NOT NULL,
desejos_item_dataadicao DATE NOT NULL,
desejos_item_prioridade integer NOT NULL,
primary key (desejos_item_id, usuario_username, jogo_id),
foreign key (usuario_username) references Usuario(usuario_username),
foreign key (jogo_id) references Jogo(jogo_id));

create table BibliotecaItem(
biblioteca_item_id integer NOT NULL AUTO_INCREMENT,
usuario_username varchar(20) NOT NULL,
jogo_id integer NOT NULL,
biblioteca_item_tempojogo TIME NOT NULL,
primary key (biblioteca_item_id, usuario_username, jogo_id),
foreign key (usuario_username) references Usuario(usuario_username),
foreign key (jogo_id) references Jogo(jogo_id));

insert into usuario values('teixeira0', 'Teixeira');
insert into usuario values('jackfmd', 'Jack');
insert into usuario values('psukiyama', 'Pedro');
insert into usuario values('olgamorais', 'Olga');
insert into usuario values('claraiane', 'Clara');

insert into desenvolvedor (desenvolvedor_nome, desenvolvedor_paginaweb) values('Mojang', 'mojang.com');
insert into desenvolvedor (desenvolvedor_nome, desenvolvedor_paginaweb) values('Treyarc', 'treyarc.com');
insert into desenvolvedor (desenvolvedor_nome, desenvolvedor_paginaweb) values('Ubisoft Montreal', 'ubisoft.ca');
insert into desenvolvedor (desenvolvedor_nome, desenvolvedor_paginaweb) values('Nintendo Japan', 'nintendo.co.jp');
insert into desenvolvedor (desenvolvedor_nome, desenvolvedor_paginaweb) values('343 Studios', '343studios.com');

insert into distribuidora (distribuidora_nome, distribuidora_paginaweb) values('Microsoft', 'microsoft.com');
insert into distribuidora (distribuidora_nome, distribuidora_paginaweb) values('Nintendo', 'nintendo.com');
insert into distribuidora (distribuidora_nome, distribuidora_paginaweb) values('Ubisoft', 'Ubisoft.com');
insert into distribuidora (distribuidora_nome, distribuidora_paginaweb) values('Activision', 'activision.com');
insert into distribuidora (distribuidora_nome, distribuidora_paginaweb) values('Sega', 'sega.com');

insert into genero (genero_nome) values('First Person Shooter');
insert into genero (genero_nome) values('Plataforma');
insert into genero (genero_nome) values('Mundo Aberto');
insert into genero (genero_nome) values('Aventura');
insert into genero (genero_nome) values('Multiplayer'); 

insert into jogo (desenvolvedor_id, distribuidora_id, jogo_nome, jogo_preco, jogo_lancamento, jogo_foto, jogo_classificacao) 
values ((SELECT desenvolvedor_id from desenvolvedor where desenvolvedor_nome = '343 Studios'), 
        (SELECT distribuidora_id from distribuidora where distribuidora_nome = 'Microsoft'),
        'Halo', 100, DATE('2010-10-05'), LOAD_FILE("C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/games/halo.jfif"), '18 anos');

insert into jogo (desenvolvedor_id, distribuidora_id, jogo_nome, jogo_preco, jogo_lancamento, jogo_foto, jogo_classificacao) 
values ((SELECT desenvolvedor_id from desenvolvedor where desenvolvedor_nome = 'Nintendo Japan'), 
        (SELECT distribuidora_id from distribuidora where distribuidora_nome = 'Nintendo'),
        'Super Mario', 200, DATE('2001-01-27'), LOAD_FILE("C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/games/mario.png"), 'Livre');
        
insert into jogo (desenvolvedor_id, distribuidora_id, jogo_nome, jogo_preco, jogo_lancamento, jogo_foto, jogo_classificacao) 
values ((SELECT desenvolvedor_id from desenvolvedor where desenvolvedor_nome = 'Ubisoft Montreal'), 
        (SELECT distribuidora_id from distribuidora where distribuidora_nome = 'Ubisoft'),
        'Assassins Creed', 50, DATE('2006-07-31'), LOAD_FILE("C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/games/assassins.webp"), '18 anos');
        
insert into jogo (desenvolvedor_id, distribuidora_id, jogo_nome, jogo_preco, jogo_lancamento, jogo_foto, jogo_classificacao) 
values ((SELECT desenvolvedor_id from desenvolvedor where desenvolvedor_nome = 'Treyarc'), 
        (SELECT distribuidora_id from distribuidora where distribuidora_nome = 'Activision'),
        'Call of Duty', 100, DATE('2021-02-27'), LOAD_FILE("C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/games/cod.jpg"), '18 anos');

insert into jogo (desenvolvedor_id, distribuidora_id, jogo_nome, jogo_preco, jogo_lancamento, jogo_foto, jogo_classificacao) 
values ((SELECT desenvolvedor_id from desenvolvedor where desenvolvedor_nome = 'Mojang'), 
        (SELECT distribuidora_id from distribuidora where distribuidora_nome = 'Microsoft'),
        'Minecraft', 30, DATE('2011-05-20'), LOAD_FILE("C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/games/minecraft.jpg"), '10 anos');

insert into jogogenero values (
	(SELECT jogo_id from jogo where jogo_nome = "Halo"),
    (SELECT genero_id from genero where genero_nome = "First Person Shooter"));
insert into jogogenero values (
	(SELECT jogo_id from jogo where jogo_nome = "Halo"),
    (SELECT genero_id from genero where genero_nome = "Aventura"));

insert into jogogenero values (
	(SELECT jogo_id from jogo where jogo_nome = "Super Mario"),
    (SELECT genero_id from genero where genero_nome = "Plataforma"));
insert into jogogenero values (
	(SELECT jogo_id from jogo where jogo_nome = "Super Mario"),
    (SELECT genero_id from genero where genero_nome = "Aventura"));

insert into jogogenero values (
	(SELECT jogo_id from jogo where jogo_nome = "Assassins Creed"),
    (SELECT genero_id from genero where genero_nome = "Aventura"));
insert into jogogenero values (
	(SELECT jogo_id from jogo where jogo_nome = "Assassins Creed"),
    (SELECT genero_id from genero where genero_nome = "Mundo Aberto"));

insert into jogogenero values (
	(SELECT jogo_id from jogo where jogo_nome = "Call of Duty"),
    (SELECT genero_id from genero where genero_nome = "First Person Shooter"));
insert into jogogenero values (
	(SELECT jogo_id from jogo where jogo_nome = "Call of Duty"),
    (SELECT genero_id from genero where genero_nome = "Multiplayer"));

insert into jogogenero values (
	(SELECT jogo_id from jogo where jogo_nome = "Minecraft"),
    (SELECT genero_id from genero where genero_nome = "Mundo Aberto"));
insert into jogogenero values (
	(SELECT jogo_id from jogo where jogo_nome = "Minecraft"),
    (SELECT genero_id from genero where genero_nome = "Multiplayer"));