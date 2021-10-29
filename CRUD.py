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
  FRIENDS = 9
  WALLET = 10

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
          new_nickname = input("Digite o seu novo Apelido: ")
          self.__persistence.changeNickname(username, new_nickname)
          self.setState(States.START, username)
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

      if (self.state == States.LIBRARY):
        username = self.params
        nickname = self.__persistence.getUser(username)
        print(" -- Biblioteca de Jogos de "+ nickname + " -- ")
        print(" ")
        games = self.__persistence.getLibrary(username)
        print("  JOGO  |  TEMPO DE JOGO  |  DATA DE COMPRA ")
        for game in games:
          print("  " + game[1] + "  |  " + str(int(game[2].total_seconds()//3600)) + "h" + str(int((game[2].total_seconds()%3600)//60)) + "m  |  " + self.__persistence.getTransactionDate(username, game[0]).strftime("%d/%m/%Y"))
        print(" ")
        input("Pressione 'enter' para retornar.")
        self.setState(States.START, username)
        continue        

      if (self.state == States.WISHLIST):
        username = self.params
        nickname = self.__persistence.getUser(username)
        print(" -- Lista de Desejos de "+ nickname + " -- ")
        print(" ")
        games = self.__persistence.getWishlist(username)
        print("  ITEM  |  JOGO  |  DATA DE ADIÇÃO  |  PRIORIDADE ")
        item = 1
        for game in games:
          print("  " + str(item) + "  |  " + game[1] + "  |  " + game[2].strftime("%d/%m/%Y") + "  |  " + str(game[3]))
          item += 1
        print(" ")
        print(" ")
        print("1 - Mudar a prioridadede um item.")
        print("2 - Remover um item da lista.")
        print(" ")
        print("0 - Voltar.")
        print(" ")
        action = input(nickname + ", digite o que deseja fazer: ")
        if (action == "0"):
          self.setState(States.START,username)
          continue
        if (action == "1"):
          item = input("Digite o numero do item que gostaria de modificar: ")
          priority = input("Digite o novo valor de prioridade para este item: ")
          self.__persistence.changePriority(username, games[int(item)-1][0], priority)
          self.setState(States.WISHLIST, username)
          continue
        if (action == "2"):
          item = input("Digite o numero do item que gostaria de remover: ")
          self.__persistence.removeFromWishlist(username, games[int(item)-1][0])
          self.setState(States.WISHLIST, username)
          continue   

      if (self.state == States.FRIENDS):
        username = self.params
        nickname = self.__persistence.getUser(username)
        print(" -- Amigos de "+ nickname + " -- ")
        print(" ")
        friends = self.__persistence.getFriends(username)
        item = 1
        for friend in friends:
          print("  " + str(item) + "  |  " + friend[1])
          item += 1
        print(" ")
        print(" ")
        print("1 - Adicionar um amigo.")
        print("2 - Remover um amigo.")
        print(" ")
        print("0 - Voltar.")
        print(" ")
        action = input(nickname + ", digite o que deseja fazer: ")
        if (action == "0"):
          self.setState(States.START,username)
          continue              
        if (action == "1"):
          new_friend = input("Digite o username do amigo que deseja adicionar: ")
          self.__persistence.addFriend(username, new_friend)
          self.setState(States.FRIENDS, username)
          continue
        if (action == "2"):
          new_friend = input("Digite o numero do amigo que deseja remover da lista: ")
          self.__persistence.removeFriend(username, friends[int(new_friend)-1][0])
          self.setState(States.FRIENDS, username)
          continue
      if (self.state == States.WALLET):
        username = self.params
        nickname = self.__persistence.getUser(username)
        print(" -- Carteira Virtual de "+ nickname + " -- ")
        print(" ") 
        wallet = self.__persistence.getWallet(username)
        print("Saldo: R$ " + str(wallet[1]))
        print(" ")
        print(" -- Transações -- ") 
        print(" ")
        print("  ITEM  |  JOGO  |  VALOR DA COMPRA  |  DATA DA COMPRA  |  FORMA DE PAGAMENTO")
        transactions = self.__persistence.getTransactions(username)
        item = 1
        for transaction in transactions:
          print("  " + str(item) + "  |  " + transaction[0] + "  |  R$ " + str(transaction[1]) + "  |  " + transaction[2].strftime("%d/%m/%Y") + "  |  " + transaction[3])
          item += 1
        print(" ")
        input("Pressione 'enter' para retornar.")
        self.setState(States.START, username)
        continue 


store = GameStore()
store.run()