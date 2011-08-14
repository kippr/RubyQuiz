
describe 'AnimalQuiz' do

  before :each do
    @questions = [] << "Think of an animal..." << "Is it an elephant? (y/n)"
    @questions << 'I win! Pretty smart! Play again? (y/n)'
  end

  it 'should start simple' do
    assert_first_question
  end
  
  it 'should be happy if you get lucky' do
    assert_first_question
    answer 'y'
    question.should == 'I win! Pretty smart! Play again? (y/n)'
  end

  it "should" do
    pending
    question.should == 'You win. Help me learn before you go...'
    question.should == 'What animal were you thinking of?'
    answer 'a rabbit'
  end
  
  def question
    @questions.shift
  end
  
  def answer reply
  end
  
  def assert_first_question
    question.should == 'Think of an animal...'
    question.should == 'Is it an elephant? (y/n)'
  end


end
