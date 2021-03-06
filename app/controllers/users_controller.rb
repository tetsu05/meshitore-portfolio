class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).order(name: :asc).page(params[:page]).per(6)
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render 'edit'
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'ユーザー情報を更新しました！'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
