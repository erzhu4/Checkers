class Board
  BOARD_DIMNSION = 8

  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
  end

  def [](pos)#################bracket definitions
    @grid[pos[0]][pos[1]]
  end

  def []=(location, content)
    @grid[location[0]][location[1]] = content
    content.pos = location unless content == nil
  end###################################end of bracket defs

  def display
     puts "  0 1 2 3 4 5 6 7"
    @grid.each_with_index do |row, idx|
      print idx
      row.each do |square|
        if square.nil?
          print " ☐"
          next
        end
        print " " + square.mark

      end
      puts
    end
    return nil
  end



end#############end of class
