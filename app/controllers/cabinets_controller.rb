class CabinetsController < ApplicationController

  get '/cabinets' do
    redirect_if_not_logged_in
    @user = User.find_by_id(session[:user_id])
    erb :'/cabinets/index'
  end

  get '/cabinets/items' do
    redirect_if_not_logged_in
    @user = User.find_by_id(session[:user_id])
    erb :'/cabinets/index_with_items'
  end

  get '/cabinets/new' do
    redirect_if_not_logged_in
    erb :'cabinets/new'
  end

  post '/cabinets' do
    if params.value?("")
      redirect '/cabinets/new'
    else
      @cabinet = Cabinet.create(params)
      @cabinet.user_id = session[:user_id]
      @cabinet.save
      redirect "/cabinets"
    end
  end

  get '/cabinets/:id' do
    redirect_if_not_logged_in
    @cabinet = Cabinet.find_by_id(params[:id])
    if @cabinet.user_id == session[:user_id]
      erb :'/cabinets/show'
    else
      redirect '/cabinets'
    end
  end

  get '/cabinets/:id/edit' do
    redirect_if_not_logged_in
    @cabinet = Cabinet.find_by_id(params[:id])
    if @cabinet.user_id == session[:user_id]
      erb :'/cabinets/edit'
    else
      redirect '/cabinets?error=You do not have access to this cabinet'
    end
  end

  post '/cabinets/:id' do
    @cabinet = Cabinet.find_by_id(params[:id])

    if params["name"] == "" && params["capacity"] == ""
      @cabinet
    elsif params["name"] == ""
      @cabinet.update(capacity: params["capacity"])
    elsif params["capacity"] == ""
      @cabinet.update(name: params["name"])
    else
      @cabinet.update(params)
    end
    redirect "/cabinets/#{@cabinet.id}"
  end

  delete '/cabinets/:id/delete' do
    @cabinet = Cabinet.find_by_id(params[:id])

    @cabinet.destroy

    redirect '/cabinets'
  end

  delete '/cabinets/delete' do
    @user = User.find_by_id(session[:user_id])

    Cabinet.all.each do |cabinet|
      if cabinet.user_id == @user.id
        cabinet.destroy
      end
    end

    redirect '/cabinets'
  end

end
