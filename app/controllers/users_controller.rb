class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_current_user, {only: [:edit, :update, :destroy]}
  
  def index
    @user = current_user
    @users = User.all
    @book = Book.new
    @not_users = User.where.not(id: current_user.id)
  end
  
  def followings
    user = User.find(params[:id])
    @users = user.followings
  end
  
  def followers
    user = User.find(params[:id])
    @users = user.followers
  end  

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to user_path(current_user)
    end  
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice]="You have update user successfully."
      redirect_to user_path(current_user)
    else
      render :edit
    end
    
  def destroy
   
  end 
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
  def ensure_current_user
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to user_path(current_user.id)
    end  
  end
end
