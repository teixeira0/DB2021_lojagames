from persistencia import Persistence
from enum import Enum
from os import system, name

class States(Enum):
  LOGIN = 1
  START = 2
  STORE = 3
  GAME = 4
  ADD_TO_WISHLIST = 5
  BUY = 6
  LIBRARY = 7
  WISHLIST = 8
  REMOVE_FROM_WISHLIST = 9
  CHANGE_PRIORITY = 10
  CHANGE_NICKNAME = 11
  FRIENDS = 12
  ADD_FRIEND = 13
  REMOVE_FRIEND = 14
  WALLET = 15

def clear():
  system('cls')

class GameStore:
  def __init__(self):
    self.__persistence = Persistence()
    self.params = ()
    self.state = (States.LOGIN)

  def setState(self, state, params = 0):
    self.state = state
    self.params = params

  def run(self):
    while True:
      clear()
      if (self.state == States.LOGIN):
        print("Bem-vindo ou bem-vinda a loja de games digitais!")
        username = input("Digite seu username para fazer Login: ")
        self.setState(States.START, username)
        continue
      
      if (self.state == States.START):
        username = self.params
        nickname = self.__persistence.getUser(username)
        print(" -- Loja de Games --")
        print(" ")
        print("Bem-vindo(a) " + nickname)
        print(" ")
        print("1 - Loja")
        print("2 - Biblioteca de jogos")
        print("3 - Lista de desejos")
        print("4 - Amigos")
        print("5 - Carteira Virtual")
        print("6 - Mudar Apelido")
        print(" ")
        print("0 - Log out")
        print(" ")
        action = input("Digite o que deseja fazer: ")
        print(action)
        if (action == "0"):
          self.setState(States.LOGIN, username)
          continue
        if (action == "1"):
          self.setState(States.STORE, username)
          continue
        if (action == "2"):
          self.setState(States.LIBRARY, username)
          continue
        if (action == "3"):
          self.setState(States.WISHLIST, username)
          continue
        if (action == "4"):
          self.setState(States.FRIENDS, username)
          continue
        if (action == "5"):
          self.setState(States.WALLET, username)
          continue
        if (action == "6"):
          self.setState(States.CHANGE_NICKNAME, username)
          continue

      if (self.state == States.STORE):
        username = self.params
        nickname = self.__persistence.getUser(username)
        print(" -- Jogos Disponíveis para Venda -- ")
        print(" ")
        games = self.__persistence.getGames()
        game_index = 1
        for game in games:
          print(str(game_index) + " - " + game[1])
          game_index += 1
        print(" ")
        print("0 - Voltar")
        print(" ")
        option = input(nickname + ", digite qual jogo gostaria de ver: ")
        if (option == "0"):
          self.setState(States.START, username)
          continue
        else:
          self.setState(States.GAME, (username, games[int(option)-1]))
          continue

      if (self.state == States.GAME):
        username = self.params[0]
        nickname = self.__persistence.getUser(username)
        game = self.params[1]
        genres = self.__persistence.getGenres(game[0])
        print(" -- Jogo: " + game[1] + " -- ")
        print(" ")
        print("Desenvolvedora: " + self.__persistence.getDev(game[2]))
        print("Distribuidora: " + self.__persistence.getDist(game[3]))
        print(" ")
        print("Gênero(s):")
        for genre in genres:
          print(genre)
        print(" ")
        print("Preço: R$ " + game[4])
        print(" ")
        print("Data de Lançamento: " + game[5].strftime("%d/%m/%Y"))
        print("Classificação Indicativa: " + game[6])  
        print(" ")
        print(" ")
        print("1 - Comprar jogo.")
        print("2 - Adicionar à Lista de Desejos.")
        print(" ")
        print("0 - Voltar.")
        print(" ")
        action = input(nickname + ", digite o que deseja fazer: ")
        if (action == "0"):
          self.setState(States.STORE, username)
          continue
        if (action == "1"):
          self.setState(States.BUY, (username, game[0]))
          continue
        if (action == "2"):
          self.setState(States.ADD_TO_WISHLIST, (username, game[0]))
          continue

      if (self.state == States.BUY):
        username = self.params[0]
        nickname = self.__persistence.getUser(username)
        game_id = self.params[1]
        game_name = self.__persistence.getGame(game_id)
        print("-- Comprar Jogo --")
        print(" ")
        print("Gostaria de comprar o jogo " + game_name + "?")
        print(" ")
        print("1 - Sim")
        print("2 - Não")
        action = input(nickname + ", digite o que deseja fazer: ")
        if (action == "1"):
          method = ""
          print("1 - Cartão de Crédito")
          print("2 - Boleto")
          action = input("Selecione a forma de pagamento: ")
          if (action == "1"):
            method = "Cartão de Crédito"
          else:
            method = "Boleto"
          self.__persistence.buyGame(username, game_id, method)
          input("Jogo comprado com sucesso! Pressione 'enter' para continuar.")
        self.setState(States.STORE, username)
        continue

      if (self.state == States.ADD_TO_WISHLIST):
        username = self.params[0]
        nickname = self.__persistence.getUser(username)
        game_id = self.params[1]
        game_name = self.__persistence.getGame(game_id)
        print("-- Adicionar à Lista de Desejos --")
        print(" ")
        print("Gostaria de adicionar o jogo " + game_name + " à sua Lista de Desejos?")
        print(" ")
        print("1 - Sim")
        print("2 - Não")
        action = input(nickname + ", digite o que deseja fazer: ")
        if (action == "1"):
          priority = input("Selecione um número de prioridade para este item na sua lista: ")
          self.__persistence.addToWishlist(username, game_id, priority)
          input("Adicionado com sucesso! Pressione 'enter' para continuar.")
        self.setState(States.STORE, username)
        continue



      







store = GameStore()
store.run()