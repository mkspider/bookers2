class BooksController < ApplicationController
  before_action:authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id

    if @book.save
      redirect_to book_path(@book.id), notice:"Book was successfully created."
    else
      flash.now[:danger] = "error"
       @books = Book.all
       @user = current_user
      render :index
    end
  end

  def index
    @books = Book.all
    @user = current_user
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @books = Book.all
    @user = @book.user
    @book_new = Book.new

  end

  def edit
    @book = Book.find(params[:id])
    @user = @book.user

  end


  def update
    @book = Book.find(params[:id])

    if @book.update(book_params)
       redirect_to book_path(@book.id),notice:"Book was successfully updated."
    else
        @book.update(book_params)
        render :edit
    end
  end

  def destroy
    @book =Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

   def ensure_correct_user
   @book = Book.find(params[:id])
   unless @book.user == current_user
   redirect_to books_path
   end
   end
end
