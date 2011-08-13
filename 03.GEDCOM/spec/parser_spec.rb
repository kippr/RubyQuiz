require 'nokogiri'

describe 'GEDCOM Parser' do

  INPUT = <<-eos
0 @I1@ INDI
1 NAME Jamis Gordon /Buck/
2 SURN Buck
2 GIVN Jamis Gordon
1 SEX M
eos


  it "should understand depth" do
    res = parse INPUT
    res.xpath( '/gedcom/indi' ).should_not be_empty
  end

  def parse input
    depth = -1
    @doc = Nokogiri::XML("")
    pos = @doc.add_child( node( "gedcom" ) )
    input.each_line do | line |
      line_depth = line[1].to_i
      if line_depth == 0
        pos.add_child( node( "indi" ) )
      end
    end
    @doc
  end
  
  def node element_name
    Nokogiri::XML::Node.new( element_name, @doc )
  end

end


