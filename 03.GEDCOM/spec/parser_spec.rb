require 'nokogiri'

class GedComDoc
  def initialize
    @doc = Nokogiri::XML("")
    @root = @doc.add_child( node( "gedcom" ) )
    @curr = @root
  end

  def push_id tag, id
    push tag, { "id" => id }
  end
  
  def push_tag tag, data
    p data
    push tag, {}, data
  end
  
  def pop
    @curr = @curr.parent
  end
  
  def to_xml
    @doc
  end

  private
    def push tag, attributes = {}, data = nil
      node = node( tag.downcase )
      attributes.each_pair{ |k,v| node[k] = v }
      node.content = data unless data.nil?  
      @curr.add_child( node )
      @curr = node
    end
    
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
      (depth, tag_or_id, *values) = line.split
      adjust_to depth.to_i
      if tag_or_id[0] == '@'
        @doc.push_id values.first, tag_or_id[1..-2]
      else
        @doc.push_tag tag_or_id, values.join( " " )
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
  
  it "should add name under indi node" do
    name = @xml.xpath( '/gedcom/indi/name' ).first
    name.should_not be_nil
    name.inner_text.should include 'Jamis Gordon /Buck/'
  end

end


