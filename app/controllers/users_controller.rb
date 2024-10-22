class UsersController < ApplicationController
  def index  
    @user = current_user # または特定のユーザーを取得する
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
    @books =@user.books
  end
    
  def edit
    @user = User.find(params[:id])
  end
   
  def update
    @user = User.find(params[:id])
     if @user.update(user_params)
      redirect_to user_path(@user), notice: "User updated successfully."
    else
      render :edit
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
    

