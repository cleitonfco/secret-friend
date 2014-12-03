require './lib/raffle'

describe Raffle do
  before(:each) do
    @participants = [
      Person.new('ABC', 'abc@gmail.com'), 
      Person.new('BCD', 'bcd@gmail.com'), 
      Person.new('CDE', 'cde@gmail.com'), 
      Person.new('DEF', 'def@gmail.com'), 
      Person.new('EFG', 'efg@gmail.com'), 
      Person.new('FGH', 'fgh@gmail.com'), 
      Person.new('GHI', 'ghi@gmail.com'), 
      Person.new('HIJ', 'hij@gmail.com'), 
      Person.new('IJK', 'ijk@gmail.com')
    ]
  end

  it "should be Raffle" do
    r = Raffle.new
    expect(r).to be_a Raffle
  end

  it "must have a group of participants" do
    r = Raffle.new(@participants)
    expect(r.participants).to eq(@participants)
  end

  it "should associate the pairs" do
    r = Raffle.new(@participants)
    expect(r.mix.size).to eq(@participants.size)
  end
end
