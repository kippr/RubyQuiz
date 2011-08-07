class LcdWriter

  def initialize size
    @size = size || 2
  end

  def out numbers
    ""
  end
  
  # Gets the positions that are 'set' for each number, using 2**x where x corresponds to below
  #  -    0
  # | |  1 2
  #  -    3
  # | |  4 5
  #  -    6
  def as_matrix_code number
    nums = []
    nums[0] = code_for( 0, 1, 2, 4, 5, 6 )
    nums[1] = code_for( 2, 5 )
    nums[number]
  end
  
  def code_for( *positions)
    positions.inject(0){ | a,b | a + 2**b }
  end

end
