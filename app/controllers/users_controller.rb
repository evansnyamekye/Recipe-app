class UsersController < ApplicationController
  def create
    @user = User.create(user_params)
    @user.foods.create(name: 'Apple', deleted: false)
    @user.foods.create(name: 'Pineapple', deleted: false)
    @user.foods.create(name: 'Chicken breats', deleted: false)
    redirect_to @user
  end

  def index
    @users = User.where(id: current_user.id)
  end

  def destroy
    # Log out the user using Devise's sign_out method
    sign_out current_user
    # You can also redirect to a specific page after logout
    redirect_to root_path, notice: 'Logged out successfully'
  end

  def update_name
    @user = current_user
    if @user.update(user_params)
      redirect_to users_path, notice: 'Name updated successfully.'
    else
      render :index
    end
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
