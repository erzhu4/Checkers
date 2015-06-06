class HumanPlayer

  attr_reader :color, :name

  def initialize(name, color)
    @name = name
    @color = color
  end

  def get_move # takes string from human and converts to commands array for the Board#move method
    puts "#{@name} please enter your move(s): "
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

class ComputerPlayer

  attr_reader :color, :name

  def initialize(board, color) #
    @board = board #Computer player must have access to the board because it doesn't have eyes to see the display.
    @color = color
    @name = "Computer Player"
  end

  def get_move #Computer player will first sample out of available jumping moves if any, otherwise sample out of normal moves.

    kill_move_pieces = []
    movable_pieces = []
    commands_arr = []
    pieces = @board.return_pieces(@color)
    pieces.each do |piece|
       if piece.valid_jumps.length >= 1
         kill_move_pieces << piece
       elsif piece.valid_slides.length >= 1
         movable_pieces << piece
       end
    end

    if kill_move_pieces.length > 0
      move_piece = kill_move_pieces.sample
      commands_arr << move_piece.pos << move_piece.valid_jumps.sample
    else
      move_piece = movable_pieces.sample
      commands_arr << move_piece.pos << move_piece.valid_slides.sample unless move_piece.pos.nil?
    end
    commands_arr

  end

end###################### end of ComputerPlayer class
