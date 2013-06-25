class Player
  def initialize
  end
end

class HumanPlayer < Player
  def turn
    puts "Choose a square to move from (e.g. 0,0):"
    start_pos = gets.chomp.split(',')
    puts "Choose a square to move to (e.g. 1,0):"
    end_pos = gets.chomp.split(',')
    valid_move?(start_pos,end_pos)
  end
end

class ComputerPlayer < Player
end