class Chess
  attr_accessor :player1, :player2, :board

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @board = []
    create_new_board
    play
  end

  def play
    until game_over?
      display_board
      @player1.turn
      @player2.turn
    end
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
end

c = Chess.new