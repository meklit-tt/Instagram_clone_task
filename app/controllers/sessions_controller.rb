class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to posts_path
    end
  end
    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
        session[:user_id] = user.id
        flash[:notice] = 'login succeed'
        redirect_to posts_path
        else
        flash[:danger] = 'Failed to login'
        render :new
        end
    end
    def destroy
        session.delete(:user_id)
        flash[:notice] = 'You logged out'
        redirect_to new_session_path
    end
end
