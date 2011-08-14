class QuizMaster

  def initialize
    prepare_game
    @animal_questions = [] << "Is it an elephant? (y/n)"
  end
  
  def next_question
      question = @questions.shift
      if @state == :welcome
        @state = @animal_questions.count > 1 ? :interrogating  : :making_a_guess
        @questions = Array.new( @animal_questions )
      end
      question
      
  end

  def answer reply
    case @state
      when :interrogating
        ask_clarifying_question
        raise "Umm, oops"
      when :making_a_guess
        gloat_and_ask_to_play_again if reply == 'y'
        admit_defeat_and_ask_what_animal_it_was if reply == 'n'
      when :lost
        ask_distinguishing_question
      when :learning_new_question
        ask_what_correct_answer_is_for_new_question
      when :learning_answer_to_new_question
        remember_answer_and_ask_to_play_again
      when :game_over
        prepare_game if reply == 'y'
    end
  end
  
  private

    def prepare_game
      @questions = [] << "Think of an animal..."
      @state = :welcome
    end

    def admit_defeat_and_ask_what_animal_it_was
      @state = :lost
      @questions << 'You win, well done! Before you go, help me learn...' << 'What animal were you thinking of?'
    end

    def ask_distinguishing_question
      @state = :learning_new_question
      @questions << 'Give me a question to distinguish an elephant from a rabbit.'
    end

    def ask_what_correct_answer_is_for_new_question
      @state = :learning_answer_to_new_question
      @animal_questions << 'Is it a small animal?'
      @questions << 'For a rabbit, what is the answer to your question?'
    end

    def gloat_and_ask_to_play_again
      @state = :game_over
      @questions << 'I win! Pretty smart! Play again? (y/n)'
    end

    def remember_answer_and_ask_to_play_again
      @state = :game_over
      @questions << 'Thanks! Play again? (y/n)'
    end

end

describe 'AnimalQuiz' do

  before :each do
    @master = QuizMaster.new
  end

  it 'should start simple, with an animal question' do
    should_ask_is_it_an_elephant?
  end
  
  it 'should be happy if it got lucky' do
    should_ask_is_it_an_elephant?
    answer 'y'
    question.should == 'I win! Pretty smart! Play again? (y/n)'
    answer 'y'
    should_ask_is_it_an_elephant?
  end

  it 'should ask for help if it lost' do
    should_ask_is_it_an_elephant?
    answer 'n'
    should_admit_defeat_and_ask_what_it_was
  end

  def run_to_getting_rabbit_definition
    should_ask_is_it_an_elephant?
    answer 'n'
    should_admit_defeat_and_ask_what_it_was
    answer 'a rabbit'
    should_ask_for_distinguishing_question_between 'an elephant', 'a rabbit'
    answer 'Is it a small animal?'
    question.should == 'For a rabbit, what is the answer to your question?'
    answer 'y'
  end

  it 'should prompt for the animal, distinguishing question and the answer' do
    run_to_getting_rabbit_definition
    question.should == 'Thanks! Play again? (y/n)'
    answer 'n'
  end

  it 'should try again after learning about rabbits' do
    run_to_getting_rabbit_definition
    question.should == 'Thanks! Play again? (y/n)'
    answer 'y'
    should_ask_is_it_an_elephant?
    answer 'n'
    should_ask_is_it_small?
    answer 'n'
    should_ask_is_it_a_rabbit?
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
    @master.next_question
  end
  
  def answer reply
    @master.answer reply
  end
  
  def should_ask_is_it_an_elephant?
    question.should == 'Think of an animal...'
    question.should == 'Is it an elephant? (y/n)'
  end

  def should_ask_is_it_a_rabbit?
    question.should == 'Is it a rabbit? (y/n)'
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
  
end
