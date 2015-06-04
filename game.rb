class Game

  def initialize
    @board = Board.new
    @board.set_up
  end

  def set_players ## Sets human player vs another human or computer player
    print "Please enter player1's name: "
    name = gets.chomp
    @player1 = HumanPlayer.new(name, :red)
    print "Will you be playing a computer player? y/n: "

    begin #Loop do determine if player1 is playing another human or a computer
      playerSel = gets.chomp
      raise PlayerSelectError unless ['y', 'n'].include?(playerSel)
    rescue PlayerSelectError => e
      puts e.message
      retry
    end

    if playerSel == 'y'
      @player2 = ComputerPlayer.new(@board, :black)
    else
       print "Please enter player2's name: "
       name = gets.chomp
      @player2 = HumanPlayer.new(name, :black)
    end
    @current_player = @player1
    puts "#{@player1.name} will be the white smilies. "
    @board.display
    puts "Please enter all moves in the following format: "
    puts "##,## <--- first number pair denote piece to move, next is move destination."
    puts "If doing a multi-jump, add more number pairs separated by ',' like so: ##,##,##,##...etc"
  end

  def set_computer_players## this sets two computer players against each other, replace "self.set_players" line with this to watch computers play.
    @player1 = ComputerPlayer.new(@board, :red)
    @player2 = ComputerPlayer.new(@board, :black)
    @current_player = @player1
  end

  def play
    #self.set_players          # Only uncomment one of these two lines.
    self.set_computer_players  # Uncomment this line to have two computer players
    until @board.winner?
      self.turn
      self.change_current_player
    end
    winner = (@current_player == @player1) ? @player2 : @player1
    puts " #{winner.name} is the winner!!!!"
    puts "Thanks for playing."
  end

  def turn
    begin
      command = @current_player.get_move
      raise InvalidPieceError if @board[command[0]] && @board[command[0]].color != @current_player.color
      @board.move(command)
      @board.display
    rescue CheckersError => error #all game play errors are caught here
      puts error.message
      retry
    end

  end

  def change_current_player
    @current_player = (@current_player == @player1) ? @player2 : @player1
  end

end################ end of Game class
