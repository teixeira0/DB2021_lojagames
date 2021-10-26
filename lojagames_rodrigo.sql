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