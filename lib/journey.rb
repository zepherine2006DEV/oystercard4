require_relative './station'

class Journey

  attr_reader :entry_station, :exit_station

  def initialize(station)
    @entry_station = station
    @exit_station = nil
  end

  def in_journey?
    !entry_station.nil? && exit_station.nil?
  end

  def set_exit_station(station)
    @exit_station = station
  end

end
