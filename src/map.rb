class Map
  attr_reader :size_x, :size_y, :board
  def initialize(size_x, size_y)
    @size_x, @size_y, @wall_in, @wall_out, @board = size_x, size_y, "-", "|", []
  end

  def create_walls
    @size_y.times do |y|
      @board << Array.new(@size_x) do |x|
        if y.zero? || x.zero? || y == (@size_y - 1) || x == (@size_x - 1)
          @wall_in
        else
          ["|"].sample
        end
      end
    end
  end

  def refractor_map
    random_init_x, random_init_y = [rand(1..@board.first.size - 2), rand(1..@board.size - 2)]
    @board[random_init_y][random_init_x] = "."
    points_number = (@board.flatten.tally["|"] * 0.75).round
    fill_dots(points_number, random_init_x, random_init_y)
  end

  def print_map
    @board.each do |y|
      y.each do |x|
        print "#{x} "
      end
      puts ""
    end
  end

  def write_map
    out_file = File.new("random.txt", "w")
    @board.each_with_index do |y, y_index|
      y.each_with_index do |x, x_index|
        (x_index < y.length - 1) ? (out_file.print "#{x}") : (out_file.print "#{x}")
      end
      out_file.puts "\n" if y_index < @board.length - 1
    end
    out_file.close
  end

  def set_pacman
    @board.each_with_index do |y, y_index|
      if y.include? "."
        @board[y_index][y.find_index(".")] = "<"
        break
      end
    end
  end

  private

  def fill_dots(points_number, x, y)
    init_x, init_y, set_dot_arr = x, y, []
    (0..points_number).each { |point_number|
      direction = ["r", "l", "u", "d"].sample
      set_dot_arr = set_dot(direction, init_x, init_y)
      if !set_dot_arr.nil?
        init_x, init_y = set_dot_arr
      end
    }
  end

  def set_dot(direction, x, y)
    case direction
    when "r"
      if ["|"].include? @board[y][x + 1]
        @board[y][x + 1] = "."
        return [x + 1, y]
      end
    when "l"
      if ["|"].include? @board[y][x - 1]
        @board[y][x - 1] = "."
        return [x - 1, y]
      end
    when "u"
      if ["|"].include? @board[y - 1][x]
        @board[y - 1][x] = "."
        return [x, y - 1]
      end
    when "d"
      if ["|"].include? @board[y + 1][x]
        @board[y + 1][x] = "."
        return [x, y + 1]
      end
    else
      return nil
    end
    return nil
  end
end
map = Map.new(20, 15)
map.create_walls
pipes_count = (map.board.flatten.tally["|"].* 0.65).round
map.refractor_map
while (pipes_count > map.board.flatten.tally["."])
  map.refractor_map
end
map.set_pacman
map.write_map
