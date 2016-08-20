class Question < ActiveRecord::Base
  validates :title, :content, :answer, presence: true

end
