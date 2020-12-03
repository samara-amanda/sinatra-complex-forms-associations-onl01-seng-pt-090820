class OwnersController < ApplicationController

  get '/owners/new' do
    @pets = Pet.all
    erb :'/owners/new'	    erb :'/owners/new'
  end	  end


  post '/owners' do 	  post '/owners' do
    @owner = Owner.create(params[:owner])
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end
    redirect "owners/#{@owner.id}"
  end


  get '/owners/:id/edit' do 	  get '/owners/:id/edit' do
    @owner = Owner.find(params[:id])
    @pets = Pet.all
    erb :'/owners/edit'
  end

  patch '/owners/:id' do
    ####### bug fix
    if !params[:owner].keys.include?("pet_ids")
      params[:owner]["pet_ids"] = []
    end
    #######

    @owner = Owner.find(params[:id])
    @owner.update(params["owner"])
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end
      redirect "owners/#{@owner.id}"
    end

  end
end
