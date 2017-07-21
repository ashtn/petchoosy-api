class PetListController < ApplicationController
  before_action :require_user, only: [:edit, :create, :destroy]
  before_action :require_pet_list, only: [:show, :destroy, :update]

  def create

    # Create pet_list instance
    pet_list = PetList.new(title: params[:title])

    if pet_list.save

      # add user to pet_list
      pet_list.users << @user

      pets = params[:pets]

      # loop over array of pets
      pets.each do |pet|
        # create new pet instance
        existing_pet = PetList.get_pet(pet[:pet_id])

        PetList.construct_pet_list_pet(pet_list.id, existing_pet.id)  # add 3rd param pet[:fav] ?
      end
    end

    if pet_list.pet_lists_pet.length == pets.length
      # TODO what info to send back
      render status: :ok, json: { pets: pets, pet_listId: pet_list.id }
    else
      render status: :bad_request, json: { errors: pet_list.errors.messages, other_errors: "\nOnly able to create #{pet_list.pet_lists_pet.length}/#{pets.length} pets" }
    end
  end

  def show
    pets = PetList.get_pets_data(@pet_list)
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

  def update

    pets = params[:pets]

    pets.each_with_index do |pet, index|

      existing_pet = PetList.get_pet(pet[:pet_id])

      if existing_pet
        existing_pet_lists_pet = PetList.get_pet_lists_pet(@pet_list.id, existing_pet.id)

        if !existing_pet_lists_pet

          PetList.construct_pet_list_pet(@pet_list.id, existing_pet.id)
        end
      end
    end

    if pets.length == @pet_list.pet_lists_pet.length

      render status: :ok, json: {message: "#{pets.length} sent : #{@pet_list.pet_lists_pet.length} pets saved"}

    else
      render status: :bad_request, json: { errors: @pet_list.errors.messages, other_errors: "\n#{pets.length} sent : #{@pet_list.pet_lists_pet.length} pets saved" }
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
