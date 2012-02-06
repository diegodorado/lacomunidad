class CommentsController < ApplicationController
  #before_filter :authenticate_user!
  respond_to :json

  def create
    @post = Post.find(params['post_id'])
    @comment = @post.comments.build(params['comment'])
    @comment.user_id = current_user.id
    if @comment.save
      return render :json => @comment.to_json({
                          :except => [ :updated_at,:commentable_id,:commentable_type, :title ]
                          })
    else
      return render :json => {:error => 'no se pudo crear el comentario'}
    end
  end


  def destroy
    result = Comment.delete params['id']
    return render :json => {:result => result}
  end


end
