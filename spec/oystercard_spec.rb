require 'oystercard'

describe Oystercard do
  it "card has a balance" do
      oystercard = Oystercard.new
      expect(subject.balance).to eq(0)
  end

  describe '#top_up' do

    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'can top up the balance' do
        expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end

    it "to raise an error if the maximum balance is exceeded" do
        maximum_balance = Oystercard::MAXIMUM_BALANCE
        subject.top_up(maximum_balance)
        expect{ subject.top_up 1 }.to raise_error 'maximum balance #{MAXIMUM_BALANCE} exceeded'
    end
  end

  describe "#touch_out" do
    let(:station) { double "station" }

    it "card touches out and we are not in journey" do
        subject.touch_out
        expect(subject.in_journey?).to be false
    end

    it "charging the minimum fare on touch out" do
      expect {subject.touch_out}.to change{subject.balance}.by(-1)
    end

    it 'forgets entry station on touch out' do
      subject.top_up(10)
      subject.touch_in(station)
      subject.touch_out
      expect(subject.entry_station).to eq(nil)
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
