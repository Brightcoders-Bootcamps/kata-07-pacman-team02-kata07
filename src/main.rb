class Position
  attr_accessor :id, :status, :x_pos, :y_pos, :direction

  def initialize(init_array)
    @id, @status, @x_pos, @y_pos, @direction = init_array
  end

  #getters
  def id
    @id
  end

  def status
    @status
  end

  def x_pos
    @x_pos
  end

  def y_pos
    @y_pos
  end

  def direction
    @direction
  end

  # setters
  def id=(id)
    @id = id
  end

  def status=(status)
    @status = status
  end

  def x_pos=(x_pos)
    @x_pos = x_pos
  end

  def y_pos=(y_pos)
    @y_pos = y_pos
  end

  def direction=(direction)
    @direction
  end

  def print_game
    for row in 0..($line_count - 1)
      for column in 0..(($a / $line_count) - 1)
        print("     "+get_status_by_vectors(column, row))
      end
      print("     "+"\n")
    end
    puts("")
    return nil
  end

  def to_left
    #code
    status, x_position, y_position = get_pacman_pos_and_direction($pacman_id)
    if !get_status_by_vectors(x_position - 1, y_position).nil?
      if !["-", "|"].include? get_status_by_vectors(x_position - 1, y_position)
        # set empty current inst
        inst_pos = get_instance_by_vectors(x_position, y_position)
        inst_pos.status = " "
        #eat and up
        inst_pos = get_instance_by_vectors(x_position - 1, y_position)
        inst_pos.status = ">"
        $pacman_id = inst_pos.id
      end
    end
  end

  def to_right
    status, x_position, y_position = get_pacman_pos_and_direction($pacman_id)
    if !get_status_by_vectors(x_position + 1, y_position).nil?
      if !["-", "|"].include? get_status_by_vectors(x_position + 1, y_position)
        # set empty current inst
        inst_pos = get_instance_by_vectors(x_position, y_position)
        inst_pos.status = " "
        #eat and up
        inst_pos = get_instance_by_vectors(x_position + 1, y_position)
        inst_pos.status = "<"
        $pacman_id = inst_pos.id
      end
    end
  end

  def to_down
    status, x_position, y_position = get_pacman_pos_and_direction($pacman_id)
    if !get_status_by_vectors(x_position, y_position + 1).nil?
      if !["-", "|"].include? get_status_by_vectors(x_position, y_position + 1)
        # set empty current inst
        inst_pos = get_instance_by_vectors(x_position, y_position)
        inst_pos.status = " "
        #eat and up
        inst_pos = get_instance_by_vectors(x_position, y_position + 1)
        inst_pos.status = "^"
        $pacman_id = inst_pos.id
      end
    end
  end

  def to_up
    status, x_position, y_position = get_pacman_pos_and_direction($pacman_id)
    if !get_status_by_vectors(x_position, y_position - 1).nil?
      if !["-", "|"].include? get_status_by_vectors(x_position, y_position - 1)
        # set empty current inst
        inst_pos = get_instance_by_vectors(x_position, y_position)
        inst_pos.status = " "
        #eat and up
        inst_pos = get_instance_by_vectors(x_position, y_position - 1)
        inst_pos.status = "v"
        $pacman_id = inst_pos.id
      end
    end
  end

  private

  def get_status_by_vectors(x_position, y_position)
    $pos_instances.each { |inst|
      return inst.status.to_s if (inst.x_pos === x_position && inst.y_pos === y_position)
    }
    return nil
  end

  def get_instance_by_vectors(x_position, y_position)
    $pos_instances.each { |inst|  
      return inst if (inst.x_pos === x_position && inst.y_pos === y_position)
    }
    return nil
  end

  def get_pacman_pos_and_direction(_id)
    $pos_instances.each { |inst|
      return [inst.status.to_s, inst.x_pos, inst.y_pos] if (inst.id === _id)
    }
    return nil
  end
end

def get_direction(character)
  return "up" if character === "V"
  return "right" if character === "<"
  return "left" if character === ">"
  return "down" if character === "^"
  return nil
end

$pos_instances = Array.new
$a = 0
$line_count = 0
$pacman_id = 0
if File.file?("input.txt")
  text = File.open("input.txt").read
  text.each_line.with_index do |line, y_pos|
    str_line = line.strip
    $line_count += 1
    str_line.each_char.with_index { |character, x_pos|
      $a += 1
      $pacman_id = $a if (!get_direction(character).nil?)
      $pos_instances.push(Position.new([$a, character, x_pos, y_pos, get_direction(character)]))
    }
  end
end

print $pos_instances.first.print_game

def start_game
  while true
    print "Enter 8 (up), Enter 2 (down), Enter 4 (right), Enter 6 (left) \n"
    movement = STDIN.gets()
    if movement === "8\n"
      $pos_instances.first.to_up
    elsif movement === "2\n"
      $pos_instances.first.to_down
    elsif movement === "4\n"
      $pos_instances.first.to_left
    elsif movement === "6\n"
      $pos_instances.first.to_right
    else
      start_game
    end
    system "clear"
    $pos_instances.first.print_game
  end
end

start_game