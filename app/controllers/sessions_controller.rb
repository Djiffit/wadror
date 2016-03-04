
class SessionsController < ApplicationController
  def new

  end

  def create_oauth
    user = User.find_by(username:env["omniauth.auth"].info.nickname)
    if (user)
      if (user.banned)
        redirect_to users_path, notice:"Account banned, contact adminstrators for assistance!"
      end
      if (user.github)
        session[:user_id] = user.id
        session[:github] = env["omniauth.auth"].info
        redirect_to user_path(user.id), notice: "Welcome back m80"
      end
    else
      user = User.create(username:env["omniauth.auth"].info.nickname, github:true)
      session[:user_id] = user.id
      session[:github] = env["omniauth.auth"].info
      redirect_to user_path(user.id), notice: "Welcome to the most acclaimed beer rating community!"
    end
  end

  def create
    user = User.find_by username: params[:username]
    if !user.github && user && user.authenticate(params[:password])
      if user.banned
        redirect_to :back, notice:"Account banned, contact adminstrators for assistance!"
        return
      end
      session[:user_id] = user.id
      redirect_to user_path(user), notice: "Welcome back!"
    else
      redirect_to :back, notice: "Username and/or password mismatch"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end
end