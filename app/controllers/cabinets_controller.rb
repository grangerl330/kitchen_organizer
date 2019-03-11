class CabinetsController < ApplicationController

  get '/cabinets' do
    redirect_if_not_logged_in
    @user = User.find_by_id(session[:user_id])
    erb :'/cabinets/index'
  end

end
