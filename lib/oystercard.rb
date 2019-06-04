class Oystercard

    attr_accessor :balance
    attr_accessor :state

    MAXIMUM_BALANCE = 90

    def initialize
    @balance = 0
    end

    def top_up(amount)
        fail 'maximum balance #{MAXIMUM_BALANCE} exceeded' if @balance + amount > MAXIMUM_BALANCE
        @balance += amount
    end 

    def deduct(amount)
        @balance -= amount
    end

    def touch_in
     @state = "in use"
    end

    def touch_out
        @state = "not in use"
       end

end