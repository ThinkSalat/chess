require 'colorize'
require_relative 'board'
require_relative 'cursor'
require 'byebug'

class Display
  attr_accessor :board, :cursor
  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], board)
  end

  def render
    @board.grid.each_with_index do |row,row_idx|
      row.each_with_index do |cell,col_idx|
        background_color = row_idx.even? ? :white : :black
        if col_idx.odd?
            background_color = background_color == :white ? :black : :white
        end
        pos = [row_idx,col_idx]


        player_color = cell.color
        background_color = :green if pos == @cursor.cursor_pos && @cursor.selected
        background_color = :red if pos == @cursor.cursor_pos && @cursor.selected == false
        print cell.symbol.colorize(:color => player_color, :background => background_color)
      end
      print "\n"
    end
  end

private




end

if __FILE__ == $PROGRAM_NAME
b = Board.new
d = Display.new(b)
d.render
end
