class Oystercard

    attr_accessor :balance
    # attr_accessor :state
    attr_reader :entry_station

    MAXIMUM_BALANCE = 90
    MINIMUM_BALANCE = 1

    def initialize
      @balance = 0
      @entry_station = nil
    end

    def top_up(amount)
        fail 'maximum balance #{MAXIMUM_BALANCE} exceeded' if @balance + amount > MAXIMUM_BALANCE
        @balance += amount
    end

    def deduct(amount)
        @balance -= amount
    end

    def touch_in(station)
      @balance < 1 ? (raise Exception.new("minimum balance")): @entry_station = station
    end

    def touch_out
      deduct(MINIMUM_BALANCE)
      @entry_station = nil
    end

    def in_journey?
      entry_station.nil? ? false : true
    end

  private

    def deduct(amount)
      @balance -= amount
    end

end
