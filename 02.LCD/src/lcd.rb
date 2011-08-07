class LcdWriter

  def initialize size = 2
    @size = size
  end

  def out numbers
    line_1 numbers
  end
  
  def line_1 numbers
    c = LcdCode.new( numbers )
    " " + ( c.pos( 0 ) * @size ) + " "
  end
  
  def code_for number
    LcdCode.new( number )
  end
  
 
end

  # Defines positions that are 'set' for each number, using 2**x where x corresponds to below
  #  -    0
  # | |  1 2
  #  -    3
  # | |  4 5
  #  -    6
class LcdCode

  def initialize number
    @number = number
  end
  
  def pos code
    set? code ? '-' : ' '
  end
  
  def set? code
    as_bitset( @number ) && as_bitset( code ) != 0
  end

  def as_matrix_code number
    case number
    when 0 
      has_set 0, 1, 2, 4, 5, 6
    when 1
      has_set 2, 5
    else
      raise "Can only accept 0-9"
    end
  end

  def has_set( *positions )
    positions.inject(0){ | a,b | a + 2**b }
  end
  
  def to_i
    as_matrix_code @number
  end

end
