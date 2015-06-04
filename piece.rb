require_relative 'board'

class Piece

  attr_reader :color, :dirs
  attr_accessor :pos

  def initialize(board, color)
    @board = board
    @color = color
    @dirs = ((@color == :red) ? [[-1, -1], [-1, 1]] : [[1, -1], [1, 1]] )
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
      end###end of unless

    end##end of each loop

    jumps
  end

  def mark

    (@color == :red) ? "r" : "b" #test cases only

  end

end######################################end of class
