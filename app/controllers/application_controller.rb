require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "kitchen_organizer_secret"
    register Sinatra::Flash
  end

  get '/' do
    if logged_in?
      redirect '/cabinets'
    else
      redirect '/login'
    end
  end

  get '/welcome' do
    erb :'/welcome'
  end

  helpers do
    def redirect_if_not_logged_in
      if !logged_in?
        redirect "/login?error=You have to be logged in to do that"
      end
    end

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      @user ||= User.find(session[:user_id])
    end
  end

end
