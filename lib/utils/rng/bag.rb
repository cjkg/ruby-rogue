class Bag
    def initialize dice_array
      @dice_array = dice_array
    end
  
    def rollBag
      @dice_array.map { |die| 
        die.roll
      }
      puts 'blah'
    end
  
    def rollSum
      self.rollBag.sum
    end
  end
  