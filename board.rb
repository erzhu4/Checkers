require_relative 'piece'
require 'byebug'

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


  def move(commands) #### takes and array of array commands eg. [[0,0],[1,1]] and executes in order or until invalid command
    piece = self[commands[0]]
    command = commands[1]
    if piece == nil || commands.length <= 1 #handles imcomplete input by not doing anything.
      raise "Invalid piece selection"
    end
    if commands.length == 2 # handles basic cases where theres only one command to slide.
      raise "Invalid move selection" unless piece.valid_slides.include?(command) || piece.valid_jumps.include?(command)
      piece.perform_jump(command) # <--- Had to do it this way or else Error wouldn't raise for certain situations :(
      piece.perform_slide(command)
      return nil
    end

    if piece.valid_jumps.include?(command)  #tests if player tried to make a normal move after jump
      test_piece = piece.dup_piece(self, piece.color, command)
      raise "Can't make that move." if test_piece.valid_slides.include?(commands[2])
    end
    piece.perform_jump(command)
    self.move(commands[1..-1])

    nil
  end


  def return_pieces(color) # returns an array of all pieces of a certain color
    @grid.flatten.compact.select { |piece| piece.color == color }
  end



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
