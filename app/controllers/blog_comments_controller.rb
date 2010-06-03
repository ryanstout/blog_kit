class BlogCommentsController < ApplicationController
	unloadable
	
	helper :blog
	
	layout(BlogKit.instance.settings['layout'] || 'application')
	
	before_filter :require_user, :only => [:destroy]
	before_filter :require_admin, :only => [:destroy]
	before_filter :require_blog_post

  def create
    @blog_comment = @blog_post.blog_comments.new(params[:blog_comment])
		@blog_comment.user_id = current_user.id if current_user
		@blog_comment.request = request

    respond_to do |format|
      if @blog_comment.save
        flash[:notice] = 'Your comments has been posted.'
        format.html { redirect_to(@blog_post) }
        format.xml  { render :xml => @blog_comment, :status => :created, :location => @blog_comment }
      else
        format.html do
					@blog_comments = @blog_post.blog_comments.paginate(:page => params[:page], :order => 'created_at DESC')
					render :template => '../views/blog_posts/show.html.erb'
				end
        format.xml  { render :xml => @blog_comment.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @blog_comment = BlogComment.find(params[:id])
    @blog_comment.destroy

		flash[:notice] = 'The comment has been deleted'

    respond_to do |format|
      format.html { redirect_to(blog_post_url(@blog_post)) }
      format.xml  { head :ok }
    end
  end

	private
		def require_blog_post
			@blog_post = BlogPost.find(params[:blog_post_id])
			
			unless @blog_post
				flash[:notice] = 'The post you were looking for could not be found'
				redirect_to :controller => 'blog_posts'
				return false
			end
			
			return true
		end
		
		def require_admin
			if !current_user || !current_user.admin?
				flash[:notice] = 'You must be an admin to view this page'
				redirect_to blog_posts_path
				return false
			end

			return true
		end
end