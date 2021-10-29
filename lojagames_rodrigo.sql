-- drop database lojagames_rodrigo;
CREATE database lojagames_rodrigo;
use lojagames_rodrigo;

CREATE TABLE Desenvolvedor(
desenvolvedor_id integer not null auto_increment,
desenvolvedor_nome varchar(30) NOT NULL,
desenvolvedor_paginaweb varchar(50) NOT NULL,
primary key (desenvolvedor_id));

CREATE TABLE Distribuidora(
distribuidora_id integer not null auto_increment,
distribuidora_nome varchar(30) NOT NULL,
distribuidora_paginaweb varchar(50) NOT NULL,
primary key (distribuidora_id));

CREATE TABLE Jogo(
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

CREATE TABLE Genero(
genero_id integer not null auto_increment,
genero_nome varchar(30) NOT NULL,
primary key (genero_id));

CREATE TABLE JogoGenero(
jogo_id integer not null,
genero_id integer not null,
primary key (jogo_id, genero_id),
foreign key (jogo_id) references Jogo(jogo_id),
foreign key (genero_id) references Genero(genero_id));

CREATE TABLE Usuario(
usuario_username varchar(20) NOT NULL,
usuario_apelido varchar(20) NOT NULL,
primary key (usuario_username));

CREATE TABLE UsuarioAmigo(
usuario_username varchar(20) NOT NULL,
amigo_username varchar(20) NOT NULL,
primary key (usuario_username, amigo_username),
foreign key (usuario_username) references Usuario(usuario_username),
foreign key (amigo_username) references Usuario(usuario_username));

CREATE TABLE CarteiraVirtual(
carteira_id integer NOT NULL AUTO_INCREMENT,
usuario_username varchar(20) NOT NULL,
carteira_saldo FLOAT NOT NULL,
primary key (carteira_id, usuario_username),
foreign key (usuario_username) references Usuario(usuario_username));

CREATE TABLE Transacao(
transacao_id integer NOT NULL AUTO_INCREMENT,
carteira_id integer NOT NULL,
jogo_id integer NOT NULL,
transacao_datacompra DATE NOT NULL,
transacao_valorcompra FLOAT NOT NULL,
transacao_formapagamento varchar(30) NOT NULL,
primary key (transacao_id, carteira_id, jogo_id),
foreign key (carteira_id) references CarteiraVirtual(carteira_id),
foreign key (jogo_id) references Jogo(jogo_id));

CREATE TABLE Conquista(
conquista_id integer NOT NULL AUTO_INCREMENT,
jogo_id integer NOT NULL,
conquista_nome varchar(20) NOT NULL,
conquista_descricao varchar(50) NOT NULL,
primary key (conquista_id, jogo_id),
foreign key (jogo_id) references Jogo(jogo_id));

CREATE TABLE UsuarioConquista(
usuario_username varchar(20) NOT NULL,
conquista_id integer NOT NULL,
primary key (usuario_username, conquista_id),
foreign key (usuario_username) references Usuario(usuario_username),
foreign key (conquista_id) references Conquista(conquista_id));

CREATE TABLE ListaDesejosItem(
desejos_item_id integer NOT NULL AUTO_INCREMENT,
usuario_username varchar(20) NOT NULL,
jogo_id integer NOT NULL,
desejos_item_dataadicao DATE NOT NULL,
desejos_item_prioridade integer NOT NULL,
primary key (desejos_item_id, usuario_username, jogo_id),
foreign key (usuario_username) references Usuario(usuario_username),
foreign key (jogo_id) references Jogo(jogo_id));

CREATE TABLE BibliotecaItem(
biblioteca_item_id integer NOT NULL AUTO_INCREMENT,
usuario_username varchar(20) NOT NULL,
jogo_id integer NOT NULL,
biblioteca_item_tempojogo TIME NOT NULL,
primary key (biblioteca_item_id, usuario_username, jogo_id),
foreign key (usuario_username) references Usuario(usuario_username),
foreign key (jogo_id) references Jogo(jogo_id));

INSERT INTO usuario VALUES('teixeira0', 'Teixeira');
INSERT INTO usuario VALUES('jackfmd', 'Jack');
INSERT INTO usuario VALUES('psukiyama', 'Pedro');
INSERT INTO usuario VALUES('olgamorais', 'Olga');
INSERT INTO usuario VALUES('claraiane', 'Clara');

INSERT INTO desenvolvedor (desenvolvedor_nome, desenvolvedor_paginaweb) VALUES('Mojang', 'mojang.com');
INSERT INTO desenvolvedor (desenvolvedor_nome, desenvolvedor_paginaweb) VALUES('Treyarc', 'treyarc.com');
INSERT INTO desenvolvedor (desenvolvedor_nome, desenvolvedor_paginaweb) VALUES('Ubisoft Montreal', 'ubisoft.ca');
INSERT INTO desenvolvedor (desenvolvedor_nome, desenvolvedor_paginaweb) VALUES('Nintendo Japan', 'nintendo.co.jp');
INSERT INTO desenvolvedor (desenvolvedor_nome, desenvolvedor_paginaweb) VALUES('343 Studios', '343studios.com');

INSERT INTO distribuidora (distribuidora_nome, distribuidora_paginaweb) VALUES('Microsoft', 'microsoft.com');
INSERT INTO distribuidora (distribuidora_nome, distribuidora_paginaweb) VALUES('Nintendo', 'nintendo.com');
INSERT INTO distribuidora (distribuidora_nome, distribuidora_paginaweb) VALUES('Ubisoft', 'Ubisoft.com');
INSERT INTO distribuidora (distribuidora_nome, distribuidora_paginaweb) VALUES('Activision', 'activision.com');
INSERT INTO distribuidora (distribuidora_nome, distribuidora_paginaweb) VALUES('Sega', 'sega.com');

INSERT INTO genero (genero_nome) VALUES('First Person Shooter');
INSERT INTO genero (genero_nome) VALUES('Plataforma');
INSERT INTO genero (genero_nome) VALUES('Mundo Aberto');
INSERT INTO genero (genero_nome) VALUES('Aventura');
INSERT INTO genero (genero_nome) VALUES('Multiplayer'); 

INSERT INTO jogo (desenvolvedor_id, distribuidora_id, jogo_nome, jogo_preco, jogo_lancamento, jogo_foto, jogo_classificacao) 
VALUES ((SELECT desenvolvedor_id FROM desenvolvedor WHERE desenvolvedor_nome = '343 Studios'), 
        (SELECT distribuidora_id FROM distribuidora WHERE distribuidora_nome = 'Microsoft'),
        'Halo', 100, DATE('2010-10-05'), LOAD_FILE("C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/games/halo.jfif"), '18 anos');

INSERT INTO jogo (desenvolvedor_id, distribuidora_id, jogo_nome, jogo_preco, jogo_lancamento, jogo_foto, jogo_classificacao) 
VALUES ((SELECT desenvolvedor_id FROM desenvolvedor WHERE desenvolvedor_nome = 'Nintendo Japan'), 
        (SELECT distribuidora_id FROM distribuidora WHERE distribuidora_nome = 'Nintendo'),
        'Super Mario', 200, DATE('2001-01-27'), LOAD_FILE("C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/games/mario.png"), 'Livre');
        
INSERT INTO jogo (desenvolvedor_id, distribuidora_id, jogo_nome, jogo_preco, jogo_lancamento, jogo_foto, jogo_classificacao) 
VALUES ((SELECT desenvolvedor_id FROM desenvolvedor WHERE desenvolvedor_nome = 'Ubisoft Montreal'), 
        (SELECT distribuidora_id FROM distribuidora WHERE distribuidora_nome = 'Ubisoft'),
        'Assassins Creed', 50, DATE('2006-07-31'), LOAD_FILE("C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/games/assassins.webp"), '18 anos');
        
INSERT INTO jogo (desenvolvedor_id, distribuidora_id, jogo_nome, jogo_preco, jogo_lancamento, jogo_foto, jogo_classificacao) 
VALUES ((SELECT desenvolvedor_id FROM desenvolvedor WHERE desenvolvedor_nome = 'Treyarc'), 
        (SELECT distribuidora_id FROM distribuidora WHERE distribuidora_nome = 'Activision'),
        'Call of Duty', 100, DATE('2021-02-27'), LOAD_FILE("C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/games/cod.jpg"), '18 anos');

INSERT INTO jogo (desenvolvedor_id, distribuidora_id, jogo_nome, jogo_preco, jogo_lancamento, jogo_foto, jogo_classificacao) 
VALUES ((SELECT desenvolvedor_id FROM desenvolvedor WHERE desenvolvedor_nome = 'Mojang'), 
        (SELECT distribuidora_id FROM distribuidora WHERE distribuidora_nome = 'Microsoft'),
        'Minecraft', 30, DATE('2011-05-20'), LOAD_FILE("C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/games/minecraft.jpg"), '10 anos');

INSERT INTO jogogenero VALUES (
	(SELECT jogo_id FROM jogo WHERE jogo_nome = "Halo"),
    (SELECT genero_id FROM genero WHERE genero_nome = "First Person Shooter"));
INSERT INTO jogogenero VALUES (
	(SELECT jogo_id FROM jogo WHERE jogo_nome = "Halo"),
    (SELECT genero_id FROM genero WHERE genero_nome = "Aventura"));

INSERT INTO jogogenero VALUES (
	(SELECT jogo_id FROM jogo WHERE jogo_nome = "Super Mario"),
    (SELECT genero_id FROM genero WHERE genero_nome = "Plataforma"));
INSERT INTO jogogenero VALUES (
	(SELECT jogo_id FROM jogo WHERE jogo_nome = "Super Mario"),
    (SELECT genero_id FROM genero WHERE genero_nome = "Aventura"));

INSERT INTO jogogenero VALUES (
	(SELECT jogo_id FROM jogo WHERE jogo_nome = "Assassins Creed"),
    (SELECT genero_id FROM genero WHERE genero_nome = "Aventura"));
INSERT INTO jogogenero VALUES (
	(SELECT jogo_id FROM jogo WHERE jogo_nome = "Assassins Creed"),
    (SELECT genero_id FROM genero WHERE genero_nome = "Mundo Aberto"));

INSERT INTO jogogenero VALUES (
	(SELECT jogo_id FROM jogo WHERE jogo_nome = "Call of Duty"),
    (SELECT genero_id FROM genero WHERE genero_nome = "First Person Shooter"));
INSERT INTO jogogenero VALUES (
	(SELECT jogo_id FROM jogo WHERE jogo_nome = "Call of Duty"),
    (SELECT genero_id FROM genero WHERE genero_nome = "Multiplayer"));

INSERT INTO jogogenero VALUES (
	(SELECT jogo_id FROM jogo WHERE jogo_nome = "Minecraft"),
    (SELECT genero_id FROM genero WHERE genero_nome = "Mundo Aberto"));
INSERT INTO jogogenero VALUES (
	(SELECT jogo_id FROM jogo WHERE jogo_nome = "Minecraft"),
    (SELECT genero_id FROM genero WHERE genero_nome = "Multiplayer"));

INSERT INTO usuarioamigo VALUES ('teixeira0', 'jackfmd');
INSERT INTO usuarioamigo VALUES ('teixeira0', 'olgamorais');

INSERT INTO usuarioamigo VALUES ('claraiane', 'olgamorais');
INSERT INTO usuarioamigo VALUES ('claraiane', 'jackfmd');

INSERT INTO usuarioamigo VALUES ('jackfmd', 'claraiane');
INSERT INTO usuarioamigo VALUES ('jackfmd', 'psukiyama');

INSERT INTO usuarioamigo VALUES ('olgamorais', 'claraiane');
INSERT INTO usuarioamigo VALUES ('olgamorais', 'teixeira0');

INSERT INTO usuarioamigo VALUES ('psukiyama', 'teixeira0');
INSERT INTO usuarioamigo VALUES ('psukiyama', 'jackfmd');

INSERT INTO carteiravirtual (usuario_username, carteira_saldo) VALUES ('claraiane', 50);
INSERT INTO carteiravirtual (usuario_username, carteira_saldo) VALUES ('psukiyama', 50);
INSERT INTO carteiravirtual (usuario_username, carteira_saldo) VALUES ('jackfmd', 50);
INSERT INTO carteiravirtual (usuario_username, carteira_saldo) VALUES ('teixeira0', 50);
INSERT INTO carteiravirtual (usuario_username, carteira_saldo) VALUES ('olgamorais', 50);

INSERT INTO conquista (jogo_id, conquista_nome, conquista_descricao) VALUES (
(SELECT jogo_id FROM jogo WHERE jogo_nome = 'Halo'), "O Primeiro Passo", "Entrou no jogo pela primeira vez");
INSERT INTO conquista (jogo_id, conquista_nome, conquista_descricao) VALUES (
(SELECT jogo_id FROM jogo WHERE jogo_nome = 'Halo'), "Terminou!", "Finalizou o jogo!");

INSERT INTO conquista (jogo_id, conquista_nome, conquista_descricao) VALUES (
(SELECT jogo_id FROM jogo WHERE jogo_nome = 'Minecraft'), "O Primeiro Passo", "Entrou no jogo pela primeira vez");
INSERT INTO conquista (jogo_id, conquista_nome, conquista_descricao) VALUES (
(SELECT jogo_id FROM jogo WHERE jogo_nome = 'Minecraft'), "Terminou!", "Finalizou o jogo!");

INSERT INTO conquista (jogo_id, conquista_nome, conquista_descricao) VALUES (
(SELECT jogo_id FROM jogo WHERE jogo_nome = 'Call of Duty'), "O Primeiro Passo", "Entrou no jogo pela primeira vez");
INSERT INTO conquista (jogo_id, conquista_nome, conquista_descricao) VALUES (
(SELECT jogo_id FROM jogo WHERE jogo_nome = 'Call of Duty'), "Terminou!", "Finalizou o jogo!");

INSERT INTO conquista (jogo_id, conquista_nome, conquista_descricao) VALUES (
(SELECT jogo_id FROM jogo WHERE jogo_nome = 'Assassins Creed'), "O Primeiro Passo", "Entrou no jogo pela primeira vez");
INSERT INTO conquista (jogo_id, conquista_nome, conquista_descricao) VALUES (
(SELECT jogo_id FROM jogo WHERE jogo_nome = 'Assassins Creed'), "Terminou!", "Finalizou o jogo!");

INSERT INTO conquista (jogo_id, conquista_nome, conquista_descricao) VALUES (
(SELECT jogo_id FROM jogo WHERE jogo_nome = 'Super Mario'), "O Primeiro Passo", "Entrou no jogo pela primeira vez");
INSERT INTO conquista (jogo_id, conquista_nome, conquista_descricao) VALUES (
(SELECT jogo_id FROM jogo WHERE jogo_nome = 'Super Mario'), "Terminou!", "Finalizou o jogo!");

INSERT INTO listadesejositem (usuario_username, jogo_id, desejos_item_dataadicao, desejos_item_prioridade) VALUES (
'claraiane', (SELECT jogo_id FROM jogo WHERE jogo_nome = 'Halo'), DATE('2021-02-23'), 1);
INSERT INTO listadesejositem (usuario_username, jogo_id, desejos_item_dataadicao, desejos_item_prioridade) VALUES (
'claraiane', (SELECT jogo_id FROM jogo WHERE jogo_nome = 'Super Mario'), DATE('2021-05-12'), 2);
INSERT INTO bibliotecaitem (usuario_username, jogo_id, biblioteca_item_tempojogo) VALUES (
'claraiane', (SELECT jogo_id FROM jogo WHERE jogo_nome = 'Call of Duty'), TIME('01:25:00'));
INSERT INTO bibliotecaitem (usuario_username, jogo_id, biblioteca_item_tempojogo) VALUES (
'claraiane', (SELECT jogo_id FROM jogo WHERE jogo_nome = 'Minecraft'), TIME('02:35:00'));
INSERT INTO transacao (carteira_id, jogo_id, transacao_datacompra, transacao_valorcompra, transacao_formapagamento) VALUES (
(SELECT carteira_id FROM carteiravirtual WHERE usuario_username = 'claraiane'), (SELECT jogo_id FROM jogo WHERE jogo_nome = 'Call of Duty'),
DATE('2020-04-29'), (SELECT jogo_preco FROM jogo WHERE jogo_nome = 'Call of Duty'), 'Cartao de Credito');
INSERT INTO transacao (carteira_id, jogo_id, transacao_datacompra, transacao_valorcompra, transacao_formapagamento) VALUES (
(SELECT carteira_id FROM carteiravirtual WHERE usuario_username = 'claraiane'), (SELECT jogo_id FROM jogo WHERE jogo_nome = 'Minecraft'),
DATE('2020-07-14'), (SELECT jogo_preco FROM jogo WHERE jogo_nome = 'Minecraft'), 'Boleto');
INSERT INTO usuarioconquista VALUES ('claraiane', 5); 
INSERT INTO usuarioconquista VALUES ('claraiane', 3); 

INSERT INTO listadesejositem (usuario_username, jogo_id, desejos_item_dataadicao, desejos_item_prioridade) VALUES (
'olgamorais', (SELECT jogo_id FROM jogo WHERE jogo_nome = 'Super Mario'), DATE('2021-02-23'), 1);
INSERT INTO listadesejositem (usuario_username, jogo_id, desejos_item_dataadicao, desejos_item_prioridade) VALUES (
'olgamorais', (SELECT jogo_id FROM jogo WHERE jogo_nome = 'Minecraft'), DATE('2021-05-12'), 2);
INSERT INTO bibliotecaitem (usuario_username, jogo_id, biblioteca_item_tempojogo) VALUES (
'olgamorais', (SELECT jogo_id FROM jogo WHERE jogo_nome = 'Call of Duty'), TIME('01:25:00'));
INSERT INTO bibliotecaitem (usuario_username, jogo_id, biblioteca_item_tempojogo) VALUES (
'olgamorais', (SELECT jogo_id FROM jogo WHERE jogo_nome = 'Halo'), TIME('02:35:00'));
INSERT INTO transacao (carteira_id, jogo_id, transacao_datacompra, transacao_valorcompra, transacao_formapagamento) VALUES (
(SELECT carteira_id FROM carteiravirtual WHERE usuario_username = 'olgamorais'), (SELECT jogo_id FROM jogo WHERE jogo_nome = 'Call of Duty'),
DATE('2020-04-29'), (SELECT jogo_preco FROM jogo WHERE jogo_nome = 'Call of Duty'), 'Cartao de Credito');
INSERT INTO transacao (carteira_id, jogo_id, transacao_datacompra, transacao_valorcompra, transacao_formapagamento) VALUES (
(SELECT carteira_id FROM carteiravirtual WHERE usuario_username = 'olgamorais'), (SELECT jogo_id FROM jogo WHERE jogo_nome = 'Halo'),
DATE('2020-07-14'), (SELECT jogo_preco FROM jogo WHERE jogo_nome = 'Halo'), 'Boleto');
INSERT INTO usuarioconquista VALUES ('olgamorais', 5);
INSERT INTO usuarioconquista VALUES ('olgamorais', 1);  

INSERT INTO listadesejositem (usuario_username, jogo_id, desejos_item_dataadicao, desejos_item_prioridade) VALUES (
'jackfmd', (SELECT jogo_id FROM jogo WHERE jogo_nome = 'Call of Duty'), DATE('2021-02-23'), 1);
INSERT INTO listadesejositem (usuario_username, jogo_id, desejos_item_dataadicao, desejos_item_prioridade) VALUES (
'jackfmd', (SELECT jogo_id FROM jogo WHERE jogo_nome = 'Assassins Creed'), DATE('2021-05-12'), 2);
INSERT INTO bibliotecaitem (usuario_username, jogo_id, biblioteca_item_tempojogo) VALUES (
'jackfmd', (SELECT jogo_id FROM jogo WHERE jogo_nome = 'Super Mario'), TIME('01:25:00'));
INSERT INTO bibliotecaitem (usuario_username, jogo_id, biblioteca_item_tempojogo) VALUES (
'jackfmd', (SELECT jogo_id FROM jogo WHERE jogo_nome = 'Minecraft'), TIME('02:35:00'));
INSERT INTO transacao (carteira_id, jogo_id, transacao_datacompra, transacao_valorcompra, transacao_formapagamento) VALUES (
(SELECT carteira_id FROM carteiravirtual WHERE usuario_username = 'jackfmd'), (SELECT jogo_id FROM jogo WHERE jogo_nome = 'Super Mario'),
DATE('2020-04-29'), (SELECT jogo_preco FROM jogo WHERE jogo_nome = 'Super Mario'), 'Cartao de Credito');
INSERT INTO transacao (carteira_id, jogo_id, transacao_datacompra, transacao_valorcompra, transacao_formapagamento) VALUES (
(SELECT carteira_id FROM carteiravirtual WHERE usuario_username = 'jackfmd'), (SELECT jogo_id FROM jogo WHERE jogo_nome = 'Minecraft'),
DATE('2020-07-14'), (SELECT jogo_preco FROM jogo WHERE jogo_nome = 'Minecraft'), 'Boleto');
INSERT INTO usuarioconquista VALUES ('jackfmd', 9);
INSERT INTO usuarioconquista VALUES ('jackfmd', 3);  

INSERT INTO listadesejositem (usuario_username, jogo_id, desejos_item_dataadicao, desejos_item_prioridade) VALUES (
'psukiyama', (SELECT jogo_id FROM jogo WHERE jogo_nome = 'Super Mario'), DATE('2021-02-23'), 1);
INSERT INTO listadesejositem (usuario_username, jogo_id, desejos_item_dataadicao, desejos_item_prioridade) VALUES (
'psukiyama', (SELECT jogo_id FROM jogo WHERE jogo_nome = 'Halo'), DATE('2021-05-12'), 2);
INSERT INTO bibliotecaitem (usuario_username, jogo_id, biblioteca_item_tempojogo) VALUES (
'psukiyama', (SELECT jogo_id FROM jogo WHERE jogo_nome = 'Call of Duty'), TIME('01:25:00'));
INSERT INTO bibliotecaitem (usuario_username, jogo_id, biblioteca_item_tempojogo) VALUES (
'psukiyama', (SELECT jogo_id FROM jogo WHERE jogo_nome = 'Minecraft'), TIME('02:35:00'));
INSERT INTO transacao (carteira_id, jogo_id, transacao_datacompra, transacao_valorcompra, transacao_formapagamento) VALUES (
(SELECT carteira_id FROM carteiravirtual WHERE usuario_username = 'psukiyama'), (SELECT jogo_id FROM jogo WHERE jogo_nome = 'Call of Duty'),
DATE('2020-04-29'), (SELECT jogo_preco FROM jogo WHERE jogo_nome = 'Call of Duty'), 'Cartao de Credito');
INSERT INTO transacao (carteira_id, jogo_id, transacao_datacompra, transacao_valorcompra, transacao_formapagamento) VALUES (
(SELECT carteira_id FROM carteiravirtual WHERE usuario_username = 'psukiyama'), (SELECT jogo_id FROM jogo WHERE jogo_nome = 'Minecraft'),
DATE('2020-07-14'), (SELECT jogo_preco FROM jogo WHERE jogo_nome = 'Minecraft'), 'Boleto');
INSERT INTO usuarioconquista VALUES ('psukiyama', 5);
INSERT INTO usuarioconquista VALUES ('psukiyama', 3);  

INSERT INTO listadesejositem (usuario_username, jogo_id, desejos_item_dataadicao, desejos_item_prioridade) VALUES (
'teixeira0', (SELECT jogo_id FROM jogo WHERE jogo_nome = 'Minecraft'), DATE('2021-02-23'), 1);
INSERT INTO listadesejositem (usuario_username, jogo_id, desejos_item_dataadicao, desejos_item_prioridade) VALUES (
'teixeira0', (SELECT jogo_id FROM jogo WHERE jogo_nome = 'Halo'), DATE('2021-05-12'), 2);
INSERT INTO bibliotecaitem (usuario_username, jogo_id, biblioteca_item_tempojogo) VALUES (
'teixeira0', (SELECT jogo_id FROM jogo WHERE jogo_nome = 'Call of Duty'), TIME('01:25:00'));
INSERT INTO bibliotecaitem (usuario_username, jogo_id, biblioteca_item_tempojogo) VALUES (
'teixeira0', (SELECT jogo_id FROM jogo WHERE jogo_nome = 'Assassins Creed'), TIME('02:35:00'));
INSERT INTO transacao (carteira_id, jogo_id, transacao_datacompra, transacao_valorcompra, transacao_formapagamento) VALUES (
(SELECT carteira_id FROM carteiravirtual WHERE usuario_username = 'teixeira0'), (SELECT jogo_id FROM jogo WHERE jogo_nome = 'Call of Duty'),
DATE('2020-04-29'), (SELECT jogo_preco FROM jogo WHERE jogo_nome = 'Call of Duty'), 'Cartao de Credito');
INSERT INTO transacao (carteira_id, jogo_id, transacao_datacompra, transacao_valorcompra, transacao_formapagamento) VALUES (
(SELECT carteira_id FROM carteiravirtual WHERE usuario_username = 'teixeira0'), (SELECT jogo_id FROM jogo WHERE jogo_nome = 'Assassins Creed'),
DATE('2020-07-14'), (SELECT jogo_preco FROM jogo WHERE jogo_nome = 'Assassins Creed'), 'Boleto');
INSERT INTO usuarioconquista VALUES ('teixeira0', 7);
INSERT INTO usuarioconquista VALUES ('teixeira0', 5);

CREATE VIEW conquistas_alcancadas AS SELECT usuario_apelido, jogo_nome, conquista_nome, conquista_descricao FROM usuario, jogo, conquista, usuarioconquista 
WHERE usuario.usuario_username = usuarioconquista.usuario_username AND conquista.conquista_id = usuarioconquista.conquista_id AND 
jogo.jogo_id = conquista.jogo_id;

delimiter //

CREATE PROCEDURE quantas_conquistas_faltam (IN username varchar(20))
BEGIN
	DECLARE done INT DEFAULT FALSE;
	DECLARE conq, conq_pega INTEGER;
    DECLARE jogoid1, jogoid2 INTEGER;
	DECLARE cur2 CURSOR FOR SELECT conquista.conquista_id, jogo.jogo_id FROM jogo, conquista, bibliotecaitem WHERE 
	  conquista.jogo_id = jogo.jogo_id AND bibliotecaitem.jogo_id = jogo.jogo_id AND bibliotecaitem.usuario_username = username;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur2;
    
    loop1: LOOP
		FETCH cur2 INTO conq, jogoid1;
        IF done THEN 
			LEAVE loop1;
		END IF;
        block2:BEGIN
        DECLARE done2 INT DEFAULT FALSE;
            DECLARE cur1 CURSOR FOR SELECT conquista.conquista_id, jogo.jogo_id FROM jogo, usuarioconquista, conquista, bibliotecaitem WHERE 
			  jogo.jogo_id = conquista.jogo_id AND usuarioconquista.usuario_username = username AND 
			  bibliotecaitem.usuario_username = username AND bibliotecaitem.jogo_id = jogo.jogo_id AND 
			  usuarioconquista.conquista_id = conquista.conquista_id;
		    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done2 = TRUE;  
            OPEN cur1;
        loop2: LOOP
			FETCH cur1 INTO conq_pega, jogoid2;
            IF done2 THEN 
				LEAVE loop2;
			END IF;
            IF conq != conq_pega AND jogoid1 = jogoid2 THEN
				SELECT jogo_nome, conquista.conquista_nome, conquista.conquista_descricao FROM conquista, jogo 
                WHERE conquista.conquista_id = conq AND jogo.jogo_id = conquista.jogo_id;
			END IF;
		END LOOP;
        CLOSE cur1;
        END block2;
	END LOOP;
            
    CLOSE cur2;
END //

delimiter ;

-- CALL quantas_conquistas_faltam('teixeira0');
