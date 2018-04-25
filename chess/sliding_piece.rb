module SlidingPiece
  def horizontal_dirs
    [
      [-1,0],
      [1,0],
      [0,-1],
      [0,1]
    ]
  end

  def diagonal_dirs
    [
      [-1,-1],
      [-1,1],
      [1,-1],
      [1,1]
    ]
  end

  def moves(current_pos)
    move = []
    move_dirs.each do |(dx,dy)|
      new_pos = [current_pos[0] + dx, current_pos[1] + dy]
      loop do
        if valid?(new_pos)
          move << new_pos
        else
          break
        end
        break if !@board[new_pos].empty?
        new_pos = [new_pos[0] + dx, new_pos[1] + dy]

      end
    end
    move
  end
end
