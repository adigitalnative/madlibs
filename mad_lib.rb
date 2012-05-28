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
    @blanks = {}
    @split = text.split(/\((\([^)]*\))\)/)
    count = 0

    @split.each do |text|
      if text[0] == ?(
        text = text[1..-2]
        @blanks[count] = text
        count = count + 1
      end
    end
  end

  def get_answers
    @answers = {}
    puts "Here are the blanks:"
    @blanks.each do |key, blank|
      printf blank + " > "
      provided_answer = gets.strip
      @answers[key] = provided_answer
    end
    @answers
  end

  def print_story(text)
    mad_lib = ""
    count = 0
    @split.each do |text|
      if text[0] == ?(
        text = answers[count]
        mad_lib = mad_lib + text
        count = count + 1
      else
        mad_lib = mad_lib + text
      end
    end
    mad_lib
  end

end