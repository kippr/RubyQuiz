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
    input.each_line{ |l| parse_line l.strip }
    @doc
  end
  
  def parse_line line
      return if line.empty?
      (depth, tag_or_id, *values) = line.split
      adjust_to depth.to_i
      if tag_or_id[0] == '@'
        @doc.push_id values.first, tag_or_id[1..-2]
      else
        @doc.push_tag tag_or_id, values.join( " " )
      end 
  end
  
  def adjust_to depth
      while @depth > depth
        @doc.pop
        @depth =- 1
      end
  end
  
end

