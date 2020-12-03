class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    redirect to '/pets/:id'
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(params[:pet])
    if Owner.find_by_id(params["pet"]["owner_id"])
      @pet.owner = Owner.find_by_id(params["pet"]["owner_id"])
    else
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end
    @pet.save
    redirect "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do
    if !params[:pet].keys.include?("owner_id")
      params[:pet]["owner_id"] = []
    end
       #######

    @pet = Pet.find(params[:id])
      #  @pet.update(params["pet"]["name"])
    @pet.name = params["pet"]["name"]
    if !params["owner"]["name"].empty?
        # @pet.owner.name = params["owner"]["name"]
      @pet.owner = Owner.create(name: params["owner"]["name"])
    else
      @pet.owner = Owner.find_by_id(params["pet"]["owner_id"])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end
