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
    # @board.draw
    play
  end

  def play
    player = @player1

    2.times do
      p player
    # until game_over?
      @board.draw
      begin
        start_pos, end_pos = player.turn

        p @board.valid_move?(start_pos,end_pos)
        if @board.valid_move?(start_pos,end_pos)
          puts "Im going into move!"
          @board.move(start_pos,end_pos)
          @board.draw
        else
          raise ArgumentError.new "Invalid move!"
        end
      rescue
        puts "Im going to retry"
        retry
      end
      player = player == @player1 ? @player2 : @player1
    end

  end
end

player1 = HumanPlayer.new
player2 = HumanPlayer.new
c = Chess.new(player1,player2)