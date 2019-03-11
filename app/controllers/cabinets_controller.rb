class CabinetsController < ApplicationController

  get '/cabinets' do
    redirect_if_not_logged_in
    @user = User.find_by_id(session[:user_id])
    erb :'/cabinets/index'
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
      redirect "/cabinets/#{@cabinet.id}"
    end
  end

  get '/cabinets/:id' do
    redirect_if_not_logged_in
    @cabinet = Cabinet.find_by_id(params[:id])
    if @cabinet.user_id == session[:user_id]
      erb :'/cabinets/show'
    else
      redirect '/cabinets?error=You do not have access to this cabinet'
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
    if params.value?("")
      redirect "/cabinets/#{@cabinet.id}/edit?error=All update values must be filled in"
    else
      @cabinet.update(params)
      redirect "/cabinets/#{@cabinet.id}"
    end
  end

end
