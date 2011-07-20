require 'src/madlib'

class MockSource

  def initialize( results )
    @results = results
  end

  def puts input
  end
  
  def gets
    @results.pop
  end
  
end

describe "MadLib" do

  def replacements
    [ "Ruby", "K" ].reverse
  end

  it "should find the madlib tokens" do
    "Our favourite language is ((a gemstone))".libs.should include("((a gemstone))")
  end
  
  it "should replace madlib tokens with provided values" do
    "Our favourite language is ((a gemstone))".lib_with( replacements ).should ==
      "Our favourite language is Ruby"
  end

  it "should replace multiple madlib tokens with provided values" do
    "Our favourite language is ((a gemstone)), much better than ((a letter))".lib_with( replacements ).should ==
      "Our favourite language is Ruby, much better than K"
  end
    
  it "should prompt for found tokens and return the results" do
    source = MockSource.new( replacements )
    "Our favourite language is ((a gemstone))".madlib_it( source, source ).should == 
      "Our favourite language is Ruby"
  end
  
  it "should handle multiple keys with same value" do
    source = MockSource.new( [ "sleepily", "mildly" ] )
    "I listened ((an adverb)), so ((an adverb))".madlib_it( source, source ).should == 
      "I listened sleepily, so mildly"
  end


end
