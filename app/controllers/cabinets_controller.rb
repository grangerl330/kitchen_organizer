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
      redirect "/cabinets/#{@cabinet.id}"
    end
  end

end
