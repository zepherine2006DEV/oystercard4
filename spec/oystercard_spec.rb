require 'oystercard'

describe Oystercard do

  describe "#intialize" do
    it "has a balance" do
      oystercard = Oystercard.new
      expect(subject.balance).to eq(0)
    end

    it 'should have an empty list of journeys' do
      expect(subject.journey_history).to be_empty
    end
  end

  describe '#top_up' do

    it 'can top up the balance' do
      expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end

    it "raises an error if the balance exceeds £#{Oystercard::MAXIMUM_BALANCE}" do
      message = "maximum balance £#{Oystercard::MAXIMUM_BALANCE} exceeded"
      expect{ subject.top_up 91 }.to raise_error message
    end
  end

  describe "#touch_out" do
    let!(:station1) { double "bank" }
    let!(:station2) { double "angel" }
    before(:each) do
      subject.top_up(10)
      subject.touch_in(station1)
    end

    it "charges £#{Oystercard::MINIMUM_FARE}" do
      expect {subject.touch_out(station1)}.to change{subject.balance}.by(-Oystercard::MINIMUM_FARE)
    end

  end

  describe "#touch_in" do
    let(:station) { double "station" }

    it "raises an exception when balance is less than £#{Oystercard::MINIMUM_FARE}" do
      expect {subject.touch_in(station)}.to raise_error "minimum balance required"
    end
  end

end
