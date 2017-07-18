class PetListController < ApplicationController
  before_action :require_user, only: [:create, :destroy]
  # postdata = pets: { {000000: {fav: true}}}
  def create

    user_group = UserGroup.new
    user_group.save

    petlist = PetList.new(user_group_id: user_group.id)
    petlist.save

    # create new pet instance with user_id, api_id, fav: true/false, score
    pets = Pet.add_pets(@user.id, params[:pets], petlist.id)

    # loop over array of pets
      pets.each do |pet|
        puts 'pet ==============================================='
        ap pet
        puts 'pet.class ========================================='
        puts pet.class
        ## check if pet already exists in petlist
        ## add fav and score to pet list?
        # puts '=================================================='
        # puts pet.class
        # byebug
        # add pets method in petlistpets join table, accepts and array of pet objects
        petlist.pets << pet if pet.class == Pet
      end
      ap petlist.pets
      byebug
    if petlist.pets #user_group must exist
      render status: :ok, json: { pets: pets }
    else
      render status: :bad_request, json: { errors: petlist.errors.messages }
    end
  end

  def require_user
    @user = User.find_by id: params[:user_id]
    unless @user
      render status: :not_found, json: { errors: { user_id: ["No such user #{params[:user_id]}"] } }
    end
  end
end
