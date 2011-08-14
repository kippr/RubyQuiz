
describe 'AnimalQuiz' do

  before :each do
    @questions = [] << "Think of an animal..." << "Is it an elephant? (y/n)"
  end

  it 'should start simple' do
    ask_is_it_an_elephant
  end
  
  it 'should be happy if you get lucky' do
    ask_is_it_an_elephant
    answer 'y'
    question.should == 'I win! Pretty smart! Play again? (y/n)'
  end

  it 'should ask for a clue if it didnt win' do
    ask_is_it_an_elephant
    answer 'n'
    question.should == 'You win, well done! Before you go, help me learn...'
    question.should == 'What animal were you thinking of?'
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
    @questions << 'I win! Pretty smart! Play again? (y/n)' if reply == 'y'
    @questions << 'You win, well done! Before you go, help me learn...' << 'What animal were you thinking of?' if reply == 'n'
  end
  
  def ask_is_it_an_elephant
    question.should == 'Think of an animal...'
    question.should == 'Is it an elephant? (y/n)'
  end


end
