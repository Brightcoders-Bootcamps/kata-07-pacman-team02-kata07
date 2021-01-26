require_relative 'pacman'
require_relative 'ghost'

$map = Array.new
$row_count = 0
$column_count = 0
$id = 0

if File.file?("random.txt")
  text = File.open("random.txt").read
  text.each_line.with_index do |line, pos_y|
    str_line = line.strip
    $row_count += 1
    $column_count = 0
    str_line.each_char.with_index do |character, pos_x|
      $column_count += 1
      $id += 1
      if(character == '<')
        $map.push(Position.new([$id, Pacman.new(pos_x, pos_y), pos_x, pos_y]))
      elsif(character == 'M')
        $map.push(Position.new([$id, Ghost.new(pos_x, pos_y), pos_x, pos_y]))
      else
        $map.push(Position.new([$id, character, pos_x, pos_y]))
      end
    end
  end
else
  puts "No existe el archivo random.txt"
end

def print_game
  $map.each do |position|
    print "#{position.status.avatar} " if [Pacman, Ghost].include? position.status.class
    print "#{position.status} " if position.status.class == String
    puts "" if position.pos_x == ($column_count - 1)
  end
end

def update_map(move, map)
  cont = 0
  map.each do |position|
    if(position.status.class == Pacman && cont.zero?)
      cont += 1
      position.status.change_direction(move, map)
    end
  end
end

def right_option?(move)
  if ['8', '2', '4', '6'].include? move
    update_map(move, $map)
  else
    puts "OPCIÓN INCORRECTA"
  end
end

loop do
  system "clear"
  puts "\t\t\t\tPacman Score: #{Pacman.score}"
  print_game
  puts "Enter 8 (up), Enter 2 (down), Enter 4 (left), Enter 6 (right) --- quit or exit"
  move = STDIN.gets.chomp
  break if ['quit', 'exit'].include?(move)
  right_option?(move)
end