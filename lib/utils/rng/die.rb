class Die
    def initialize sides
      @sides = sides
    end
  
    def roll
      rand(1..@sides)
    end
end
  