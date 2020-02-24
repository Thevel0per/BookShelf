class Ebook < ApplicationRecord
  belongs_to :category
  has_many :user_ebooks
  has_and_belongs_to_many :users, through: :user_ebooks
end
