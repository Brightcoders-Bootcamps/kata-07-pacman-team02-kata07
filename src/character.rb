require_relative 'map'
require_relative 'position'
require_relative 'pacman'

class Character
  attr_accessor :pos_y, :pos_x

  def initialize(pos_x, pos_y)
    @pos_y = pos_y
    @pos_x = pos_x
  end

  def move_up(move, map)
    update_pacman_position(move, map, 0, -1)
  end

  def move_down(move, map)
    update_pacman_position(move, map, 0, 1)
  end

  def move_left(move, map)
    update_pacman_position(move, map, -1, 0)
  end

  def move_right(move, map)
    update_pacman_position(move, map, 1, 0)
  end

  private
  def update_pacman_position(move, map, num_x, num_y)
    actual_status = actual_status(map)
    new_status = new_move_status(move, map)
    index_new_status = get_position_index(new_status, map)
    index_actual_status = get_position_index(actual_status, map)
    if(new_status.status == '.' || new_status.status == " ")
      Pacman.score += 1 if new_status.status == '.'
      map[index_new_status].status = map[index_actual_status].status
      map[index_actual_status].status = " "
      @pos_x += num_x
      @pos_y += num_y
    end
    puts "GAME OVER" if new_status.status.class == Ghost
  end

  def new_move_status(move, map)
    status = nil
    map.each do |position|
      case move
      when('8')
        status = position if position.pos_x == @pos_x && position.pos_y == (@pos_y - 1)
      when('2')
        status = position if position.pos_x == @pos_x && position.pos_y == (@pos_y + 1)
      when('4')
        status = position if position.pos_x == (@pos_x - 1) && position.pos_y == @pos_y
      when('6')
        status = position if position.pos_x == (@pos_x + 1) && position.pos_y == @pos_y
      end
    end
    status
  end

  def actual_status(map)
    actual_status = nil
    map.each do |position|
      actual_status = position if position.pos_x == @pos_x && position.pos_y == @pos_y
    end
    actual_status
  end

  def get_position_index(index_position, map)
    index = 0
    map.each do |position|
      break if position.id == index_position.id
      index += 1
    end
    index
  end
end