class Oystercard

    attr_accessor :balance
    # attr_accessor :state

    MAXIMUM_BALANCE = 90
    MINIMUM_BALANCE = 1

    def initialize
    @state = false 
    @balance = 0
    end

    def top_up(amount)
        fail 'maximum balance #{MAXIMUM_BALANCE} exceeded' if @balance + amount > MAXIMUM_BALANCE
        @balance += amount
    end 

    def deduct(amount)
        @balance -= amount
    end

    def touch_in(station)
      @balance < 1 ? (raise Exception.new("minimum balance")):@state = true
      return station
    end

    def touch_out
      deduct(MINIMUM_BALANCE)
      @state = false
    end

    def in_journey?
      @state
    end

  private

    def deduct(amount)
      @balance -= amount
    end

end