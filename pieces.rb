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
  attr_accessor :possible_moves, :moveset, :value

  def initialize(position)
    @position = position
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
    @moveset.each do |move|
      x1, y1 = @position
      x, y = x1 + move[0], y1 + move[1]
      @possible_moves << [x,y] if x.between?(0,7) && y.between?(0,7)
    end
  end
end

class King < Piece
  def initialize(position)
    super
    @moveset += self.straight
    @moveset += self.diagonal
    get_possible_moves
    @value = "K"
  end
end

class Queen < Piece
  def initialize(position)
    super
    @moveset += self.straight
    @moveset += self.diagonal
    @moveset = scale(@moveset)
    get_possible_moves
    @value = "Q"
  end
end

class Bishop < Piece
  def initialize(position)
    super
    @moveset += self.diagonal
    @moveset = scale(@moveset)
    get_possible_moves
    @value = "B"
  end
end

class Knight < Piece
  def initialize(position)
    super
    @moveset += [[1,2],[1,-2],[-1,2],[-1,-2],[2,1],[2,-1],[-2,1],[-2,-1]]
    get_possible_moves
    @value = "N"
  end
end

class Rook < Piece
  def initialize(position)
    super
    @moveset += self.straight
    @moveset = scale(@moveset)
    get_possible_moves
    @value = "R"
  end
end

class Pawn < Piece
  def initialize(position,color)
    super(position)
    case color
    when "white"
      @moveset += [[1,0]]
    when "black"
      @moveset += [[-1,0]]
    end
    get_possible_moves
    @value = "P"
  end
end
