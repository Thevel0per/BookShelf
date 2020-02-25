class Ebook < ApplicationRecord
  belongs_to :category
  has_many :user_ebooks
  has_and_belongs_to_many :users, through: :user_ebooks

  validates :title, presence: true
  validates :author, presence: true
  validates :price, presence: true
  validates :stock, presence: true
  validates :category, presence: true
  validates :abstract, presence: true
  validates :description, presence: true

  def quantity(user_id)
    UserEbook.where(user_id: user_id, ebook_id: id).first.quantity
  end

  def ordered_quantity(order_id)
    OrderEbook.where(order_id: order_id, ebook_id: id).first.quantity
  end
end
