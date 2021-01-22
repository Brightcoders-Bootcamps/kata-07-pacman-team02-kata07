class Map
  attr_reader :size_x, :size_y, :board

  def initialize(size_x, size_y)
    @size_x = size_x
    @size_y = size_y
    @wall_in = '-'
    @wall_out = '|'
    @board = []
  end

  def create_board()
    
  end

  def create_walls
    @size_y.times do |y|
      @board << Array.new(@size_x) do |x|
        if y.zero? || x.zero? || y == (@size_y - 1) || x == (@size_x - 1)
          @wall_in
        else
          [@wall_out, "."].sample
        end
      end
    end
  end
end

map = Map.new(20, 15)
map.create_walls
map.board.each do |y|
  y.each do |x|
    print"#{x} "
  end
  puts ""
end