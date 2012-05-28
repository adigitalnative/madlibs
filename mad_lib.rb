class MadLib
  attr_accessor :story_sections
  attr_accessor :questions
  attr_accessor :repeated_questions
  attr_accessor :answers
  attr_accessor :mad_lib

  def create_lib(text)
    parse(text)
    get_answers
    build_mad_lib(text)
  end

  def parse(text)
    @story_sections = {}
    @count = 0
    @questions = {}
    @repeated_questions = {}

    split(text).each do |text|
      if is_question?(text)
        parse_question(text)
      else
        save_story_section(text)
      end
    end 
  end

  def split(text)
    @split = text.split(/\((\([^)]*\))\)/)
  end

  def parse_question(text)
    if text.include?(":")
      save_reusable(text)
    else
      check_repeated_questions(text)
    end
    @count = @count + 1
  end

  def check_repeated_questions(text)
    unless repeated_questions.keys.include?(trimmed_question(text))
      questions[@count] = trimmed_question(text)
    end
  end

  def trimmed_question(text)
    text[1..-2]
  end

  def save_story_section(text)
    story_sections[@count] = text
    @count = @count + 1
  end

  def save_reusable(text)
    text = trimmed_question(text).split(":")
    @repeated_questions[text[0]] = [text[1], @count]
    @questions[@count] = text[1]
  end

  def get_answers
    @answers = {}
    puts "First, give me some words"
    @questions.sort.each do |question|
      printf question[1]
      printf " > "
      provided_answer = gets.chomp
      @answers[question[0]] = provided_answer
    end
  end

  def build_mad_lib(text)
    @mad_lib = ""
    internal_count = 0
    split(text).each do |text|
      process_section(text, internal_count)
      internal_count = internal_count + 1
    end
    @mad_lib
  end

  def process_section(text, count)
    unless is_question?(text)
      @mad_lib = @mad_lib + text
    else
      text = trimmed_question(text)
      unless repeated_questions.keys.include?(text)
        @mad_lib = @mad_lib + answers[count]
      else
        text = repeated_questions[text]
        text_index = text[1]
        @mad_lib = @mad_lib + answers[text_index]
      end
    end
  end

  def is_question?(text)
    if text.include?("(")
      true
    else
      false
    end
  end

end