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
    lcd.code_for( 1 ).to_i.should == 2**2 + 2**5
  end
  
  it 'should be able to write top line out respecting size' do
    LcdWriter.new( 1 ).line_a( 1 ).should == "   "
    LcdWriter.new( 2 ).line_a( 1 ).should == "    "
    LcdWriter.new( 3 ).line_a( 1 ).should == "     "
  end

  it 'should be able to write top line which is not all blank respecting size' do
    LcdWriter.new( 1 ).line_a( 8 ).should == " - "
    LcdWriter.new( 2 ).line_a( 8 ).should == " -- "
  end
  
end
