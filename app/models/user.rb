class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :books
  has_many :favorite_books
  has_many :fav_books, through: :favorite_books, source: "book"

  validates_presence_of :name

  def admin
    if self.id == 1
      return true
    end
    false
  end

  def to_s
    email
  end
end
