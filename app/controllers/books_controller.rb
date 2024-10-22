class BooksController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]

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
    # `current_user` のみの本を表示する場合
    # @books = current_user.books

    # 全ての本を表示する場合
    @books = Book.all
    @users = User.all
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "Book updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path, notice: "Book deleted successfully."
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end