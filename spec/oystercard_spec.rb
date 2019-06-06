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

    # it { is_expected.to respond_to(:deduct).with(1).argument }

    # it "can deduct from the card" do
    #     expect{ subject.deduct 1 }.to change{ subject.balance }.by -1
    # end

    # it { is_expected.to respond_to(:touch_in)}

    # it "card touch in, card staus changed to in use" do
    #     subject.top_up 1
    #     expect(subject.touch_in).to eq true
    # end

    it "store entry station when touch in" do
        entry_station = double "station"
        subject.touch_in(entry_station)
        expect(subject.stored_station).to eq(entry_station)
    end
    
    it "card touch out, card status not in use" do 
        subject.top_up 1     
        expect(subject.touch_out).to eq false
    end
 
    describe "#in_journey" do

    # it "card touches in and we are in journey" do
    #     subject.top_up 1
    #     subject.touch_in
    #     expect(subject.in_journey?).to be true
    # end

    it "card touches out and we are in journey" do
        subject.touch_out
        expect(subject.in_journey?).to be false
    end

    it "raises an exception when user tries to touch in with less than £1 balance" do
        expect {subject.touch_in}.to raise_error "minimum balance"
    end

    it "charging the minimum fare on touch out" do
      expect {subject.touch_out}.to change{subject.balance}.by(-1)
    end

end


    
end
end
