class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :find_blog
  before_action :authenticate_user!
  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = @blog.comments.new(comment_params.merge(user_id: current_user.id))
    @comment.save
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = current_user.comments.find_by(id: params[:id])
      unless @comment
        redirect_back(fallback_location: root_path)
      end
    end

  def find_blog
    @blog = Blog.find_by(id: params[:blog_id])
    unless @blog
      redirect_back(fallback_location: root_path)
    end
  end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit( :content)
    end
end
