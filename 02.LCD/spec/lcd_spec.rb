require File.join(File.expand_path(File.dirname(__FILE__)), "..", "src", "lcd")

describe LcdWriter do
  
  let( :lcd ) { LcdWriter.new } 

  it 'should output numbers at size 2 by default' do
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
    lcd.line_e( 679 ).should == ' --        -- '
  end

  it 'should be able to write upper vertical line which is not blank, respecting size' do
    LcdWriter.new( 1 ).line_b( 4 ).should == "| |"
    LcdWriter.new( 2 ).line_b( 4 ).should == "|  |"
  end

  it 'should be able to write lower vertical line which is not blank' do
    lcd.line_d( 25 ).should == "|       |"
  end
  
  it 'should output example 1 from the book' do
    puts
    puts lcd.out( "012345" )
    puts
  end
  
  it 'should output example 2 from the book' do
    puts
    puts LcdWriter.new( 1 ).out( 6789 )
    puts
  end
end
