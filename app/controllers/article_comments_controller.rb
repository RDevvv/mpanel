class ArticleCommentsController < ApplicationController
  # GET /comments/new
  # GET /comments/new.json
  def new
    @article_comment = ArticleComment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @article_comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @article_comment = ArticleComment.find(params[:id])
  end

  # POST /comments
  # POST /comments.json
  def create
    @commentable = find_commentable
    @article_comment = @commentable.article_comments.build(params[:article_comment])
    @article = @commentable
    respond_to do |format|
      if @article_comment.save
        format.json { render json: @article_comment}
      else
        format.json { render json: @article_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @article_comment = ArticleComment.find(params[:id])

    respond_to do |format|
      if @article_comment.update_attributes(params[:article_comment])
        format.html { redirect_to @article_comment, notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @article_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @article_comment = ArticleComment.find(params[:id])
    @article_comment.destroy

    respond_to do |format|
      format.html { redirect_to comments_url }
      format.json { head :no_content }
    end
  end

  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end

end
