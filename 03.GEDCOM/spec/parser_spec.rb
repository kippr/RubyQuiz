require 'nokogiri'
require File.join(File.expand_path(File.dirname(__FILE__)), "..", "src", "ged")

describe GedComDoc, 'Parser' do

INPUT = <<-eos
0 @I1@ INDI
1 NAME Jamis Gordon /Buck/
2 SURN Buck
2 GIVN Jamis Gordon
1 SEX M
eos

  before :all do
    @doc = GedComDoc.new
    parser = GedComParser.new( @doc )
    parser.parse INPUT
    @xml = @doc.to_xml
  end


  it "should parse id nodes" do
    first = @xml.xpath( '/gedcom/indi' ).first
    first.should_not be_nil
    first[:id].should == 'I1'
  end
  
  it "should add name under indi node" do
    name = @xml.xpath( '/gedcom/indi/name' ).first
    name.should_not be_nil
    name.inner_text.should include 'Jamis Gordon /Buck/'
  end

end


