class Question < ActiveRecord::Base
  validates :title, :content, :answer, presence: true

  def check_answer answer
    correct = "<span class='label label-success'>CORRECT</span>"
    wrong = "<span class='label label-warning'>INCORRECT</span>"

    if answer == self.answer
      return correct
    else
      origin = self.answer.to_f

      if origin == 0
        origin = self.answer
      else
        origin = self.answer.to_f.to_words
      end

      user_answer = answer.to_f
      if user_answer == 0
        user_answer = answer
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
