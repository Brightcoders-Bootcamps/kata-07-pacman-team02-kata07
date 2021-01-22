require_relative 'character'

class Pacman < Ghost
  attr_reader :avatar, :pos_x, :pos_y, :score

  def initialize
    default_position
    @avatar = 'V'
    @score = 0
  end

  def update_score
    @score += 1
  end

  def direction(value)
    if ['e', '!d'].include?(value)
      move_up(value)
      @avatar = 'v'
    elsif ['d', '!e'].include?(value)
      move_down(value)
      @avatar = '^'
    elsif ['s', '!f'].include?(value)
      move_left(value)
      @avatar = '>'
    elsif ['f', '!s'].include?(value)
      move_right(value)
      @avatar = '<'
    end
  end
end