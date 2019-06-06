class Oystercard

    attr_accessor :balance
    attr_reader :entry_station, :journey_history

    MAXIMUM_BALANCE = 90
    MINIMUM_BALANCE = 1

    def initialize
      @balance = 0
      @entry_station = nil
      @journey_history = []
    end

    def top_up(amount)
        fail 'maximum balance #{MAXIMUM_BALANCE} exceeded' if @balance + amount > MAXIMUM_BALANCE
        @balance += amount
    end

    def touch_in(station)
      @balance < 1 ? (raise Exception.new("minimum balance")): @entry_station = station
    end

    def touch_out(station)
      deduct(MINIMUM_BALANCE)
      current_journey = {entry: entry_station, exit: station}
      @journey_history << current_journey
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
