class String

  def libs
    self.scan(/(\(\([^)]+\)\))/).flatten
  end
  
  def lib_with replacements
    self.sub( /\(\(([^)]+)\)\)/ , replacements )
  end
  
end

describe "MadLib" do

  it "should find the madlib tokens" do
    "Our favourite language is ((a gemstone))".libs.should include("((a gemstone))")
  end
  
  it "should replace madlib tokens with provided values" do
    replacements = { "((a gemstone))" => "Ruby" }
    "Our favourite language is ((a gemstone))".lib_with( replacements ).should ==
      "Our favourite language is Ruby"
  end

end
