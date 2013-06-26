# encoding: UTF-8

class Board
  attr_accessor :virtual_board, :king

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
          @king = @virtual_board[row][col]
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
    piece1 = self.virtual_board[x1][y1]
    piece2 = self.virtual_board[x2][y2]

    if is_empty?(piece1)
      puts "No piece in the initial position."
      return false
    end

    # 1. If move possible, 2. If knight, 3. If pawn, 4. else
    unless piece1.possible_moves.include?(end_pos)
      puts "The initial piece was a #{piece1.class}"
      return false
    elsif !is_empty?(piece2)
      if !is_enemy?(piece1,piece2)
        puts "Can't kill your ally!!"
        return false
      end
    elsif piece1.is_a?(Knight)
      return true

    # elsif piece1.is_a?(Pawn)
#       if valid_pawn_move?(#some positional stuff)
#         return true if is_enemy?(piece2) || is_empty?(piece2)
#       end
#       return false
    else
      tempx, tempy = x1, y1
      dx, dy = (x2 <=> x1), (y2 <=> y1)

      until tempx == x2 && tempy == y2
        tempx += dx
        tempy += dy
        temp_spot = self.virtual_board[tempx][tempy]

        if !is_empty?(temp_spot) # checks for clear path
          # puts "Found blockage!"
          if tempx == x2 && tempy == y2
            return true
            # if is_enemy?(piece1,piece2)
            #   return true
            # else
            #   puts "Can't kill your ally!!"
            #   return false
            # end
          else
            puts "Your path is blocked."
            return false
          end
        end
      end
    end
  end

  def valid_pawn_move?

  end

  def is_enemy?(piece1, piece2)
    if piece1.color != piece2.color
      true
    else
      false
    end
  end

  def is_empty?(piece)
    return true if piece.nil?
    false
  end
end
