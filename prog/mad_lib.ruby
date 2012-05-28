class MadLib
  attr_accessor :words

  def initialize(text)
    process_text(text)
  end

  def process_text(text)
    @blanks = []
    text.split(/\((\([^)]*\))\)/).each do |text|
      if text[0] == ?(
        @blanks << text
      end
    end
    puts @blanks.inspect
  end

end