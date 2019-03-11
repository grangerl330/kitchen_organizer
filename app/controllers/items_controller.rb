class ItemsController < ApplicationController

  get '/items' do
    redirect_if_not_logged_in
    @user = User.find_by_id(session[:user_id])
    erb :'/items/index'
  end

  get '/items/new' do
    redirect_if_not_logged_in
    @user = User.find_by_id(session[:user_id])
    erb :'items/new'
  end

end
