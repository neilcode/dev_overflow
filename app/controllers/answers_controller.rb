class AnswersController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    respond_to do |format|
      if @answer.save
        format.html {redirect_to question_path(@question)}
        format.js {@answer.to_json}
      else
        format.html {redirect_to question_path(@question)}
        format.js {@answer.to_json}
      end
    end
  end

  private
    def answer_params
      params.require(:answer).permit(:title, :content)
    end

end
