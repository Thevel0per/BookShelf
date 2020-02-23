class CreateUserEbooks < ActiveRecord::Migration[5.2]
  def change
    create_table :user_ebooks do |t|
      t.references :user, foreign_key: true
      t.references :ebook, foreign_key: true

      t.timestamps
    end
  end
end
