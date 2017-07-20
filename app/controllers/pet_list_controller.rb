class PetListController < ApplicationController
  before_action :require_user, only: [:edit, :create, :destroy]
  before_action :require_pet_list, only: [:show, :destroy]
  # postdata = pets: { {000000: {fav: true}}}
  def create

    # Create PetList instance
    petlist = PetList.new(title: params[:title])


    if petlist.save

      # add user to petlist
      petlist.users << @user

      pets = params[:pets]

      # loop over array of pets
      pets.each do |pet|
        # create new pet instance
        existing_pet = Pet.construct(pet[:pet_id])

        #create new pet_lists_pet
        PetListsPet.construct(petlist.id, existing_pet.id) # add 3rd param pet[:fav] ?
      end
    end

    if petlist.pet_lists_pet.length == pets.length
      # what info to send back
      render status: :ok, json: { pets: pets, petListId: petlist.id }
    else
      render status: :bad_request, json: { errors: petlist.errors.messages, other_errors: "\nOnly able to create #{petlist.pet_lists_pet.length}/#{pets.length} pets" }
    end
  end

  def show
    pets = PetList.get_pets(@pet_list)
    if pets
      render status: :ok, json: {
        pets: pets
      }
    else
      render status: :bad_request, json: {
        errors: @pet_list.errors.messages
      }
    end
  end

private
  def require_user
    @user = User.find_by id: params[:user_id]
    unless @user
      render status: :not_found, json: { errors: { user_id: ["No such user #{params[:user_id]}"] } }
    end
  end

  def require_pet_list
    @pet_list = PetList.find(params[:id])
  end

end
