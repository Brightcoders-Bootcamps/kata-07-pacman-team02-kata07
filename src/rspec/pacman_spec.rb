#require_relative '../character'
require_relative '../pacman'
require_relative '../position'

RSpec.describe Pacman do
  pacman_test = Pacman.new(0,0)
  $map = Array.new
  $row_count = 0
  $column_count = 0
  $id = 0
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
      else
        $map.push(Position.new([$id, character, pos_x, pos_y]))
      end
    end
  end
  describe "#change_direction" do
    it "Devuelve la posicion del avatar V " do
      $map.each do |position|
        if(position.status.class == Pacman)
          position.status.change_direction('8', $map)
          pacman_test = position
        end
      end
  expect(pacman_test.status.avatar).to eq("V")
    end
    it "Devuelve la posicion del avatar ^ " do
      $map.each do |position|
        if(position.status.class == Pacman)
          position.status.change_direction('2', $map)
          pacman_test = position
        end
      end
      expect(pacman_test.status.avatar).to eq('^')
    end
    it "Devuelve la posicion del avatar >" do
      $map.each do |position|
        if(position.status.class == Pacman)
          position.status.change_direction('4', $map)
          pacman_test = position
        end
      end
      expect(pacman_test.status.avatar).to eq('>')
    end
      it "Devuelve la posicion del avatar < " do
      $map.each do |position|
        if(position.status.class==Pacman)
           position.status.change_direction('6', $map)
          pacman_test=position
        end
      end
      expect(pacman_test.status.avatar).to eq('<')
    end
  end
end
