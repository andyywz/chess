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
    puts "  0 1 2 3 4 5 6 7"
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

    @picture_board.each_with_index do |row,index|
      print "#{index} "
      row.each do |square|
        print "#{square} "
      end
      puts
    end
  end

  def move(start_pos,end_pos)
    puts "got into move"
    x1, y1 = start_pos
    x2, y2 = end_pos

    self.virtual_board[x2][y2] = self.virtual_board[x1][y1] #copy object
    self.virtual_board[x2][y2].position = end_pos #tell object its new position
    self.virtual_board[x2][y2].get_possible_moves #find new possible moves
    self.virtual_board[x1][y1] = nil
  end

  def valid_move?(start_pos,end_pos)
    x1, y1 = start_pos
    x2, y2 = end_pos
    piece1 = self.virtual_board[x1][y1]
    piece2 = self.virtual_board[x2][y2]

    # 2. If pawn.
    if piece1.is_a?(Pawn)
      piece1.set_pawn_moves(self.virtual_board, end_pos)
    end

    # 1. If move possible
    # Is the start_pos empty? if not, is the end move possible?
    if is_empty?(piece1)
      puts "No piece in the initial position."
      return false
    elsif !piece1.possible_moves.include?(end_pos)
      puts "The initial piece was a #{piece1.class}"
      return false
    end

    # 3. If not knight or pawn.
    if !piece1.is_a?(Knight)
      tempx, tempy = x1, y1
      dx, dy = (x2 <=> x1), (y2 <=> y1)

      until tempx == x2 && tempy == y2
        tempx += dx
        tempy += dy
        temp_spot = self.virtual_board[tempx][tempy]

        if (tempx != x2 || tempy != y2)
          if piece1.is_a?(Pawn)
            return false if !is_empty?(temp_spot)

          elsif !is_empty?(temp_spot)
            # checks for clear path
            puts "Your path is blocked."
            return false
          end
        end
      end
    end

    if !is_empty?(piece2)
      if !is_enemy?(piece1, piece2)
        puts "Can't kill your ally!!"
        return false
      end
    end

    true
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









































