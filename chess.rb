# encoding: UTF-8

require "./pieces.rb"
require "./board.rb"
require "./player.rb"

class Chess
  attr_accessor :player1, :player2, :board

  def initialize
    @player1 = HumanPlayer.new("white")
    @player2 = HumanPlayer.new("black")
    @board = Board.new
    # @board.draw
    play
  end

  def play
    player = @player1

    loop do
    # until game_over?
      @board.draw
      begin
        start_pos, end_pos = player.turn
        player_color = player.player_color
        if @board.valid_move?(start_pos, end_pos, player_color)
          @board.move(start_pos,end_pos) unless @board.check?(player_color)
        else
          raise ArgumentError.new "Invalid move!"
        end
      rescue ArgumentError => e
        puts e
        retry
      end
      player = player == @player1 ? @player2 : @player1
    end
  end

  def game_over? # board only one king, checkmate,

  end
end

c = Chess.new