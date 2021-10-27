import mysql.connector

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

  def getDev(self, game_id):
    cursor=self.__mydb.cursor()
    cursor.execute("SELECT desenvolvedor_nome FROM desenvolvedor, jogo WHERE jogo.desenvolvedor_id = desenvolvedor.desenvolvedor_id AND jogo_id = " + game_id)
    dev = ""
    for x in cursor:
      dev = x
    return dev[0]    
      
  def getDist(self, game_id):
    cursor=self.__mydb.cursor()
    cursor.execute("SELECT distribuidora_nome FROM distribuidora, jogo WHERE jogo.distribuidora_id = distribuidora.distribuidora_id AND jogo_id = " + game_id)
    dist = ""
    for x in cursor:
      dist = x
    return dist[0]    

  def getGames(self):
    cursor=self.__mydb.cursor()
    cursor.execute("SELECT * FROM jogo")
    games = []
    for x in cursor:
      games.append(x)
    return games

  def getGenres(self, game_id):
    cursor=self.__mydb.cursor()
    cursor.execute("SELECT genero_nome FROM jogogenero, jogo, genero WHERE jogo.jogo_id = jogogenero.jogo_id AND genero.genero_id = jogogenero.genero_id AND jogogenero.jogo_id = " + game_id)
    genres = []
    for x in cursor:
      genres.append(x[0])
    return genres
    
persist = Persistence()
print(persist.getGenres("5"))

