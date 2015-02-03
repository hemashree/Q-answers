class AnswersController < ApplicationController

  before_action :category_params

  def new
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    @answer.category = @category
    @answer.user_id = current_user.id
    if @answer.save
      redirect_to question_path(@question.id)
    else
      render 'new'
    end
  end

  def edit
    @question = Question.find(params[:question_id])
    @answer = @question.answers.find(params[:id])
  end

  def update
    @question = Question.find(params[:question_id])
    @answer = @question.answers.find(params[:id])
    if @answer.update(answer_params)
      redirect_to question_path(@question.id)
    else
      render 'edit'
    end
  end

  private

  def category_params
    @category = params[:category]
  end

  def answer_params
    params.require(:answer).permit(:my_answer, :question_id, :category)
  end
end
