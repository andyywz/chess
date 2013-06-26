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

    loop do
    # until game_over?
      @board.draw
      begin
        start_pos, end_pos = player.turn

        # p @board.valid_move?(start_pos,end_pos)
        if @board.valid_move?(start_pos,end_pos)
          # puts "Im going into move!"
          @board.move(start_pos,end_pos)
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

player1 = HumanPlayer.new
player2 = HumanPlayer.new
c = Chess.new(player1,player2)