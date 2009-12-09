require 'lib/raffle'

describe Raffle do

  it "should be Raffle" do
    r = Raffle.new
    r.should be_an_instance_of Raffle
  end

  it "must have a group of participants" do
    participants = %w(A B C D E F G H I)
    r = Raffle.new(participants)
    r.participants = participants
  end

  it "should associate the pairs" do
    participants = %w(A B C D E F G H I)
    r = Raffle.new(participants)
    rm = r.mix
    rm.size.should == participants.size
  end

  it "should not associate yourself" do
    participants = [['a', 'A'], ['b', 'B'], ['c', 'C'], ['d', 'D'], ['e', 'E'], ['f', 'F'], ['g', 'G'], ['h', 'H'], ['i', 'I']]
    r = Raffle.new(participants)
    rs = r.shift('c')
    rs.should_not == ['c', 'C']
  end

  it "should show pointers" do
    participants = %w(A B C D E F G H I)
    r = Raffle.new(participants)
    r.stub!(:mix).and_return({"A"=>"D", "B"=>"E", "C"=>"H", "D"=>"A", "E"=>"G", "F"=>"C", "G"=>"I", "H"=>"B", "I"=>"F"})
    r.pointer.should == "A > D > A | B > E > G > I > F > C > H > B"
  end

  it "should show pointers" do
    participants = %w(A B C D E F G H I)
    r = Raffle.new(participants)
    r.stub!(:mix).and_return({"A"=>"D", "B"=>"E", "C"=>"H", "D"=>"I", "E"=>"F", "F"=>"C", "G"=>"B", "H"=>"G", "I"=>"A"})
    r.pointer.should == "A > D > I > A | B > E > F > C > H > G > B"
  end

  it "should show pointers" do
    participants = %w(A B C D E F G H I)
    r = Raffle.new(participants)
    r.stub!(:mix).and_return({"A"=>"G", "B"=>"C", "C"=>"F", "D"=>"A", "E"=>"H", "F"=>"D", "G"=>"I", "H"=>"B", "I"=>"E"})
    r.pointer.should == "A > G > I > E > H > B > C > F > D > A"
  end

  it "should show pointers" do
    participants = %w(A B C D E F G H I)
    r = Raffle.new(participants)
    r.stub!(:mix).and_return({"A"=>"D", "B"=>"G", "C"=>"I", "D"=>"F", "E"=>"A", "F"=>"B", "G"=>"E", "H"=>"C", "I"=>"H"})
    r.pointer.should == "A > D > F > B > G > E > A | C > I > H > C"
  end

  it "should show pointers" do
    participants = %w(A B C D E F G H I)
    r = Raffle.new(participants)
    r.stub!(:mix).and_return({"A"=>"I", "B"=>"D", "C"=>"B", "D"=>"C", "E"=>"G", "F"=>"H", "G"=>"F", "H"=>"E", "I"=>"A"})
    r.pointer.should == "A > I > A | B > D > C > B | E > G > F > H > E"
  end

end
