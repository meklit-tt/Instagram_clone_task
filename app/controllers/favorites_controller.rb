class FavoritesController < ApplicationController
  def create
    favorite = current_user.favorites.create(post_id: params[:post_id])
    redirect_to posts_url, notice: "#{favorite.post.user.name}'S post has been added to favorites"
  end
  def destroy
    favorite = current_user.favorites.destroy.(post_id: params[:post_id])
    redirect_to posts_url, notice: "#{favorite.post.user.name}Unposted Mr.'s post"
  end
end
