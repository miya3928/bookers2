class BooksController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  
  def new
    @book = Book.new
  end
  
  def create
    @book = current_user.books.build(book_params)
    if @book.save
      redirect_to book_path(@book), notice: "Book created successfully."
    else
      render :new
    end
  end

  def index
    @user = current_user
    @books = Book.all
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
  end


  def edit
  end

  def update
  end

  def destroy
  end

  private

  def book_params
   params.require(:book).permit(:title, :body)
  end

end
