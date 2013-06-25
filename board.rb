class Board
  attr_accessor :board

  def initialize
    @picture_board = []
    @board = []
  end

  def create_new_board
    8.times do |row|
      @board << []
      @picture_board << []
      8.times do |col|
        @board[row][col] = nil
        @picture_board[row][col] = nil
      end
    end
    set_pawns
    set_royals
  end

  def set_pawns
    @board.each_index do |col|
      @board[1][col] = Pawn.new([1, col], "white")
      @board[6][col] = Pawn.new([6, col], "black")
    end
  end

  def set_royals
    row = 0
    while true
      @board.each_index do |col|
        if col == 0 || col == 7
          @board[row][col] = Rook.new([row,col])
        elsif col == 1 || col == 6
          @board[row][col] = Knight.new([row,col])
        elsif col == 2 || col == 5
          @board[row][col] = Bishop.new([row,col])
        elsif col == 3
          @board[row][col] = King.new([row,col])
        elsif col == 4
          @board[row][col] = Queen.new([row,col])
        end
      end
      break if row == 7
      row = 7 if row == 0
    end
  end

  def draw
    8.times do |row|
      8.times do |col|
        if @board[row][col].nil?
          @picture_board[row][col] = " "
        else
          @picture_board[row][col] = @board[row][col].value
        end
      end
    end
    @picture_board.each { |line| p line }
  end
end
