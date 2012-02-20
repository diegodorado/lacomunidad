class PostsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  def index
    @posts = Post.includes([:comments, :votes]).order('created_at desc').limit(10)
    return render :json => @posts.to_json(
                        :except => [ :updated_at ], 
                        :include=> {
                          :comments =>{
                            :except => [ :updated_at,:commentable_id,:commentable_type, :title ],
                          }, 
                          :votes=>{
                            :except => [ :updated_at,:created_at,:voteable_id,:voteable_type, :voter_type ],
                          }
                        })
                          
  end
  
  def create
    post = Post.create(params['post'])
    return render :json => post.to_json(:except => [ :updated_at ])

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


  def opengraph

    uri = params['url']
    page = {}

    #if Rails.cache.exist? "og_url:#{uri}"
    #  page = Rails.cache.read "og_url:#{uri}"
    #  return render :json => page.to_json
    #end
        
    html = RestClient.get(uri).body
    doc = Nokogiri::HTML.parse(html)

    doc.css('meta[property^="og:"][content]').each do |n|
      k = n.attribute('property').to_s.downcase.gsub(/^og:/,'').gsub('-','_')
      v = n.attribute('content').to_s.strip.chomp
      page[k] = v
    end

    #init node
    n = nil
    page['title'] ||= n.attribute('content').to_s.strip.chomp if (n = doc.css('meta[name="title"][content]').first)
    page['title'] ||= n.content.to_s.strip.chomp if (n = doc.css('html>head>title').first)
    page['description'] ||= n.attribute('content').to_s.strip.chomp if (n = doc.css('meta[name="description"][content]').first)
    page['image'] ||= n.attribute('href').to_s.strip.chomp if (n= doc.css("link[rel='image_src']").first)
    #shorlink/shorturl takes priority
    page['url'] = n.attribute('href').to_s.strip.chomp if (n = doc.css("link[rel='shortlink']").first)
    page['url'] = n.attribute('href').to_s.strip.chomp if (n = doc.css("link[rel='shorturl']").first)
    page['url'] = n.attribute('href').to_s.strip.chomp if (n = doc.css("link[id='shorturl']").first)    
    page['url'] ||= uri
    page['url'].insert(0, '//')  unless page['url'].starts_with?('http') or page['url'].starts_with?('//')
    
    page['title'] ||= page['url']
    page['description'] ||= page['url']
    page['type'] ||= n.attribute('content').to_s.strip.chomp if (n = doc.css('meta[name="medium"][content]').first)
    page['type'] ||= 'webpage' 

    if page['site_name']
      page['site_name'].downcase!
    else
      myUri = URI.parse uri
      page['site_name'] = myUri.host
    end

    case page['site_name']
      when 'youtube'
        video = page['video']
        video.match(/\/v\/(.*)\?/) do |m|
          page['embed'] = '<iframe width="100%" height="315" src="http://www.youtube.com/embed/'+m[1]+'" frameborder="0" allowfullscreen></iframe>'
        end
      when 'vimeo'
        url = page['url']
        url.match(/vimeo.com\/(\d.*)/) do |m|
          page['embed'] = '<iframe width="100%" height="315" src="http://player.vimeo.com/video/'+m[1]+'?title=0&amp;byline=0&amp;portrait=0&amp;autoplay=1" frameborder="0" allowfullscreen></iframe>'
        end
      when 'soundcloud'
        video = page['video']
        video.match(/tracks%2F(\d*)&/) do |m|
          page['embed'] = '<iframe width="100%" height="166" scrolling="no" frameborder="no" src="http://w.soundcloud.com/player/?url=http%3A%2F%2Fapi.soundcloud.com%2Ftracks%2F'+m[1]+'&show_artwork=true"></iframe>'
        end
    end


    images = []
    #only first 3 jpg
    jpgs = doc.css('img[src$=".jpg"][width]')
    if jpgs
      jpgs[0..3].each do |n|
        image = n.attribute('src').to_s.strip #.sub(/^\//, '')
        image.insert(0, uri.sub(/\/$/, '') + '/')  unless image.starts_with?('http') or  image.starts_with?('//')
        images << image
      end
    end

    page['images'] = images
    page['image'] ||= images[0] unless images.empty?
    page['image'] ||= 'http://placehold.it/120x80'

    page.keep_if do |k,v|
      ['title','url','description','image','embed'].include? k
    end

    #Rails.cache.write "og_url:#{uri}", page
    
    return render :json => page.to_json
  
  
  rescue StandardError => err
    return render :json => {:error=>err}.to_json
    
  end
  
end  
