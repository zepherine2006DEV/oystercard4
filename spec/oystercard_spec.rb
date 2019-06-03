require 'oystercard'

describe Oystercard do
    it "card has a balance" do
        oystercard = Oystercard.new
        expect(subject.balance).to eq(0)
    end

    it "card can top up balance" do
        oystercard = Oystercard.new
        expect(subject.top_up).to eq(5)
    end

end