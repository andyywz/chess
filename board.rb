# encoding: UTF-8

class Board
  attr_accessor :virtual_board

  def initialize
    @picture_board = []
    @virtual_board = []
  end

  def create_new_board
    8.times do |row|
      @virtual_board << []
      @picture_board << []
      8.times do |col|
        @virtual_board[row][col] = nil
        @picture_board[row][col] = nil
      end
    end
    set_pawns
    set_royals
  end

  def set_pawns
    @virtual_board.each_index do |col|
      @virtual_board[6][col] = Pawn.new([6, col], "white")
      @virtual_board[1][col] = Pawn.new([1, col], "black")
    end
  end

  def set_royals
    row = 0
    color = "black"
    while true
      @virtual_board.each_index do |col|
        if col == 0 || col == 7
          @virtual_board[row][col] = Rook.new([row,col],color)
        elsif col == 1 || col == 6
          @virtual_board[row][col] = Knight.new([row,col],color)
        elsif col == 2 || col == 5
          @virtual_board[row][col] = Bishop.new([row,col],color)
        elsif col == 3
          @virtual_board[row][col] = King.new([row,col],color)
        elsif col == 4
          @virtual_board[row][col] = Queen.new([row,col],color)
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
    puts "got in draw"
    black_rows = [0,2,4,6]
    8.times do |row|
      if black_rows.include?(row)
        square_color = "▢" #black square
      else
        square_color = "▢" #white square
      end
      8.times do |col|
        if self.virtual_board[row][col].nil?
          @picture_board[row][col] = square_color
          square_color = square_color == "▢" ? "▢" : "▢"
          # square_color = square_color == "b" ? "w" : "b"
        else
          @picture_board[row][col] = self.virtual_board[row][col].value
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

    # p self.virtual_board[x2][y2]
    # p self.virtual_board[x1][y1]
    self.virtual_board[x2][y2] = self.virtual_board[x1][y1]
    self.virtual_board[x1][y1] = nil

  end

  def valid_move?(start_pos,end_pos)
    x1, y1 = start_pos
    x2, y2 = end_pos

    return false if self.virtual_board[x1][y1].nil? # if the start pos doesn't have a piece
    return false unless self.virtual_board[x1][y1].possible_moves.include?(end_pos)

    tempx, tempy = x1, y1
    dx, dy = (x2 <=> x1), (y2 <=> y1)

    while tempx != x2 && tempy != y2
      tempx += dx
      tempy += dy

      unless self.virtual_board[tempx][tempy].nil? # checks for clear path
        if tempx == x2 && tempy == y2
          # check if friendly or enemy
          if is_enemy?(self.virtual_board[x2][y2]) # can replace with x2,y2
            return true
          else
            puts "Can't kill your ally!!"
            return false
          end
        else
          puts "Your path is blocked."
          return false
        end
      end
    end

    # if it is here means the path is full of nils
    puts "I passed"
    true
  end
end

=begin
valid_move?(start_pos, end_pos)

x1, y1 = start_pos
x2, y2 = end_pos
tempx = x1
tempy = y1

dx = {x2 <=> x1}
dy = {y2 <=> y1}

while

tempx = tempx + dx
tempy = tempy + dy

unless board([tempx,tempy]).nil?
check first if its the final pos if so

return false
end
end

=end