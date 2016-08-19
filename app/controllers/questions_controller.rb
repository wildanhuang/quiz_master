class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  def index
    @questions = Question.all.order('id asc')
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)

    if @question.save
      flash[:notice] = 'Question created'
      redirect_to questions_path
    else
      flash[:error] = @question.errors.full_messages.join(', ')
      render :new
    end
  end

  def edit
  end

  def update
    if @question.update_attributes(question_params)
      flash[:notice] = 'Question updated'
      redirect_to questions_path
    else
      flash[:error] = @question.errors.full_messages.join(', ')
      render :edit
    end
  end

  private
    def question_params
      params.require(:question).permit(:title, :content, :answer)
    end

    def set_question
      @question = Question.find_by(id: params[:id])
    end
end
