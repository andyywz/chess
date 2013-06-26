# encoding: UTF-8

module Moves
  def straight
    [[1,0],[-1,0],[0,1],[0,-1]]
  end

  def diagonal
    [[-1,-1],[-1,1],[1,-1],[1,1]]
  end
end

class Piece
  include Moves
  attr_accessor :possible_moves, :value, :color, :position, :moveset

  def initialize(position,color)
    @position = position
    @color = color
    @moveset = []
    @possible_moves = []
    @value = "_"
  end

  def scale(moveset)
    old_moveset = moveset
    new_moveset = []
    old_moveset.each do |move|
      (1..7).each do |mult|
        new_moveset << [move[0] * mult, move[1] * mult]
      end
    end
    new_moveset
  end

  def get_possible_moves
    @possible_moves = []
    @moveset.each do |move|
      x1, y1 = @position
      x, y = x1 + move[0], y1 + move[1]
      @possible_moves << [x,y] if x.between?(0,7) && y.between?(0,7)
    end
  end
end

class King < Piece
  def initialize(position,color)
    super
    @moveset += self.straight
    @moveset += self.diagonal
    get_possible_moves
    @value = case @color
    when "white"
      "♕"
    when "black"
      "♛"
    end
  end
end

class Queen < Piece
  def initialize(position,color)
    super
    @moveset += self.straight
    @moveset += self.diagonal
    @moveset = scale(@moveset)
    get_possible_moves
    @value = case @color
    when "white"
      "♔"
    when "black"
      "♚"
    end
  end
end

class Bishop < Piece
  def initialize(position,color)
    super
    @moveset += self.diagonal
    @moveset = scale(@moveset)
    get_possible_moves
    @value = case @color
    when "white"
      "♗"
    when "black"
      "♝"
    end
  end
end

class Knight < Piece
  def initialize(position,color)
    super
    @moveset += [[1,2],[1,-2],[-1,2],[-1,-2],[2,1],[2,-1],[-2,1],[-2,-1]]
    get_possible_moves
    @value = case @color
    when "white"
      "♘"
    when "black"
      "♞"
    end
  end
end

class Rook < Piece
  def initialize(position,color)
    super
    @moveset += self.straight
    @moveset = scale(@moveset)
    get_possible_moves
    @value = case @color
    when "white"
      "♖"
    when "black"
      "♜"
    end
  end
end

class Pawn < Piece
  def initialize(position,color)
    super(position,color)

    case @color
    when "white"
      @value = "♙"
    when "black"
      @value = "♟"
    end

    reset_moveset
    get_possible_moves
  end

  def reset_moveset
    @moveset = []
    case @color
    when "white"
      @moveset += [[-1,0]]
      @moveset += [[-2,0]] if position[0] == 6
    when "black"
      @moveset += [[1,0]]
      @moveset += [[2,0]] if position[0] == 1
    end
  end

  def set_pawn_moves(board)
    x,y = @position
    @moveset = []
    if @color == "white"
      if x - 1 >= 0
        @moveset << [-1,0] if board[x - 1][y].nil?
        @moveset << [-2,0] if board[x - 1][y].nil? && board[x - 2][y].nil? && x == 6
        @moveset << [-1,-1] if y - 1 >= 0 && !board[x - 1][y - 1].nil?
        @moveset << [-1,1] if y + 1 <= 7 && !board[x - 1][y + 1].nil?
      end
    else
      all_potential_moves = [[1,-1],[1,1],[2,0],[1,0]]
      if x + 1 <= 7
        @moveset << [1,0] if board[x + 1][y].nil?
        @moveset << [2,0] if board[x + 1][y].nil? && board[x + 2][y].nil? && x == 1
        @moveset << [1,-1] if y - 1 >= 0 && !board[x + 1][y - 1].nil?
        @moveset << [1,1] if y + 1 <= 7 && !board[x + 1][y + 1].nil?
      end
    end
    self.get_possible_moves
  end
end
