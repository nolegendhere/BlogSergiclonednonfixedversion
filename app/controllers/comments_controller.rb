class CommentsController < ApplicationController
  
  def create
    #@post = Post.find(params[:post_id])
    #@comment = @post.comments.create(comment_params)
    #@comment.user_id = current_user_id
    
    @comment= Comment.create(comment_params)
    @comment.user_id = current_user.id
    
    if @comment.save
      flash[:success] = "Comment created!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end
  
  def destroy
    
  end
  
  def index
    
  end
  
  def comment_params
      params.require(:comment).permit(:content,:post_id)
    end
end


