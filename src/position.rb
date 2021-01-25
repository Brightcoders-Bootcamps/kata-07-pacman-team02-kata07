class Position
  attr_accessor :id, :status, :pos_x, :pos_y

  def initialize(init_array)
    @id, @status, @pos_x, @pos_y = init_array
  end
end