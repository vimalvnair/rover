require_relative "../src/rover.rb"
require_relative "../src/custom_exceptions.rb"

describe Rover do
  describe "Creation" do
    it "should be at origin on when initialized" do
      rover = Rover.new
      rover.position_x.should eql(0)
      rover.position_y.should eql(0)
      rover.direction.should eql('N')
    end
    
    it "should have the position passed on creation" do
      rover = Rover.new(2, 3, 'S')
      rover.position_x.should eql(2)
      rover.position_y.should eql(3)
      rover.direction.should eql('S')
    end
  end

  describe "Move" do
    it "should update its postion to the given displacement" do
      rover = Rover.new(1, 5)
      rover.move(1, 2)
      rover.position_x.should eql(1)
      rover.position_y.should eql(7)      
      rover.move(8, -2)
      rover.position_x.should eql(1)
      rover.position_y.should eql(5)      
    end
  end

  describe "Rotate" do
    it "should turn to left" do
      rover = Rover.new(1, 5, 'S')
      rover.rotate('L')
      rover.direction.should eql('E')
      rover.rotate('L')
      rover.direction.should eql('N')
      rover.rotate('L')
      rover.direction.should eql('W')
      rover.rotate('L')
      rover.direction.should eql('S')
    end

    it "should turn to left" do
      rover = Rover.new(1, 5, 'N')
      rover.rotate('R')
      rover.direction.should eql('E')
      rover.rotate('R')
      rover.direction.should eql('S')
      rover.rotate('R')
      rover.direction.should eql('W')
      rover.rotate('R')
      rover.direction.should eql('N')
    end

    it "should turn left and right" do
      rover = Rover.new(1, 5, 'N')
      rover.rotate('R')
      rover.direction.should eql('E')
      rover.rotate('L')
      rover.direction.should eql('N')
    end
  end

  describe "Rotate and move" do
    it "should turn and move" do
      rover = Rover.new(3, 5, 'W')
      rover.rotate('L')
      rover.move(5, 4)
      rover.position_x.should eql(3)
      rover.position_y.should eql(1)      
    end
  end

  describe "Control signal" do
    it "should respond to control signal" do 
      rover = Rover.new(3, 5, 'N')
      rover.control_signal("L")
      rover.control_signal("M")
      rover.control_signal("L")
      rover.control_signal("M")
      rover.position_x.should eql(2)
      rover.position_y.should eql(4)
      rover.direction.should eql("S")
    end
  end

  describe "Validation" do
    it "should raise invalid position exception" do
      lambda do
        Rover.new("a", 3, "N")
      end.should raise_error InvalidPosition
    end 

    it "should raise invalid direction exception" do
      lambda do
        Rover.new(1, 3, "Z")
      end.should raise_error InvalidDirection
    end 

    it "should raise invalid control signal" do
      rover = Rover.new(1, 3, "N")
      lambda do
        rover.control_signal("k")
      end.should raise_error InvalidControlSignal
    end 
  end
end
