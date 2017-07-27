class PetListController < ApplicationController
  before_action :require_user, only: [:edit, :create, :destroy]
  before_action :require_pet_list, only: [:show, :destroy, :update]

  def create

 # Parameters: {"petListData"=>{"savedPets"=>[{"35519921"=>{"pet_id"=>"35519921", "isSaved"=>true, "isFav"=>false}}, {"38065781"=>{"pet_id"=>"38065781", "isSaved"=>true, "isFav"=>false}}, {"38484487"=>{"pet_id"=>"38484487", "isSaved"=>true, "isFav"=>false}}, {"37887211"=>{"pet_id"=>"37887211", "isSaved"=>true, "isFav"=>false}}], "userId"=>1}, "pet_list"=>{}}


    # Create pet_list instance
    # pet_list = PetList.new(title: params[:title])
    pet_list = PetList.new()
    if pet_list.save

      # add user to pet_list
      pet_list.users << @user

      pets = params[:petListData][:savedPets]
      # loop over array of pets
      pets.each do |pet|
        # byebug
        # create new pet instance
        puts "#{pet[:pet_id]}========================="
        existing_pet = PetList.get_pet(pet[:pet_id])

        PetList.construct_pet_list_pet(pet_list.id, existing_pet.id)  # add 3rd param pet[:fav] ?
      end
    end

    if pet_list.pet_lists_pet.length == pets.length
      # TODO what info to send back
      render status: :ok, json: { savedPets: pets, petListId: pet_list.id }
    else
      render status: :bad_request, json: { errors: pet_list.errors.messages, other_errors: "\nOnly able to create #{pet_list.pet_lists_pet.length}/#{pets.length} pets" }
    end
  end

  def show
    pets = PetList.get_pets_data(@pet_list)
    if pets
      render status: :ok, json: {
        savedPets: pets
      }
    else
      render status: :bad_request, json: {
        errors: @pet_list.errors.messages
      }
    end
  end

  def update

    pets = params[:savedPets]

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
    @user = User.find_by id: params[:petListData][:userId]
    puts "#{@user} ==============================================="
    # byebug
    unless @user
      render status: :not_found, json: { errors: { userId: ["No such user #{params[:userId]}"] } }
    end
  end

  def require_pet_list
    @pet_list = PetList.find(params[:id])
  end

end
