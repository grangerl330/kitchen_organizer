class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/cabinets'
    else
      erb :'/users/new'
    end
  end

  post '/signup' do
    if params.value?("")
      redirect '/signup'
    else
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect '/welcome'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/cabinets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/cabinets'
    else
      redirect '/login?error=Invalid username or password'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/'
    else
      redirect '/'
    end
  end

end
