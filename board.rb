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
    set_pawns
    set_royals
  end

  def set_pawns
    @board.each do |col|
      @board[1][col] = Pawn.new([1, col], "white")
      @board[6][col] = Pawn.new([6, col], "black")
    end
  end

  def set_royals
    row = 0
    until row == 7
      @board.each do |col|
        case col
        when 0 || 7
          @board[row][col] = Rook.new([row,col])
        when 1 || 6
          @board[row][col] = Knight.new([row,col])
        when 2 || 5
          @board[row][col] = Bishop.new([row,col])
        when 3
          @board[row][col] = King.new([row,col])
        when 4
          @board[row][col] = Queen.new([row,col])
        end
      end
    end
  end

  def draw
    @board.each do |row|
      @board.each do |col|
        @board[row][col] = @board[row][col].value
      end
    end
    @board.each { |line| p line }
  end
end
