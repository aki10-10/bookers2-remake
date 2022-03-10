class FavoritesController < ApplicationController
  

def create
    @book = Book.find(params[:book_id])
    favorite = @book.favorites.new(user_id: current_user.id)
    favorite.save
    # redirect_to request.referer　非同期化のため　削除
end

  def destroy
    @book = Book.find(params[:book_id])
    favorite = @book.favorites.find_by(user_id: current_user.id)
    favorite.destroy
    # redirect_to request.referer 非同期化のため削除
  end
end