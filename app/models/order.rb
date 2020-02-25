class Order < ApplicationRecord
  belongs_to :user
  has_many :order_ebooks
  has_many :ebooks, through: :order_ebooks, dependent: :destroy
end
