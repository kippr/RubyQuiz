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
  
  it 'should be able to write top horizontal line out respecting size' do
    LcdWriter.new( 1 ).line_a( 1 ).should == "   "
    LcdWriter.new( 2 ).line_a( 1 ).should == "    "
    LcdWriter.new( 5 ).line_a( 1 ).should == "       "
  end

  it 'should be able to write top horizontal line which is not blank respecting size' do
    LcdWriter.new( 1 ).line_a( 8 ).should == " - "
    LcdWriter.new( 2 ).line_a( 8 ).should == " -- "
  end

  it 'should be able to write top horizontal line with multiple numbers' do
    lcd.line_a( "00" ).should == ' --   -- '
  end
  
  it 'should be able to write middle horizontal line with multiple numbers' do
    lcd.line_c( 235 ).should == ' --   --   -- '
  end
  
  it 'should be able to write bottom horizontal line with multiple numbers' do
    lcd.line_e( 679 ).should == ' --           '
  end

  it 'should be able to write top vertical line which is not blank, respecting size' do
    LcdWriter.new( 1 ).line_b( 4 ).should == "| |"
    LcdWriter.new( 2 ).line_b( 4 ).should == "|  |"
  end
  
end
