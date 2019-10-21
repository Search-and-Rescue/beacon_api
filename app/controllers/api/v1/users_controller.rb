class Api::V1::UsersController < ApplicationController

  def show
    user = current_user
    render json: user, status: 200
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user.id, status: 201
    else
      render json: { error: "An error occured" }, status: 400
    end
  end

  def update
    user = current_user
    if user.update(user_params)
      render json: user, status: 200
    else
      render json: 404
    end
  end

private

  def user_params
    params.permit(:name, :address, :city, :state, :zip, :phone, :email, :password_digest, :allergies, :experience_level, :age, :weight, :hair_color, :skin_color, :gender, :cosar_card)
  end
end
