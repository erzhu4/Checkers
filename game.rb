class Game

  def initialize
    @board = Board.new
    @board.set_up
  end

  def set_players
    print "Please enter player1's name: "
    name = gets.chomp
    @player1 = HumanPlayer.new(name, :red)
    #Ask if there is another human player here
    print "Please enter player2's name: "
    name = gets.chomp
    @player2 = HumanPlayer.new(name, :black)
    @current_player = @player1
    @board.display
  end

  def play
    self.set_players
    until @board.winner?
      self.turn
      self.change_current_player
    end
    winner = (@current_player == @player1) ? @player2 : @player1
    puts " #{winner.name} is the winner!!!!"
    puts "Thanks for playing."
  end

  def turn
      puts "#{@current_player.name}'s turn"
    begin
      command = @current_player.get_move
      raise InvalidPieceError if @board[command[0]] && @board[command[0]].color != @current_player.color
      @board.move(command)
      @board.display
    rescue CheckersError => error #all errors are caught here
      puts error.message
      retry
    end

  end

  def change_current_player
    @current_player = (@current_player == @player1) ? @player2 : @player1
  end

end################ end of Game class
