class BooksController < ApplicationController

  def index
    @books = Book.all.order(:id)
    @fav_books = current_user.fav_books
  end

  def new

    @book = Book.new

  end

  def create
    @book = current_user.books.new(book_params)
    respond_to do |format|
      if @book.save
        format.html {redirect_to my_books_path, notice: "Your book is successfully created"}
      else

        format.html { render :new }
      end
    end
  end

  def edit
    @book = Book.find(params[:format])
    check_book_owner(@book)
  end

  def update
    @book = Book.find(params[:book][:id])
    respond_to do |format|

      if @book.update_attributes(book_params)
        format.html { redirect_to my_books_path, notice: "Your book is successfully updated" }
      else
        format.html { render :edit }
      end
    end

  end

  def destroy
    @book = Book.find(params[:format])
    check_book_owner(@book)

    # respond_to do |format|
      if @book.delete
        redirect_to my_books_path, notice: "Your book is successfully deleted"
      else
        redirect_to my_books_path, notice: "unable to delete your book"
      end



  end

  def my_books

    @books = current_user.books.order(:id)

  end

  def fav_books
    @books = current_user.fav_books
  end

  def make_favourite

    book = Book.find(params[:id])
    fav_book =  current_user.fav_books.include?(book)
    message = "#{book.name} successfully "
    if fav_book
      FavoriteBook.where(book_id: params[:id], user_id: current_user.id).delete_all
      message += "removed from "
    else
      FavoriteBook.create(book_id: params[:id], user_id: current_user.id)
      message += "added to "
    end
    message += "favourites list"
    redirect_to books_path, notice: message
  end

  private

  def book_params
    params.require(:book).permit(:name, :author, :description)

  end

end
