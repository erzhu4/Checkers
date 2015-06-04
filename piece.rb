require_relative 'board'

class Piece

  attr_reader :color, :pos, :dirs

  def initialize(board, color, pos)
    @board = board
    @color = color
    @pos = pos
    @dirs = ((@color == :red) ? [[-1, -1], [-1, 1]] : [[1, -1], [1, 1]] )
  end

  def valid_slides

    slides = []
    @dirs.each do |dir|
      move = [@pos[0] + dir[0], @pos[1] + dir[1]]
      slides << move if @board[move].nil?
    end

    slides
  end

  def valid_jumps
  end

end
