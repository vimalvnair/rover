class Rover
  TURN = {"L" => -90, "R" => 90}
  DIRECTION = {"N" => 0, "E" => 90, "S" => 180, "W" => 270}
  DIRECTION_COORDINATES = {
    "N" => [0, 1], 
    "E" => [1, 0], 
    "S" => [0, -1], 
    "W" => [-1, 0]
  }

  attr_accessor :position_x, :position_y
  attr_accessor :direction
  
  def initialize(position_x = 0, position_y = 0, direction = 'N')
    @position_x, @position_y = position_x, position_y
    @direction = direction
    set_direction_cordinates
  end
  
  def move(displacement_x, displacement_y)
    set_direction_cordinates
    @position_x = @position_x + displacement_x * @direction_x
    @position_y = @position_y + displacement_y * @direction_y
  end
  
  def rotate(turn)
    current_direction_value = DIRECTION[@direction]
    turn_value = TURN[turn]
    @new_direction_value = current_direction_value + turn_value
    check_boundaries
    @direction = DIRECTION.key(@new_direction_value)
  end

  def control_signal(command)
    rotate(command) and return if TURN.keys.include?(command)
    move(1, 1) and return if command == "M"
  end

  def check_boundaries
    @new_direction_value = 270 if @new_direction_value < 0
    @new_direction_value = 0 if @new_direction_value > 270
  end

  def set_direction_cordinates
    @direction_x = DIRECTION_COORDINATES[@direction][0]
    @direction_y = DIRECTION_COORDINATES[@direction][1]
  end
end

## Run

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
