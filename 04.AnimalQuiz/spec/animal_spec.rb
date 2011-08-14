

describe 'AnimalQuiz' do

  before :each do
    @questions = [] << "Think of an animal..." << "Is it an elephant? (y/n)"
    @state = :interrogate
  end

  it 'should start simple, with an animal question' do
    should_ask_is_it_an_elephant?
  end
  
  it 'should be happy if it got lucky' do
    should_ask_is_it_an_elephant?
    answer 'y'
    question.should == 'I win! Pretty smart! Play again? (y/n)'
  end

  it 'should ask for help if it lost' do
    should_ask_is_it_an_elephant?
    answer 'n'
    should_admit_defeat_and_ask_what_it_was
  end

  it 'should prompt for the animal, distinguishing question and the answer' do
    should_ask_is_it_an_elephant?
    answer 'n'
    should_admit_defeat_and_ask_what_it_was
    answer 'a rabbit'
    should_ask_for_distinguishing_question_between 'an elephant', 'a rabbit'
    answer 'Is it a small animal?'
    question.should == 'For a rabbit, what is the answer to your question?'
    answer 'y'
    question.should == 'Thanks! Play again? (y/n)'
  end

  it 'should try again after learning about rabbits' do
    should_ask_is_it_an_elephant?
    answer 'n'
    should_ask_is_it_small?
    answer 'n'
    should_ask_is_it_a_rabbit
    answer 'n'
    should_admit_defeat_and_ask_what_it_was
    answer 'a Shih Tzu'
    should_ask_for_distinguishing_question_between 'a rabbit', 'a Shih Tzu'
    answer 'Is it a dog?'
    question.should == 'For a Shih Tzu, what is the answer to your question?'
    answer 'y'
    question.should == 'Thanks! Play again? (y/n)'
  end

  def question
    @questions.shift
  end
  
  def answer reply
    ask_distinguishing_question if reply == 'a rabbit'
    ask_what_correct_answer_is_for_new_question if reply == 'Is it a small animal?'
    if @state == :interrogate
      gloat_and_ask_to_play_again if reply == 'y'
      admit_defeat_and_ask_for_help if reply == 'n'
    else
      remember_answer_and_ask_to_play_again if ['y', 'n'].include? reply
    end
  end
  
  def should_ask_is_it_an_elephant?
    question.should == 'Think of an animal...'
    question.should == 'Is it an elephant? (y/n)'
  end
  
  def should_admit_defeat_and_ask_what_it_was
    question.should == 'You win, well done! Before you go, help me learn...'
    question.should == 'What animal were you thinking of?'
  end

  def should_ask_for_distinguishing_question_between known_animal, new_animal
    question.should == 'Give me a question to distinguish an elephant from a rabbit.'
  end

  def should_ask_is_it_small?
    question.should == 'Is it a small animal?'
  end

  def gloat_and_ask_to_play_again
    @questions << 'I win! Pretty smart! Play again? (y/n)'
  end
  
  def admit_defeat_and_ask_for_help
    @questions << 'You win, well done! Before you go, help me learn...' << 'What animal were you thinking of?'
    @state = :learning
  end
  
  def ask_distinguishing_question
    @questions << 'Give me a question to distinguish an elephant from a rabbit.'
  end
  
  def ask_what_correct_answer_is_for_new_question
    @questions << 'For a rabbit, what is the answer to your question?'
  end
  
  def remember_answer_and_ask_to_play_again
    @questions << 'Thanks! Play again? (y/n)'
  end
  
end
