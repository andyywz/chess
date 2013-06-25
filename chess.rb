require "chess"
class Chess
  attr_accessor :player1, :player2, :board

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @board = Board.new
    @board.create_new_board
    play
  end

  def play
    current_player = @player1
    until game_over?
      display_board
      @player1.turn
      current_player = current_player == @player1 ? @player2 : @player1
    end
  end
end

class Board
  attr_accessor :board

  def initialize
    @board = []
  end

  def create_new_board
    8.times do |row|
      @board << []
      8.times do |col|
        @board[row][col] = " "
      end
    end
    # @board.each { |line| p line }
  end

  def set_pawns

  end

  def set_royals
  end
end

c = Chess.new