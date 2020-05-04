class UsersController < ApplicationController
    def new
        @user = User.new 
        render :new
    end

    # def index
    #     @users = User.all 
    #     render :index 
    # end

    def create
        @user = User.new(user_params) # would create work here too?
        
        if @user.save 
            log_in!(@user)
            redirect_to subs_url 
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end
    end

    # def show
    #     @user = User.find_by(id: params[:id])
    #     render :show
    # end

    private 

    def user_params 
        params.require(:user).permit(:username, :password)
    end
end
