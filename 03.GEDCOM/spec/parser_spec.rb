require 'nokogiri'

class GedComDoc
  def initialize
    @doc = Nokogiri::XML("")
    @root = @doc.add_child( node( "gedcom" ) )
  end

  def push element_name, attributes = {}
    node = node( element_name )
    attributes.each_pair{ |k,v| node[k] = v }
    @root.add_child( node )
  end
  
  def pop
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
    puts @doc.to_xml.to_s
    @doc
  end
  
  def parse_line line
      (depth, tag_or_id, values) = line.split
      adjust_to depth.to_i
      if tag_or_id[0] == '@'
        parse_id_line tag_or_id[1..-2], values
      else
        parse_data_line tag_or_id, values
      end 
  end
  
  def adjust_to depth
      case
        when depth < @depth
          @doc.pop
          @doc.pop
        when depth == @depth
          @doc.pop
      end
      @depth = depth
  end
  
  def parse_id_line id, tag
    @doc.push tag.downcase, { "id" => id }
  end
  
  def parse_data_line tag, values
    @doc.push tag
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

end


