class PetsController < ApplicationController

  # before_action :require_movie, only: [:show]

  def index
    if params[:location]
      query = {
        animal: params[:animal],
        breed: params[:breed],
        size: params[:size],
        location: params[:location],
        sex: params[:sex],
        age: params[:age]
      }.to_query

      data = PetFinderWrapper.find_pets(query)
    else
      render status: :error, json: 'Missing Location, Please enter a Zipcode'
    end

    render status: :ok, json: data
  end

  def show
    render(
      status: :ok,
      json: @pet.as_json(
        only: [:api_id, :name, :description, :lastUpdate, :city, :breed],
        methods: [:get_shelter]
        )
      )
  end

end
