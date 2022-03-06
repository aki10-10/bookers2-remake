class RelationshipsController < ApplicationController
  before_action :authenticate_user!#ログインしていないユーザーからは遷移されない記述
  #フォローするとき
  def create
    # relationships = current_user.relationships.new(followingr_id: params[:user_id])
    relationships = Relationship.new(
      following_id: params[:user_id],
      follower_id: current_user.id
    )

    relationships.save
    redirect_to request.referrer || root_path
  end
  #フォロワー外すとき
  def destroy
    # relationships = current_user.relationships.find_by(following_id: params[:user_id])
    relationships = Relationship.find_by(
      following_id: params[:user_id],
      follower_id: current_user.id
    )
    relationships.destroy
    redirect_to request.referrer || root_path
  end 
  #フォロー一覧
  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end
  #フォロワー一覧
  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end
end
