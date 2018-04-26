class UsersController < ApplicationController

    def index
        session[:user_id] = nil
    end

    def register
        user = User.new(user_params)
        if user.save
            session[:user_id] = user.id
            # redirect_to groups_path
            redirect_to "/index"
        else
            flash[:errors] = user.errors.full_messages
            redirect_to root_path
        end
    end

    def login 
        @usr = User.find_by_email(params[:user][:email]).try(:authenticate, params[:user][:password])
        if @usr
            session[:user_id] = @usr.id
            redirect_to "/index"
        else 
            flash[:errors] = ["Invalid combination"]
            redirect_to root_path
        end
    end

    def show
        @user2 = User.find(params[:user_id])
        @user2_posts = @user2.posts
        @user = User.find(params[:user_id])
        @likes = User.find(params[:user_id]).posts_liked
    end

    def result
        if not_current_user
            logout
            session[:user_id] = nil
        end
    end

    def logout
        session[:user_id] = nil
        redirect_to root_path
    end

    private
    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end

end
