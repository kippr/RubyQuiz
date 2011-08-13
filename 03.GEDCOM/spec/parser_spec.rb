require 'nokogiri'

class GedComDoc
  def initialize
    @doc = Nokogiri::XML("")
    @root = @doc.add_child( node( "gedcom" ) )
  end

  def push element_name
    @root.add_child( node( element_name ) )
  end
  
  def to_xml
    @doc
  end

  private
    def node element_name
      Nokogiri::XML::Node.new( element_name, @doc )
    end

end

class GedComParser
  def initialize doc
    @doc = doc
  end
  
  def parse input
    depth = -1
    input.each_line do | line |
      line_depth = line[1].to_i
      if line_depth == 0
        @doc.push "indi"
      end
    end
    @doc
  end
  

end


describe GedComDoc, 'Parser' do

INPUT = <<-eos
0 @I1@ INDI
1 NAME Jamis Gordon /Buck/
2 SURN Buck
2 GIVN Jamis Gordon
1 SEX M
eos


  it "should understand depth" do
    doc = GedComDoc.new
    parser = GedComParser.new( doc )
    parser.parse INPUT
    
    doc.to_xml.xpath( '/gedcom/indi' ).should_not be_empty
  end

end


