

module SteppingPiece
  def king_dirs
    [
      [-1,0],
      [1,0],
      [0,-1],
      [0,1],
      [-1,-1],
      [-1,1],
      [1,-1],
      [1,1]
    ]
  end

  def knight_dirs
    [
      [-2, -1],
      [-2,  1],
      [-1, -2],
      [-1,  2],
      [ 1, -2],
      [ 1,  2],
      [ 2, -1],
      [ 2,  1]
    ]
  end

  def moves(current_pos)
    move = []
    move_dirs.each do |(dx,dy)|
      new_pos = [current_pos[0] + dx, current_pos[1] + dy]
      move << new_pos if valid?(new_pos)
    end
    move
  end
end
