class HumanPlayer

  attr_reader :color, :name

  def initialize(name, color)
    @name = name
    @color = color
  end

  def get_move # takes string from human and converts to commands array
    puts "Please enter your move in the following format: "
    puts "##,## separate by ',' for multi-jumps."
    input = gets.chomp
    arr = input.split(',')
    output = []
    arr.each do |coord_string|
      raise InputError if coord_string.length != 2
      coord = []
      coord_string.split('').each { |x| coord << x.to_i }
      output << coord
    end

    output
  end



end############################# end of HumanPlayer class

class InputError
  def message
    "Please enter input correctly."
  end
end
