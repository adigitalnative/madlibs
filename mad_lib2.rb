class MadLib
  def initialize (txt)
    @questions = []
    @story_parts = []
    @answer_list = []
    @answers = []

    stored = {}

    txt.split(/\((\([^)]*\))\)/).each do |item|
      if item[0] == ?(
        item = item[1..-2].gsub("\n", ' ')
        if item.index(':')
          name, question = item.split(':')
          stored[name] = @questions.length
          @questions << question
        else
          name, question = item, item
        end
        @answer_list << (stored[name] || @questions.length)
        @questions << question unless stored[name]
      else
        @story_parts << item
      end
    end
  end

  def list_questions
    @questions.each_index do |i|
      yield(i, @questions[i])
    end
  end

  def show_results
    real_answers = @answers_list.collect {|i| @answers[i]}
    @story_parts.zip(real_answers).flatten.compact.join
  end
end

madlib = MadLib.new(IO.read(ARGV.shift))
answers = []
madlib.list_questions do |i, q|
  print "Give me " + q + ": "
  answers[i] = gets.strip
end
answers.each_index {|i| madlib.answer_question(i, answers[i]) }
puts madlib.show_result