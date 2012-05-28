class MadLib
  attr_accessor :words
  attr_accessor :answers

  def initialize
    puts "Welcome to Madlibbr"
  end

  def new_story(text)
    process(text)
    get_answers
    print_story(text)
  end

  def process(text)
    @blanks = []
    @story = []
    @split = text.split(/\((\([^)]*\))\)/)

    @split.each do |text|
      if text[0] == ?(
        text = text[1..-2]
        @blanks << text
      else
        @story << text
      end
    end
  end

  def get_answers
    @answers = {}
    puts "Here are the blanks:"
    @blanks.each do |blank|
      key = ":" + blank
      printf blank + " > "
      provided_answer = gets.strip
      @answers[blank] = provided_answer
    end
    @answers
  end

  def print_story(text)
    mad_lib = ""
    count = 0
    @split.each do |text|
      if text[0] == ?(
        text = answers[text[1..-2]]
        mad_lib = mad_lib + text
      else
        mad_lib = mad_lib + text
      end
    end
    mad_lib
  end

end