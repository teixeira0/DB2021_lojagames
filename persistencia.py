import mysql.connector
from datetime import date

class Persistence:
  def __init__(self):
    self.__mydb = mysql.connector.connect(
      host="localhost",
      user="root",
      password="teixeira",
      database="lojagames_rodrigo"  
    )

  def getUsers(self):
    cursor=self.__mydb.cursor()
    cursor.execute("SELECT * FROM usuario")
    users = []
    for x in cursor:
      users.append(x)
    return users

  def getDev(self, dev_id):
    cursor=self.__mydb.cursor()
    cursor.execute("SELECT desenvolvedor_nome FROM desenvolvedor WHERE desenvolvedor_id = " + str(dev_id))
    dev = ""
    for x in cursor:
      dev = x
    return dev[0]    
      
  def getDist(self, dist_id):
    cursor=self.__mydb.cursor()
    cursor.execute("SELECT distribuidora_nome FROM distribuidora WHERE distribuidora_id = " + str(dist_id))
    dist = ""
    for x in cursor:
      dist = x
    return dist[0]    

  def getGames(self):
    cursor=self.__mydb.cursor()
    cursor.execute("SELECT jogo_id, jogo_nome, desenvolvedor_id, distribuidora_id, jogo_preco, jogo_lancamento, jogo_classificacao FROM jogo")
    games = []
    for x in cursor:
      games.append(x)
    return games

  def getGame(self, game_id):
    cursor=self.__mydb.cursor()
    cursor.execute("SELECT jogo_nome FROM jogo WHERE jogo_id = " + str(game_id))
    game = ""
    for x in cursor:
      game = x
    return game[0]    

  def getGamePic(self, game_id):
    cursor=self.__mydb.cursor()
    cursor.execute("SELECT jogo_foto FROM jogo WHERE jogo_id = " + str(game_id))
    pic = ""
    for x in cursor:
      pic = x
    return pic[0]   

  def getGenres(self, game_id):
    cursor=self.__mydb.cursor()
    cursor.execute("SELECT genero_nome FROM jogogenero, jogo, genero WHERE jogo.jogo_id = jogogenero.jogo_id AND genero.genero_id = jogogenero.genero_id AND jogogenero.jogo_id = " + str(game_id))
    genres = []
    for x in cursor:
      genres.append(x[0])
    return genres

  def getFriends(self, username):
    cursor=self.__mydb.cursor()
    cursor.execute("SELECT usuario.usuario_username, usuario_apelido FROM usuario, usuarioamigo WHERE usuario.usuario_username = amigo_username AND usuarioamigo.usuario_username = \"" + username + "\"")
    friends = []
    for x in cursor:
      friends.append(x)
    return friends

  def getUser(self, username):
    cursor=self.__mydb.cursor()
    cursor.execute("SELECT usuario_apelido FROM usuario WHERE usuario_username = \"" + username + "\"")
    username = ""
    for x in cursor:
      username = x
    return username[0]   

  def getWishlist(self, username):
    cursor=self.__mydb.cursor()
    cursor.execute("SELECT jogo.jogo_id, jogo_nome, desejos_item_dataadicao, desejos_item_prioridade FROM listadesejositem, jogo WHERE jogo.jogo_id = listadesejositem.jogo_id AND usuario_username = \"" + username + "\"")
    wishlist = []
    for x in cursor:
      wishlist.append(x)
    return wishlist        
    
  def getLibrary(self, username):
    cursor=self.__mydb.cursor()
    cursor.execute("SELECT jogo.jogo_id, jogo_nome, biblioteca_item_tempojogo FROM bibliotecaitem, jogo WHERE jogo.jogo_id = bibliotecaitem.jogo_id AND usuario_username = \"" + username + "\"")
    library = []
    for x in cursor:
      library.append(x)
    return library         

  def getWallet(self, username):
    cursor=self.__mydb.cursor()
    cursor.execute("SELECT carteira_id, carteira_saldo FROM carteiravirtual WHERE usuario_username = \"" + username + "\"")
    wallet = ""
    for x in cursor:
      wallet = x
    return wallet     

  def getTransactions(self, username):
    cursor=self.__mydb.cursor()
    cursor.execute("SELECT jogo_nome, transacao_valorcompra, transacao_datacompra, transacao_formapagamento FROM transacao, jogo, carteiravirtual \
      WHERE jogo.jogo_id = transacao.jogo_id AND carteiravirtual.carteira_id = transacao.carteira_id AND usuario_username = \"" + username + "\"")
    transactions = []
    for x in cursor:
      transactions.append(x)
    return transactions         

  def getTransactionDate(self, username, game_id):
    cursor=self.__mydb.cursor()
    cursor.execute("SELECT transacao_datacompra FROM transacao, carteiravirtual \
      WHERE transacao.carteira_id = carteiravirtual.carteira_id AND usuario_username = \"" + username +"\" AND jogo_id = " + str(game_id))
    date = ""
    for x in cursor:
      date = x
    return date[0]         

  def addToWishlist(self, username, game_id, priority):
    cursor=self.__mydb.cursor()
    cursor.execute("INSERT INTO listadesejositem (usuario_username, jogo_id, desejos_item_dataadicao, desejos_item_prioridade) VALUES (\
      \"" + username + "\" , " + str(game_id) + ", DATE('" + date.today().strftime("%Y-%m-%d") +  "'), " + priority + ")")    
    self.__mydb.commit()

  def removeFromWishlist(self, username, game_id):
    cursor=self.__mydb.cursor()
    cursor.execute("DELETE FROM listadesejositem WHERE usuario_username = \"" + username +"\" AND jogo_id = " + str(game_id))   
    self.__mydb.commit()

  def addFriend(self, username, friend_username):
    cursor=self.__mydb.cursor()
    cursor.execute("INSERT INTO usuarioamigo VALUES ('"+ username + "', '" + friend_username + "')")
    self.__mydb.commit()

  def removeFriend(self, username, friend_username):
    cursor=self.__mydb.cursor()
    cursor.execute("DELETE FROM usuarioamigo WHERE usuario_username= '"+ username + "' AND amigo_username = '" + friend_username + "'")
    self.__mydb.commit()
 
  def changeNickname(self, username, new_nickname):
    cursor=self.__mydb.cursor()
    cursor.execute("UPDATE usuario SET usuario_apelido = '" + new_nickname + "' WHERE usuario_username = '" + username + "'")
    self.__mydb.commit()

  def changePriority(self, username, game_id, new_priority):
    cursor=self.__mydb.cursor()
    cursor.execute("UPDATE listadesejositem SET desejos_item_prioridade = " + new_priority + " WHERE usuario_username = '" + username + "' AND jogo_id = " + str(game_id))
    self.__mydb.commit()

  def buyGame(self, username, game_id, payment_method):
    cursor=self.__mydb.cursor()
    cursor.execute("INSERT INTO bibliotecaitem (usuario_username, jogo_id, biblioteca_item_tempojogo) VALUES (\
      '" + username + "', " + str(game_id) + ", TIME('00:00:00'))")
    cursor.execute("INSERT INTO transacao (carteira_id, jogo_id, transacao_datacompra, transacao_valorcompra, transacao_formapagamento) VALUES (\
      (SELECT carteira_id FROM carteiravirtual WHERE usuario_username = '" + username + "'), " + str(game_id) + 
      ", DATE('" + date.today().strftime("%Y-%m-%d") +  "'), (SELECT jogo_preco FROM jogo WHERE jogo_id = " + str(game_id) + "), '" + payment_method + "');")
    self.__mydb.commit()