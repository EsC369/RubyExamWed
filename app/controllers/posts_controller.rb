class PostsController < ApplicationController
    def index
        redirect_to root_path if !logged_in?
        @posts = Post.all
  	    @post = Post.new
    end
  
    def new
    end
  
    def create
        @post = Post.new(post_params) #white listing
        @post.user = current_user
        if @post.save
            flash[:notice] = "Post was successfully created"
            redirect_to "/index"
        else
            render "new" 
        end
    end

    def destroy
        Post.find(params[:post_id]).destroy
        redirect_to  "/index"
    end
  
    def show
        redirect_to root_path if not_current_user
        @post = Post.find(params[:id])
        @likes = @post.likes
    end
  
    private
    def post_params
        params.require(:post).permit(:content, :user_id)
    end
    
end
