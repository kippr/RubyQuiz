require 'src/lcd.rb'

describe LcdWriter do
  
  let( :lcd ) { LcdWriter.new } 

  it 'should output numbers at size 2 by default' do
    pending
    expected = <<-eos
          --   -- 
       |    |    |
       |    |    |
          --   -- 
       | |       |
       | |       |
          --   -- 
    eos
    lcd.out( "123" ).should == expected
  end
  
  it 'should know encodings for on values' do
    lcd.as_matrix_code( 1 ).should == 2**2 + 2**5
  end
  
  it 'should be able to translate on values into simple number' do
    LcdWriter.new( 1 ).line_1( 1 ).should == "    "
  end
  
end
