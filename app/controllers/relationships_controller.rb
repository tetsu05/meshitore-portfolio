class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer

    #フォローをしたタイミングで通知レコードを作成する
    #@user = User.find(params[:relationship][:follower_id])
    @user = User.find(params[:user_id])
    current_user.follow(@user)
    #通知の作成
    @user.create_notification_follow!(current_user)
    # ここまで
    #respond_to do |format|
      #format.html { redirect_to @user }
      #format.js
    #end
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

  # フォローしている人一覧
  def follower
    user = User.find(params[:user_id])
    @users = user.followings
  end

  # フォローされている人一覧
  def followed
    user = User.find(params[:user_id])
    @users = user.followers
  end


end
