class ItemsController < ApplicationController

  get '/items/new' do
    @cabinet = Cabinet.find_by_id(params["cabinet id"])
    redirect_if_not_logged_in
    @user = User.find_by_id(session[:user_id])
    erb :'items/new'
  end

  post '/items' do
    @user = User.find_by_id(session[:user_id])
    @cabinet = Cabinet.find_by(name: params["cabinet name"], user_id: @user.id)
    binding.pry
    if params["name"] == ""
      redirect '/items/new?error=Item must have a name'
    else
      @item = Item.create(name: params[:name], cabinet_id: @cabinet.id, user_id: @user.id)
    end

    redirect "/cabinets/#{@cabinet.id}"
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

    if params["name"] == ""
      redirect "/items/#{@item.id}/edit?error=Name must be filled in"
    else
      @item.update(name: params["name"], cabinet_id: @cabinet.id)
    end

    redirect "/cabinets/#{@cabinet.id}"
  end

  delete '/items/:id/delete' do
    @item = Item.find_by_id(params[:id])
    @cabinet = @item.cabinet

    @item.destroy

    redirect "/cabinets/#{@cabinet.id}"
  end

end
