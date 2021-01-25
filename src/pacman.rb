require_relative 'character'

class Pacman < Character
  attr_accessor :avatar

  def initialize(pos_x, pos_y)
    super(pos_x, pos_y)
    @avatar = 'V'
    @@score = 0
  end

  def change_direction(move, map)
    case move
    when '8'
      move_up(move, map)
      @avatar = 'V'
    when '2'
      move_down(move, map)
      @avatar = '^'
    when '4'
      move_left(move, map)
      @avatar = '>'
    when '6'
      move_right(move, map)
      @avatar = '<'
    end
  end

  def self.score
    @@score
  end

  def self.score=(new_score)
    @@score = new_score
  end
end