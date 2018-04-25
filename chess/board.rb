require_relative "piece"
require_relative 'display'
class Board
  attr_accessor :grid, :colors

  def initialize
    @grid = Array.new(8) { Array.new(8, nil) }
    populate
    @display = Display.new(self)
    @colors = [:light_green,:light_magenta]
  end


  def move_piece(start_pos, end_pos)
    piece = self[start_pos]
    raise NullPieceError.new("No piece at #{start_pos}") if piece.is_a? NullPiece
    if piece.moves(start_pos).include?(end_pos)
      self[end_pos] = piece
      self[start_pos] = @null
      piece.pos = end_pos
     else
       raise InvalidMoveError.new("That's not a valid move!")
     end
  end

  def populate
    @null = NullPiece.instance
    @grid.each_with_index do |row,row_idx|
      case row_idx
      when 0, 7
        row.each_with_index do |cell, col_idx|
          pos = [row_idx,col_idx]
          color = row_idx == 0 ? :light_green : :light_magenta
          case col_idx
          when 0,7 then self[pos] = Rook.new(color,self,pos)
          when 1,6 then self[pos] = Knight.new(color,self,pos)
          when 2,5 then self[pos] = Bishop.new(color,self,pos)
          when 4 then self[pos] = King.new(color,self,pos)
          when 3 then self[pos] = Queen.new(color,self,pos)
          end
        end
      when 1, 6
        row.each_with_index do |cell, col_idx|
          pos = [row_idx,col_idx]
          color = row_idx == 1 ? :light_green : :light_magenta
          self[pos] = Pawn.new(color,self,pos)
        end
      else
        row.map! {|el| el = null}
      end
    end
  end

  def in_check?(color)
    king = (0..7).to_a.repeated_permutation(2).select { |x, y| self[[x,y]].is_a?(King) && self[[x,y]].color == color }.first

    opponent_pieces = []
    (0..7).to_a.repeated_permutation(2).each do |x,y|
      piece = self[[x,y]]
      opponent_pieces << piece if colors.reject {|c| c==color}.include?(piece.color)
    end

    opponent_pieces.each do |piece|
      piece.moves(piece.pos).each do |move|
        return true if move == king
      end
    end
    false
  end

  def deep_dup(arr)
    arr.map {|el| el.is_a?(Array) ? self.deep_dup(el) : el}
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos,value)
    row, col = pos
    @grid[row][col] = value
  end

  def display
    @display.render
  end

  def valid_pos?(pos)
    pos.all? { |coord| coord.between?(0, 7) }
  end
  private
  attr_reader :null

end

if __FILE__ == $0
  b= Board.new
  pawn = b[[6,7]]
  # b.display
  # b.move_piece([1,0],[3,0])
  bishop = Bishop.new(:light_magenta,b,[1,3])
  b[[1,3]] = bishop
  # b.display
  puts b.in_check?(:light_green)
  # puts pawn.moves(pawn.pos).map { |pos| b[pos] }
  # p bishop.moves(bishop.pos)
  c = Board.new
  c.grid = b.deep_dup(b.grid)
  # b[[1,3]]= pawn
  b.display
  c.display
end
