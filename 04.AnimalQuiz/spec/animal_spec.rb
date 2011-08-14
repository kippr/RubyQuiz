describe 'AnimalQuiz' do

  before :each do
    @questions = [] << "Think of an animal..." << "Is it an elephant? (y/n)"
  end

  it 'should start simple' do
    ask_is_it_an_elephant?
  end
  
  it 'should be happy if you get lucky' do
    ask_is_it_an_elephant?
    answer 'y'
    question.should == 'I win! Pretty smart! Play again? (y/n)'
  end

  it 'should ask for a clue if it didnt win' do
    ask_is_it_an_elephant?
    answer 'n'
    ask_what_animal_it_was
  end

  it 'should ask what animal you were thinking of and a question for it' do
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
    @questions << 'You win, well done! Before you go, help me learn...' << 'What animal were you thinking of?' if reply == 'n'
  end
  
  def ask_is_it_an_elephant?
    question.should == 'Think of an animal...'
    question.should == 'Is it an elephant? (y/n)'
  end
  
  def gloat_and_ask_to_play_again
    @questions << 'I win! Pretty smart! Play again? (y/n)'
  end
  
  def ask_what_animal_it_was
    question.should == 'You win, well done! Before you go, help me learn...'
    question.should == 'What animal were you thinking of?'
  end

  def ask_for_a_distinguishing_question_for the_animal
  end
  
end
