require "./pieces.rb"
require "./board.rb"

class Chess
  attr_accessor :player1, :player2, :board

  def initialize
    # @player1 = player1
    # @player2 = player2
    @board = Board.new
    @board.create_new_board
    @board.draw
    # play
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

c = Chess.new