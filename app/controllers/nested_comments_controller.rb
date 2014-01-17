class NestedCommentsController < ApplicationController
  # GET /nested_comments
  # GET /nested_comments.json
  def index
    @nested_comments = NestedComment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @nested_comments }
    end
  end

  # GET /nested_comments/1
  # GET /nested_comments/1.json
  def show
    @nested_comment = NestedComment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @nested_comment }
    end
  end

  # GET /nested_comments/new
  # GET /nested_comments/new.json
  def new
    @nested_comment = NestedComment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @nested_comment }
    end
  end

  # GET /nested_comments/1/edit
  def edit
    @nested_comment = NestedComment.find(params[:id])
  end

  # POST /nested_comments
  # POST /nested_comments.json
  def create
    @nested_comment = NestedComment.new(params[:nested_comment])

    respond_to do |format|
      if @nested_comment.save
        format.html { redirect_to @nested_comment, notice: 'Nested comment was successfully created.' }
        format.json { render json: @nested_comment, status: :created, location: @nested_comment }
      else
        format.html { render action: "new" }
        format.json { render json: @nested_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /nested_comments/1
  # PUT /nested_comments/1.json
  def update
    @nested_comment = NestedComment.find(params[:id])

    respond_to do |format|
      if @nested_comment.update_attributes(params[:nested_comment])
        format.html { redirect_to @nested_comment, notice: 'Nested comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @nested_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nested_comments/1
  # DELETE /nested_comments/1.json
  def destroy
    @nested_comment = NestedComment.find(params[:id])
    @nested_comment.destroy

    respond_to do |format|
      format.html { redirect_to nested_comments_url }
      format.json { head :no_content }
    end
  end
end
