class Player
  attr_accessor :name, :symbol
  def initialize(name,symbol)
    @name = name
    @symbol = symbol
  end
  
  def to_s
    "-> #{@name} turns ('#{@symbol}')"
  end
end

class Board
  def initialize
    puts "--- Let's play TicTacToe ---"
    @board = Array.new(9, " ")
  end

  def display
    puts "-----------------------------"
    puts "#{@board[0] != " " ? @board[0] : "0"} | #{@board[1] != " " ? @board[1] : "1"} | #{@board[2] != " " ? @board[2] : "2"}"
    puts "--+---+--"
    puts "#{@board[3] != " " ? @board[3] : "3"} | #{@board[4] != " " ? @board[4] : "4"} | #{@board[5] != " " ? @board[5] : "5"}"
    puts "--+---+--"
    puts "#{@board[6] != " " ? @board[6] : "6"} | #{@board[7] != " " ? @board[7] : "7"} | #{@board[8] != " " ? @board[8] : "8"}"
    puts "-----------------------------"
  end

  def update(player,position)
    if @board[position] != " "
      puts "Position already taken! Choose another."
      return false
    end
    @board[position] = player.symbol
  end

  def winner(player)
    win_positions = [
      [0,1,2],
      [3,4,5],
      [6,7,8],
      [0,3,6],
      [1,4,7],
      [2,5,8],
      [0,4,8],
      [2,4,6]
    ]
    win_positions.each do |pos|
      a,b,c = pos
      return true if @board[a] != " " && @board[a] == @board[b] && @board[b] == @board[c]
    end
    false
  end
end

class Game
  attr_accessor :player1, :player2, :current_player, :board, :counter
  def initialize()
    @counter = 0
    @board = Board.new
    @player1 = Player.new("Player1","O")
    @player2 = Player.new("Player2","X")
    @current_player = @player1
  end
  
  def play
    loop do
      board.display
      puts @current_player
      puts "Enter number between (0-8)"
      num = gets
      next puts "Please enter valid number" unless num.to_i.between?(0,8)
      puts "You Entered #{num}"
      next unless @board.update(@current_player,num.to_i)
      @counter += 1
      if @board.winner(current_player)
        @board.display
        return puts "Match Finish, #{@current_player.name} Wins!"
      end
      if counter == 9
        @board.display
        puts "--- Match Draw ---" 
        return
      end
      if @current_player == @player1
        @current_player = @player2
      else
        @current_player = @player1
      end
    end
  end
end

game = Game.new
puts game.play