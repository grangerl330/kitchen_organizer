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

  get '/items/:id' do
    redirect_if_not_logged_in
    @item = Item.find_by_id(params[:id])

    if @item.user_id == session[:user_id]
      erb :'/items/show'
    else
      redirect '/items?error=You do not have access to this item'
    end
  end

  get '/items/:id/edit' do
    redirect_if_not_logged_in
    @item = Item.find_by_id(params[:id])
    @user = User.find_by_id(session[:user_id])

    if @item.user_id == session[:user_id]
      erb :'/items/edit'
    else
      redirect '/items?error=You do not have access to this item'
    end
  end

  post '/items/:id' do
    @item = Item.find_by_id(params[:id])
    @cabinet = Cabinet.find_by_name(params["cabinet name"])

    if params.value?("")
      redirect "/items/#{@item.id}/edit?error=All update values must be filled in"
    else
      @item.update(name: params["name"], category: params["category"])
    end

    if @cabinet
      @item.update(cabinet_id: @cabinet.id)
    else
      @item.update(cabinet_id: "")
    end

    redirect "/items/#{@item.id}"
  end

  delete '/items/:id/delete' do
    @item = Item.find_by_id(params[:id])
    if logged_in? && @item.user_id == session[:user_id]
      @item.delete
      redirect '/items'
    else
      redirect '/login?error=You have to be logged in to do that'
    end
  end

end
