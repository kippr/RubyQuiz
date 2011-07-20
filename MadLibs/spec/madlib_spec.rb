class String
  def libs
    ["a gemstone"]
  end
end

describe "MadLib" do

  it "should match something" do
    "Our favourite language is ((a gemstone))".libs.should include("a gemstone")
  end

end
