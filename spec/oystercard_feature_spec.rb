require 'oystercard'
require 'journey'
require 'station'

RSpec.describe 'Oystercard Challenge' do
  it 'can handle a normal journey' do
    card = Oystercard.new
    station1 = Station.new("Bank", 1)
    station2 = Station.new("Ealing Broadway", 3)

    card.top_up 10
    expect(card.journey_history).to be_empty

    card.touch_in(station1)
    expect(card.journey_history[-1].entry_station.name).to eq(station1.name)
    expect(card.journey_history[-1].in_journey?).to be true

    expect{card.touch_out(station2)}.to change {card.journey_history[-1].exit_station}.from(nil).to(station2)
    expect(card.journey_history[-1].in_journey?).to be false
  end
end
