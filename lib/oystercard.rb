class Oystercard

    attr_reader :journey_history, :balance

    MAXIMUM_BALANCE = 90
    MINIMUM_FARE = 1
    PENALTY_FARE = 6

    def initialize
      @balance = 0
      @journey_history = []
    end

    def top_up(amount)
      check_maximum_balance(amount)
      @balance += amount
    end

    def touch_in(station)
      check_minimum_balance
      store_journey(Journey.new(station))
    end

    def touch_out(exit_station)
      deduct(MINIMUM_FARE)
      journey_history[-1].set_exit_station(exit_station)
    end

  private

    def store_journey(journey)
      journey_history << journey
    end

    def deduct(amount)
      @balance -= amount
    end

    def check_maximum_balance(amount)
      raise "maximum balance £#{MAXIMUM_BALANCE} exceeded" if balance + amount > MAXIMUM_BALANCE
    end

    def check_minimum_balance
      raise "minimum balance required" if balance < MINIMUM_FARE
    end

end
