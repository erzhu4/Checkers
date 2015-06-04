require_relative 'board'
require 'byebug'
class Piece

  attr_reader :color, :dirs
  attr_accessor :pos

  def initialize(board, color, pos)
    @board = board
    @color = color
    @pos = pos
    @dirs = ((@color == :red) ? [[-1, -1], [-1, 1]] : [[1, -1], [1, 1]] )
    nil
  end

  def valid_slides ######### returns array of valide slide positions

    slides = []
    @dirs.each do |dir|
      move = [@pos[0] + dir[0], @pos[1] + dir[1]]
      slides << move if move.all?{|x| x.between?(0, 7)} && @board[move].nil?
    end

    slides
  end

  def valid_jumps########## returns array of valid jump positions

    jumps = []
    @dirs.each do |dir|
      neighbor = @board[ [@pos[0] + dir[0], @pos[1] + dir[1]] ]
      jump = [@pos[0] + 2 * dir[0], @pos[1] + 2 * dir[1]]

      unless neighbor.nil?
        jumps << jump if jump.all?{|x| x.between?(0, 7)} && @board[jump].nil? && neighbor.color != @color
      end

    end

    jumps
  end

  def perform_slide(destination) ## Called by Board

    if self.valid_slides.include?(destination)
      current_pos = @pos
      @board[destination] = self
      @board[current_pos] = nil
    end

  end

  def perform_jump(destination) ## Called by Board

    if self.valid_jumps.include?(destination)
        current_pos = @pos
        @board[destination] = self
        @board[current_pos] = nil
        @board[get_between(current_pos, destination)] = nil
      end

    return nil
  end

  def mark
    (@color == :red) ? "☺" : "☻" #test cases only
  end

###############  Piece helper methods  #########

  def get_between(current_location, destination)

    x = ((destination[0] - current_location[0]) / 2) + current_location[0]
    y = ((destination[1] - current_location[1]) / 2) + current_location[1]

    [x, y]

  end

  def dup_piece(board, color, new_pos)
    Piece.new(board, color, new_pos)
  end


end######################################end of class


class InvalidMoveError
  def message
    "Not a valid command!!!!!"
  end
end

#####test area
