class PostsController < ApplicationController
    
    before_action :ensure_logged_in, only: [:create, :edit, :update]
    
    def new 
        @post = Post.new 
        render :new
    end

    def create
        @post = Post.new(post_params)
        @post.author_id = current_user.id
        if @post.save
            redirect_to sub_url(params[:sub_id])
        else
            flash[:errors] = ["Post must have a title"]
            render :new
        end
    end


    def edit
        @post = current_user.posts.find_by(id: params[:id])
        if @post 
            render :edit 
        else
            flash[:errors] = ['You cant edit that post']
            redirect_to post_url(params[:id])
        end 
    end

    def update
        @post = current_user.posts.find_by(id: params[:id])
        if @post.update(post_params)
            redirect_to post_url(@post)
        else
            flash[:errors] = @post.errors.full_messages
            render :edit
        end
    end

    def show 
        @post = Post.find_by(id: params[:id])
        render :show 
    end



    private

    def post_params
        params.require(:post).permit(:title, :url, :content, sub_ids:[])
    end
end
