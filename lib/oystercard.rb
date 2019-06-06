class Oystercard

    attr_reader :entry_station, :journey_history, :balance

    MAXIMUM_BALANCE = 90
    MINIMUM_FARE = 1

    def initialize
      @balance = 0
      @entry_station = nil
      @journey_history = []
    end

    def top_up(amount)
      check_maximum_balance(amount)

      @balance += amount
    end

    def touch_in(station)
      check_minimum_balance

      @entry_station = station
    end

    def touch_out(exit_station)
      deduct(MINIMUM_FARE)
      store_journey(entry_station, exit_station)
      @entry_station = nil
    end

    def in_journey?
      entry_station.nil? ? false : true
    end

  private

    def store_journey(entry_station, exit_station)
      @journey_history << {entry: entry_station, exit: exit_station}
    end

    def deduct(amount)
      @balance -= amount
    end

    def check_maximum_balance(amount)
      fail "maximum balance £#{MAXIMUM_BALANCE} exceeded" if balance + amount > MAXIMUM_BALANCE
    end

    def check_minimum_balance
      raise "minimum balance required" if balance < MINIMUM_FARE
    end

end
