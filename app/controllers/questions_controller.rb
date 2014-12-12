class QuestionsController < ApplicationController
  def index
    @questions = Question.all
    @question = Question.new

  end

  def show
    @question = Question.find(params[:id])
    @answer = Answer.create(title: "new answer", content: "place content here")
    @answers = @question.answers
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    respond_to do |format|
      if @question.save
        format.html {redirect_to questions_path}
        format.js {render :json, @question}
      else
        format.html {redirect_to new_question_path}
        format.js {render :json, @question}
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

    # if request.xhr?
    #   content_type :json
    #   return @question.id.to_json
    # end

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
