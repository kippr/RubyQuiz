class LcdWriter

  def initialize size = 2
    @size = size
  end

  def out numbers
    line_a numbers
  end
  
  def line_a numbers
    horizontal_for numbers, 0
  end
  
  def line_b numbers
    vertical_for numbers, 1, 2
  end

  def line_c numbers
    horizontal_for numbers, 3
  end
  
  def line_d numbers
    vertical_for numbers, 4, 5
  end
  
  def line_e numbers
    horizontal_for numbers, 6
  end
  
  def vertical_for numbers, pos_a, pos_b
    for_all( numbers ) { | n | n.pos( pos_a ) + ( ' ' * @size ) + n.pos( pos_b ) }
  end

  def horizontal_for numbers, pos_code
    for_all( numbers ) { | n | " " + ( n.pos( pos_code ) * @size ) + " " }
  end
  
  def for_all numbers, &block
    numbers.to_s.chars.collect do | num |
      yield code_for( num )
    end.join( " " )
  end

  def code_for number
    LcdCode.new( number.to_i )
  end
  
end

  # Defines positions that are 'set' for each number, using 2**x where x corresponds to below:
  #
  #      -        0                line a
  #     | |      1 2               line b
  #      -        3                line c
  #     | |      4 5               line d
  #      -        6                line e
  #
  # Also, can return appropriate char ('|', '_', or ' ') for each code.
class LcdCode

  def initialize number
    @number = number
  end
  
  def pos code
    set?( code ) ? filled_in( code ) : blank
  end
  
  def filled_in( code )
    [ 0, 3, 6 ].include?( code ) ? '-' : '|'
  end
  
  def blank
    ' '
  end
  
  def set? code
    #puts "num: #{@number} = #{as_bitset( @number )}"
    #puts "cod: #{code}    = #{2**code}"
    as_bitset( @number ) & 2**code != 0
  end

  def as_bitset number
    case number
    when 0 
      has_set 0, 1, 2, 4, 5, 6
    when 1
      has_set 2, 5
    when 2
      has_set 0, 2, 3, 4, 6
    when 3
      has_set 0, 2, 3, 5, 6
    when 4
      has_set 1, 2, 3, 5
    when 5
      has_set 0, 1, 3, 5, 6
    when 6
      has_set 0, 1, 3, 4, 5, 6
    when 7
      has_set 0, 2, 5
    when 8
      has_set 0, 1, 2, 3, 4, 5, 6
    when 9
      has_set 0, 1, 2, 3, 5
    else
      raise "Can only accept 0-9 but got #{number}"
    end
  end

  def has_set( *positions )
    positions.inject(0){ | a,b | a + 2**b }
  end
  
  def to_i
    as_bitset @number
  end

end
