require 'oystercard'
require 'journey'
require 'station'

RSpec.describe 'Oystercard Challenge' do
  it 'can handle a normal journey' do
    card = Oystercard.new
    station1 = Station.new("Bank", 1)
    station2 = Station.new("Ealing Broadway", 3)
    current_journey {card.journey_history[-1]}
    card.top_up 10
    expect(card.journey_history).to be_empty
    expect{card.touch_in(station1)}.to change {current_journey.entry_station}.to(station1)
    expect(current_journey.in_journey?).to be_true
    expect{card.touch_out(station2)}.to change {current_journey.exit_station}.to(station2)
    expect(current_journey.in_journey?).to be_false
  end
end