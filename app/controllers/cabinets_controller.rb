class CabinetsController < ApplicationController

  get '/cabinets' do
    redirect_if_not_logged_in
    erb :'/cabinets/index'
  end

end
