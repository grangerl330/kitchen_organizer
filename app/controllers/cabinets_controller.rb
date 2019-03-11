class CabinetsController < ApplicationController

  get '/cabinets' do
    redirect_if_not_logged_in
    @cabinets = Cabinet.all
    erb :'/cabinets/index'
  end

end
