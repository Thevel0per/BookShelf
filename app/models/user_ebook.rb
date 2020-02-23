class UserEbook < ApplicationRecord
  belongs_to :user
  belongs_to :ebook
end
