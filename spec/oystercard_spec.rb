require 'oystercard'

describe Oystercard do
  it "card has a balance" do
      oystercard = Oystercard.new
      expect(subject.balance).to eq(0)
  end

  it 'should have an empty list of journeys by default' do
    expect(subject.journey_history).to eq([])
  end

  describe '#top_up' do

    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'can top up the balance' do
        expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end

    it "to raise an error if the maximum balance is exceeded" do
        subject.top_up(Oystercard::MAXIMUM_BALANCE)
        expect{ subject.top_up 1 }.to raise_error "maximum balance £#{Oystercard::MAXIMUM_BALANCE} exceeded"
    end
  end

  describe "#touch_out" do
    let!(:station1) { double "bank" }
    let!(:station2) { double "angel" }

    it "card touches out and we are not in journey" do
        subject.touch_out(station1)
        expect(subject.in_journey?).to be false
    end

    it "charging the minimum fare on touch out" do
      expect {subject.touch_out(station1)}.to change{subject.balance}.by(-1)
    end

    it 'forgets entry station on touch out' do
      subject.top_up(10)
      subject.touch_in(station1)
      subject.touch_out(station2)
      expect(subject.entry_station).to eq(nil)
    end

    it "stores journey on touch out" do
      subject.top_up 10
      subject.touch_in(station1)
      subject.touch_out(station2)
      expect(subject.journey_history).to include({entry: station1, exit: station2})
    end

  end

  describe "#touch_in" do
    let(:station) { double "station" }

    it "store entry station when touch in" do
      subject.top_up(10)
      subject.touch_in(station)
      expect(subject.entry_station).to eq(station)
    end

    it "raises an exception when user tries to touch in with less than £1 balance" do
      expect {subject.touch_in(station)}.to raise_error "minimum balance"
    end
  end

end
