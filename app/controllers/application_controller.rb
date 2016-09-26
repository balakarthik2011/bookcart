class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path_for(user)
    "/books"
  end

  def check_book_owner(book)
    if book.user_id != current_user.id
      redirect_to my_books_path, notice: "You can't alter others book"
    end
    
  end
end
