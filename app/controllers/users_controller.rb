class UsersController < ApplicationController

  get '/login' do
    if logged_in?
      redirect '/cabinets/index'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/cabinets/index'
    else
      redirect '/login'
    end
  end

end
