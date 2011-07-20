class String

  def libs
    ["a gemstone"]
  end
  
  def lib_with replacements
    "Our favourite language is Ruby"
  end
  
end

describe "MadLib" do

  it "should find the inputs" do
    "Our favourite language is ((a gemstone))".libs.should include("a gemstone")
  end
  
  it "should replace inputs with their values" do
    replacements = { "a gemstone" => "Ruby" }
    "Our favourite language is ((a gemstone))".lib_with( replacements ).should ==
      "Our favourite language is Ruby"
  end

end
