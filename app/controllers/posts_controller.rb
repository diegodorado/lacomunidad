class PostsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  def index
    ts = Time.parse params['ts']
    @posts = Post.includes([:comments, :votes]).order('created_at desc').where('created_at < ?',ts).limit(10)
    return render :json => @posts.to_json
  end
  
  def create
    post = Post.create(params['post'])
    return render :json => post.to_json
  end

  def destroy
    result = Post.delete params['id']
    return render :json => {:result => result}
  end
  
  def vote
    post = Post.find(params['id'])
    current_user.vote(post, { :direction => params['direction'], :exclusive => current_user.voted_on?(post) })
    return render :json => post.to_json(
                        :except => [ :body, :created_at, :user_id, :updated_at ], 
                        :include=> {
                          :votes=>{
                            :except => [ :updated_at,:created_at,:voteable_id,:voteable_type, :voter_type ],
                          }
                        })
  end
  
end  
