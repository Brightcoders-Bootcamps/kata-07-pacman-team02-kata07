require_relative 'character'

class Ghost < Character
  attr_reader :avatar

  def initialize(pos_x, pos_y)
    super(pos_y, pos_x)
    @avatar = 'M'
  end


end