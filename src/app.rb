require_relative 'world'

game = World.new

loop do
  move = STDIN.gets()
  break if ['quit', 'exit'].include?(move)
  world.update_world(move)
end