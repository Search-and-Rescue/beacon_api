class Api::V1::UsersController < ApplicationController

  def update
    user = current_user
    user.update(user_params)
    render json: user, status: 201
  end

private

  def user_params
    params.permit(:name, :address, :phone, :email, :password, :allegies, :experience_level, :age, :weight, :hair_color, :skin_color, :gender, :cosar_card)
  end
end
