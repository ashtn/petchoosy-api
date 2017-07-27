class UserController < ApplicationController
  def login

    user = User.find_by(email: params[:formData][:email])
    
    if user
      render status: :ok, json: {user_id: user.id}
    else
      render status: :error, json: 'Could Not Find Account, Please try again'
    end
  end
end
