class Board
  BOARD_DIMNSION = 8

  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
  end

  def [](pos)#################bracket definitions
    @grid[pos[0]][pos[1]]
  end

  def []=(pos, content)
    @grid[pos[0]][pos[1]] = content
  end###################################end of bracket defs




end
