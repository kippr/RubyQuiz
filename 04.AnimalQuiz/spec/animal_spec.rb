describe 'AnimalQuiz' do

  before :each do
    @questions = [] << "Think of an animal..." << "Is it an elephant? (y/n)"
  end

  it 'should start simple, with an animal question' do
    ask_is_it_an_elephant?
  end
  
  it 'should be happy if it got lucky' do
    ask_is_it_an_elephant?
    answer 'y'
    question.should == 'I win! Pretty smart! Play again? (y/n)'
  end

  it 'should ask for help if it lost' do
    ask_is_it_an_elephant?
    answer 'n'
    admit_defeat_and_ask_for_help
  end

  it 'should prompt for the animaL, distinguishing question and the answer' do
    pending
    ask_is_it_an_elephant?
    answer 'n'
    ask_what_animal_it_was
    answer 'a rabbit'
    question.should == 'Give me a question to distinguish an elephant from a rabbit.'
    answer 'Is it a small animal?'
    question.should 'For a rabbit, what is the answer to your question?'
    answer 'y'
    question.should == 'Thanks! Play again? (y/n)'
  end


  def question
    @questions.shift
  end
  
  def answer reply
    gloat_and_ask_to_play_again if reply == 'y'
    admit_defeat_and_ask_for_help if reply == 'n'
  end
  
  def ask_is_it_an_elephant?
    question.should == 'Think of an animal...'
    question.should == 'Is it an elephant? (y/n)'
  end
  
  def gloat_and_ask_to_play_again
    @questions << 'I win! Pretty smart! Play again? (y/n)'
  end
  
  def admit_defeat_and_ask_for_help
    @questions << 'You win, well done! Before you go, help me learn...' << 'What animal were you thinking of?'
  end
  
end
