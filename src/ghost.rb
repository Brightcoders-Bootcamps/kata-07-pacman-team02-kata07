require_relative 'character'

class Ghost < Character

  def initialize(pos_x, pos_y)
    @pos_x = pos_x
    @pos_y = pos_y
  end
end