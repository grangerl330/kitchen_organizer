class UsersController < ApplicationController

  get '/login' do
    if logged_in?
      redirect '/cabinets/index'
    else
      erb :'/users/login'
    end 
  end

end
