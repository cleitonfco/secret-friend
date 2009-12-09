require 'lib/raffle'

describe Raffle do
  before(:each) do
    @participants = [
      ['ABC', 'abc@gmail.com'], 
      ['BCD', 'bcd@gmail.com'], 
      ['CDE', 'cde@gmail.com'], 
      ['DEF', 'def@gmail.com'], 
      ['EFG', 'efg@gmail.com'], 
      ['FGH', 'fgh@gmail.com'], 
      ['GHI', 'ghi@gmail.com'], 
      ['HIJ', 'hij@gmail.com'], 
      ['IJK', 'ijk@gmail.com']
    ]
  end

  it "should be Raffle" do
    r = Raffle.new
    r.should be_an_instance_of Raffle
  end

  it "must have a group of participants" do
    r = Raffle.new(@participants)
    r.participants = @participants
  end

  it "should associate the pairs" do
    r = Raffle.new(@participants)
    r.mix.size.should == @participants.size
  end

  it "should not associate yourself" do
    r = Raffle.new(@participants)
    r.shift('cde@gmail.com').should_not == 'CDE'
  end

end
