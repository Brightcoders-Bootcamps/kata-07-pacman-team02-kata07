require_relative 'map'

class Character
  attr_reader :pos_y, :pos_x

  def initialize(pos_x, pos_y)
    @pos_x = pos_x
    @pos_y = pos_y
  end

  def move_up(value)
    @pos_y -= 1
    @pos_y = Map.size_y if @pos_y.zero?
  end

  def move_down(value)
    @pos_y += 1
    @pos_y = 1 if @pos_y == (Map.size_y + 1)
  end

  def move_left(value)
    @pos_x -= 1
    @pos_x = Map.size_x if @pos_x.zero?
  end

  def move_right(value)
    @pos_x += 1
    @pos_x = 1 if @pos_x == (Map.size_y + 1)
  end
end