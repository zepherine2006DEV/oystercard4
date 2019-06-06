require 'station'

describe Station do
  subject { Station.new("Bank", 1)}

  describe '#initialize' do
    it 'should get a name' do
      expect(subject.name).to eq("Bank")
    end

    it 'should get a zone' do
      expect(subject.zone).to eq(1)
    end
  end
end
