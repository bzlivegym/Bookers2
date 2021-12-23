class BooksController < ApplicationController
  before_action :authenticate_user!

  before_action :correct_user, only: [:edit, :update]

  def show
    @newbook = Book.new
    @book = Book.find(params[:id])
  end

  def index
    @book = Book.new
    @books = Book.all
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    @book.user_id = current_user.id
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
      redirect_to books_path
    end

  end

  private
  def correct_user
      @book = Book.find(params[:id])
      if current_user.id != @book.user.id
        redirect_to books_path
      end
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
