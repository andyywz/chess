# encoding: UTF-8

require "./pieces.rb"
require "./board.rb"
require "./player.rb"

class Chess
  attr_accessor :player1, :player2, :board

  def initialize(player1,player2)
    @player1 = player1
    @player2 = player2
    @board = Board.new
    @board.create_new_board
    @board.draw
    # play
  end

  def play
    player = @player1
    until game_over?
      @board.draw
      player.turn
      player = player == @player1 ? @player2 : @player1
    end
  end
end

player1 = HumanPlayer.new
player2 = HumanPlayer.new
c = Chess.new(player1,player2)