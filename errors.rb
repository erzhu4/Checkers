


class CheckersError < StandardError
end

class InputError < CheckersError
  def message
    "Please enter input correctly."
  end
end

class MoveError < CheckersError
  def message
    "Not a valid move!!!!!"
  end
end

class InvalidPieceError < CheckersError
  def message
    "Not a valid piece to move. "
  end
end
