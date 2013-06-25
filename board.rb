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
      @board[6][col] = Pawn.new([6, col], "white")
      @board[1][col] = Pawn.new([1, col], "black")
    end
  end

  def set_royals
    row = 0
    color = "black"
    while true
      @board.each_index do |col|
        if col == 0 || col == 7
          @board[row][col] = Rook.new([row,col],color)
        elsif col == 1 || col == 6
          @board[row][col] = Knight.new([row,col],color)
        elsif col == 2 || col == 5
          @board[row][col] = Bishop.new([row,col],color)
        elsif col == 3
          @board[row][col] = King.new([row,col],color)
        elsif col == 4
          @board[row][col] = Queen.new([row,col],color)
        end
      end
      if row == 0
        row = 7
        color = "white"
      else
        break
      end
    end
  end

  def draw
    black_rows = [0,2,4,6]
    8.times do |row|
      if black_rows.include?(row)
        square_color = "▢" #black square
      else
        square_color = "▢" #white square
      end
      8.times do |col|
        if @board[row][col].nil?
          @picture_board[row][col] = square_color
          square_color = square_color == "▢" ? "▢" : "▢"
          # square_color = square_color == "b" ? "w" : "b"
        else
          @picture_board[row][col] = @board[row][col].value
        end
      end
    end

    @picture_board.each do |row|
      row.each do |square|
        print "#{square} "
      end
      puts
    end
  end

  def move(start_pos,end_pos)
    x1, y1 = start_pos
    x2, y2 = end_pos
    @board[x2][y2] = @board[x1][y1]
    @board[x1][y1] = nil
  end

  def valid_move?(start_pos,end_pos)
    x1, y1 = start_pos
    x2, y2 = end_pos

    return false if @board[x1][y1].nil? # => object?
    piece_object = @board[x1][y1]

    return false unless piece_object.possible_moves.include?(end_pos)

    tempx, tempy = x1, y1
    dx, dy = {x2 <=> x1}, {y2 <=> y1}

    while tempx != x2 && tempy != y2
      tempx += dx
      tempy += dy
      if !@board[tempx][tempy].nil?
        if tempx == x2 && tempy == y2
          # check if friendly or enemy
        else
          return false
        end
      end

    end
  end
end


























=begin
valid_move?(start_pos, end_pos)

If it's not in possible move list, then don't even bother
Just return false

x1, y1 = start_pos
x2, y2 = end_pos
tempx = x1
tempy = y1

dx = {x2 <=> x1}
dy = {y2 <=> y1}

Bishop is at 7,7
Bishop will move to 0,0

dx = -1
dy = -1

while

tempx = tempx + dx
tempy = tempy + dy

unless board([tempx,tempy]).nil?
check first if its the final pos if so

return false
end

=end