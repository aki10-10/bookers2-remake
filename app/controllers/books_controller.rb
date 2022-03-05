class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_current_user, {only: [:edit,:update,:destroy]}  
  
  def index
    @user = current_user
    @users = User.all
    @books = Book.all
    @newbook = Book.new
    @book_comment = BookComment.new
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice]="You have created book successfully"
      redirect_to book_path(@book)
    else
      @user = current_user
      @books = Book.all
      render :index
    end  
  end  

  def show
    @newbook = Book.new
    @books = Book.all
    @book = Book.find(params[:id])
    @user =@book.user
    @book_comment = BookComment.new
    @book_coments = @book.book_comments
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render"edit"
    else
      redirect_to books_path
    end  
  end
  
  def update
    @book = Book.find(params[:id])
    @book.user_id =current_user.id
    if @book.update(book_params)
      flash[:notice]="Book was successfully updated."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end  
  
  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
       flash[:notice] = "Book was successfully destroyed."
       redirect_to books_path
    end
  end  
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def ensure_current_user
    @book = Book.find(params[:id])
    if @book.user_id != current_user.id
      redirect_to books_path
    end 
  end  
end
