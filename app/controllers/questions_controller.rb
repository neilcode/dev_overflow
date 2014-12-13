class QuestionsController < ApplicationController
  def index
    @questions = Question.all
    @question = Question.new

  end

  def show
    @question = Question.find(params[:id])
    @answers = @question.answers
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    respond_to do |format|
      if @question.save
        format.js {@question.to_json}
        format.html {redirect_to questions_path}
        #format.json {render :json, @question}
      else
        format.html {redirect_to new_question_path}
        format.js {@question.to_json}
      end
    end
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    redirect_to questions_path
  end

  def edit
    @question = Question.find(params[:id])

  end

  def update
    @question = Question.find(params[:id])

    if @question.update(question_params)
      redirect_to @question
    else
      render 'edit'
    end
  end

  def upvote
    @question = Question.find(params[:id])
    @question.upvote
    respond_to do |format|
      format.html
      format.json {render json: @question}
      format.js
    end

  end

  def downvote
    @question = Question.find(params[:id])
    @question.downvote

    respond_to do |format|
      format.html
      format.json {render json: @question}
      format.js
    end

  end




  private
    def question_params
      params.require(:question).permit(:title, :content)
    end

end
