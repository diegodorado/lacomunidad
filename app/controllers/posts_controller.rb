class PostsController < ApplicationController
  #before_filter :authenticate_user!
  respond_to :json

  def index
    @posts = Post.includes([:attachement, :comments, :votes]).order('created_at desc').limit(10)
    return render :json => @posts.to_json(
                        :except => [ :updated_at ], 
                        :include=> {
                          :attachement =>{
                          }, 
                          :comments =>{
                            :except => [ :updated_at,:commentable_id,:commentable_type, :title ],
                          }, 
                          :votes=>{
                            :except => [ :updated_at,:created_at,:voteable_id,:voteable_type, :voter_type ],
                          }
                        })
                          
  end

  def vote
    @post = Post.find(params['id'])
    current_user.vote(@post, { :direction => params['direction'], :exclusive => current_user.voted_on?(@post) })
    return render :json => @post.to_json(
                        :except => [ :body, :created_at, :user_id, :updated_at ], 
                        :include=> {
                          :votes=>{
                            :except => [ :updated_at,:created_at,:voteable_id,:voteable_type, :voter_type ],
                          }
                        })
  end


  def opengraph
    @og = OpenGraph.fetch(params['url'])
    #return render :json => @og.valid?
    return render :json => @og.to_json
  end
  
end  
