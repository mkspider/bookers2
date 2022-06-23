class UsersController < ApplicationController
 before_action :authenticate_user!
 before_action :correct_user, only: [:edit, :update]

def index
    @users = User.all
    @user_new = User.new
    @book = @user
    @user = current_user
end



 def create
 @user = User.new(user_params)
    if @user.save
     flash[:success] = 'successfully'
      redirect_to books_path
    else
      flash.now[:danger] = 'ユーザーerror'
      render :new
    end
 end


  def show
     @user =User.find(params[:id])
     @books = @user.books #アソシエーション？
     @book = Book.new
  end

  def edit
      @user = User.find(params[:id])

  end


  def update
  @user = User.find(params[:id])

    if @user.update(user_params)
       redirect_to user_path(@user.id), notice:"successfully"
    else
       render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:profile_image, :name, :introduction)
  end

  def correct_user
    @user = User.find(params[:id])
    if @user != current_user
    redirect_to user_path(current_user.id)
    end
  end
end

