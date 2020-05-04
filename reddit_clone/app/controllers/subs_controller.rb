class SubsController < ApplicationController
    before_action :ensure_logged_in, only: [:new, :create, :edit, :update]

    def new
        @sub = Sub.new 
        render :new  
    end

    def create
        @sub = Sub.new(sub_params)
        @sub.moderator_id = current_user.id  

        if @sub.save
            redirect_to subs_url 
        else
            flash.now[:errors] = @sub.errors.full_messages
            render :new
        end
    end

    def index 
        @subs = Sub.all 
        render :index 
    end

    def show 
        @sub = Sub.find_by(id: params[:id])
        render :show 
    end

    def edit
        @sub = current_user.subs.find_by(id: params[:id])  # do we need this
        if @sub
            render :edit 
        else
            flash[:errors] = ['You can not edit this sub']
            redirect_to subs_url
        end
    end

    def update
        @sub = current_user.subs.find_by(id: params[:id])
        if @subs.update(sub_params)
            redirect_to subs_url
        else
            flash.now[:errors] = @subs.errors.full_messages
            render :edit
        end
    end



    private 

    def sub_params
        params.require(:sub).permit(:title, :description)
    end
end
