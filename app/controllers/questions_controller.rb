class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy, :try_to_answer, :get_answer]

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

  def show
  end

  def destroy
    if @question.destroy
      flash[:notice] = "Question deleted"
    else
      flash[:error] = @question.errors.full_messages.join(', ')
    end
    redirect_to questions_path
  end

  def try_to_answer
  end

  def get_answer
    # @result = @question.check_answer(params[:user_answer])
    @result = AnswerAlgorithm.new.run(@question.answer, params[:user_answer])

    respond_to do |format|
      format.js { render :get_answer}
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
