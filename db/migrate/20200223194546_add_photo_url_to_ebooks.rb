class AddPhotoUrlToEbooks < ActiveRecord::Migration[5.2]
  def change
    add_column :ebooks, :photo_url, :string
  end
end
