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

  post '/items' do
    @user = User.find_by_id(session[:user_id])
    @cabinet = Cabinet.find_by_name(params["cabinet name"])

    if params.value?("")
      redirect '/items/new'
    else
      @item = Item.create(name: params[:name], category: params[:category])
      @user.items << @item
      @user.save
    end

    if @cabinet
      @cabinet.items << @item
      @cabinet.save
    end
    redirect '/items'
  end

end
