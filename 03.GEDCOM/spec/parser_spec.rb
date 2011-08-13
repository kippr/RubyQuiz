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
    @depth = -1
  end
  
  def parse input
    input.each_line{ |l| parse_line l }
    p @doc.to_xml.to_s
    @doc
  end
  
  def parse_line line
      line_bits = line.split
      p line_bits
      line_depth = line_bits[0].to_i
      case
        when line_depth > @depth
          puts "hello mum"
          @doc.push "indi"
      end
      @depth = line_depth
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


