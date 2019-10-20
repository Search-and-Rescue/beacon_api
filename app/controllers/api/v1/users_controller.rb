class Api::V1::UsersController < ApplicationController

  def show
    user = current_user
    render json: user, status: 200
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
    params.permit(:name, :address, :phone, :email, :password, :allegies, :experience_level, :age, :weight, :hair_color, :skin_color, :gender, :cosar_card)
  end
end
