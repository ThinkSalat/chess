require_relative "piece"
require_relative 'display'
class Board
  attr_accessor :grid, :null

  def initialize
    @grid = Array.new(8) { Array.new(8, nil) }
    populate
    @display = Display.new(board)
  end


  def move_piece(start_pos, end_pos)
    piece = self[start_pos]
    raise NullPieceError.new("No piece at #{start_pos}") if piece.is_a? NullPiece
    if piece.valid_moves.include?(end_pos)
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
          color = row == 0 ? :black : :white
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
          color = row == 1 ? :black : :white
          self[pos] = Pawn.new(color,self,pos)
        end
      else
        row.map! {|el| el = null}
      end
    end
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
    display.render
  end

  def valid_pos?(pos)
    pos.none { |coord| !coord.between?(0, 7) }
  end
end
