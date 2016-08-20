class AnswerAlgorithm

  def run(stored_answer, answer)
    correct = "<span class='label label-success'>CORRECT</span>"
    wrong = "<span class='label label-warning'>INCORRECT</span>"

    if answer == stored_answer
      return correct
    else
      origin = stored_answer.to_f

      if origin == 0
        origin = stored_answer
      else
        origin = stored_answer.to_f.to_words
      end

      user_answer = answer.to_f
      if user_answer == 0
        user_answer = answer.split(" ").join("-")
      else
        user_answer = answer.to_f.to_words
      end
      
      if origin == user_answer
        return correct
      else
        return wrong
      end
    end
  end
end