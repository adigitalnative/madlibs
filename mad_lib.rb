class MadLib
  attr_accessor :words
  attr_accessor :answers

  attr_accessor :blanks
  attr_accessor :repeated

  def initialize
    puts "Welcome to Madlibbr"
  end

  def new_story(text)
    process(text)
    get_answers
    print_story(text)
  end

  def split(text)
    text.split(/\((\([^)]*\))\)/)
  end

  def process(text)
    @blanks = {}
    @count = 0
    @repeated = {}

    split(text).each do |text|
      if text[0] == ?(
        text = text[1..-2]
        if text.include?(":")
          add_to_repeated(text)
        else
          unless @repeated.keys.include?(text)
            save_question(text)
          end
        end
      end
    end
  end

  def print_story(text)
    mad_lib = ""
    count = 0
    @split.each do |text|
      if text[0] == ?(
        mad_lib = mad_lib + answers[count]
        count = count + 1
      else
        mad_lib = mad_lib + text
      end
    end
    mad_lib
  end

  def add_to_repeated(text)
    text = text.split(":")
    @repeated[text[0]] = [text[1], @count]
    save_question(text[0])
  end

  def save_question(text)
    @blanks[@count] = text
    @count = @count + 1
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

end