require 'singleton'
class Piece
  attr_accessor :board, :pos
  def initialize(color, board, pos)
    @color, @board, @pos = color, board, pos
  end

  def valid_moves
    [[2,0]]
  end

  def inspect
    "#{self.class}"
  end

end

class NullPiece < Piece
  include Singleton

  def initialize
  end

end


class Rook < Piece

end
class Knight < Piece
end
class Bishop < Piece
end
class King < Piece
end
class Queen < Piece
end
class Pawn  < Piece
end
