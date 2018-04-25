require 'singleton'
require_relative 'board'
require_relative 'sliding_piece'
require_relative 'stepping_piece'
require 'byebug'
class Piece
  attr_accessor :board, :pos, :color
  def initialize(color, board, pos)
    @color, @board, @pos = color, board, pos
  end


  def valid?(end_pos)
    return false unless @board.valid_pos?(end_pos)
    piece = @board[end_pos]
    return true if piece.empty? || piece.color != @color
    false
  end

  def check?(end_pos)
    board_dup = Board.new
    board_dup.grid = @board.deep_dup(@board.grid)
    board_dup[end_pos] = self
    board_dup[@pos] = NullPiece.instance

    return true if board_dup.in_check?(@color)
    false
  end

  def empty?
    self.class == NullPiece
  end

  def pos=(val)
    @pos = val
  end

  def symbol

  end

  def to_s
    piece = self.class.to_s[0]
    "#{piece.to_s}"
  end

  def inspect
    "#{self.class}"
  end
  private
  def move_into_check?(end_pos)
    @board.in_check?(@color)
  end

end

class NullPiece < Piece
  include Singleton
  def color
    ''
  end
  def initialize
  end

  def symbol
    " "
  end

end


class Rook < Piece
  include SlidingPiece
  def symbol
    "♜"
  end

  def move_dirs
    horizontal_dirs
  end
end

class Knight < Piece
  include SteppingPiece
  def symbol
    "♞"
  end

  def move_dirs
    knight_dirs
  end
end

class Bishop < Piece
  include SlidingPiece

  def move_dirs
    diagonal_dirs
  end

  def symbol
    "♝"
  end
end

class King < Piece
  include SteppingPiece
  def symbol
    "♚"
  end
  def move_dirs
    king_dirs
  end
end

class Queen < Piece
  include SlidingPiece

  def move_dirs
    horizontal_dirs + diagonal_dirs
  end

  def symbol
    "♛"
  end
end

class Pawn  < Piece
  def symbol
    "♟"
  end

  def valid_vertical?(pos)
    return false unless @board.valid_pos?(pos)
    piece = @board[pos]
    return true if piece.empty?
    false
  end

  def valid_diagonal?(pos)
    return false unless @board.valid_pos?(pos)
    piece = @board[pos]
    return true if piece.color != @color && piece.class != NullPiece
    false
  end

  def moves(pos)
    deltas = [
      [1,0],
      [2,0],
      [1, -1],
      [1, 1]
    ]

    color = self.color
    valid_moves = []
    if color == :light_magenta #we're on the bottom
      bottom_deltas = deltas.map { |(x,y)| [x*-1, y*-1] }
      bottom_deltas.each_with_index do |move, index|
        next unless valid_vertical?(move) && move[1] == 0
        next unless valid_diagonal?(move) && move[1] != 0
        next if index == 1 && pos[0] != 6
        valid_moves << move
      end
    else #color is light_green
      deltas.each_with_index do |move, index|
        next unless valid_vertical?(move) && move[1] == 0
        next unless valid_diagonal?(move) && move[1] != 0
        next if index == 1 && pos[0] != 6
        valid_moves << move
      end
    end
    valid_moves
  end




end

if __FILE__ == $PROGRAM_NAME
  b = Board.new
  ps = Pawn.new(:light_green,b,[1,0])
  k = Knight.new(:black,b,[0,2])
  b[[1,0]] = ps
  piece = b[[1,4]]
  p b.in_check?(:light_green)
  p piece.check?([2,4])
end









# def moves(pos)
#   color = self.color
#   move = []
#   if color == :blue #we're on the bottom
#     potential_move = [pos[0]-1,pos[1]]
#     move << potential_move if valid?(potential_move)
#     move << [pos[0]-2,pos[1]]if pos[0] == 6
#
#     new_pos = [pos[0]-1,pos[1]+1]
#     other_piece = @board[new_pos]
#     move << new_pos if other_piece.color != color && other_piece.class != NullPiece
#     new_pos = [pos[0]-1,pos[1]-1]
#     other_piece = @board[new_pos]
#     move << new_pos if @board[new_pos].color != color && other_piece.class != NullPiece
#   else #color is light_green
#     move << [pos[0]+1,pos[1]]
#     move << [pos[0]+2,pos[1]]if pos[0] == 1
#     new_pos = [pos[0]+1,pos[1]+1]
#     other_piece = @board[new_pos]
#     move << new_pos if @board[new_pos].color != color && other_piece.class != NullPiece
#     new_pos = [pos[0]+1,pos[1]-1]
#     other_piece = @board[new_pos]
#     move << new_pos if @board[new_pos].color != color && other_piece.class != NullPiece
#   end
#   move.select {|m| valid?(m)}
# end
