class Oystercard

    attr_reader :balance

    MAXIMUM_BALANCE = 90

    def initialize
    @balance = 0
    end

    def top_up(amount)
        
        @balance += amount
    end 


end