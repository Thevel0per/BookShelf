class OrderEbook < ApplicationRecord
  belongs_to :order
  belongs_to :ebook
end
