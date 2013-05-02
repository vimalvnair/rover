require_relative "./rover.rb"

curiosity = Rover.new(1, 2, 'N')
['L','M','L','M','L','M','L','M','M'].each do |command|
  curiosity.control_signal(command)
end
puts "Position = #{curiosity.position_x}, #{curiosity.position_y} #{curiosity.direction}"

opportunity = Rover.new(3, 3, 'E')
['M','M','R','M','M','R','M','R','R', 'M'].each do |command|
  opportunity.control_signal(command)
end
puts "Position = #{opportunity.position_x}, #{opportunity.position_y} #{opportunity.direction}"
