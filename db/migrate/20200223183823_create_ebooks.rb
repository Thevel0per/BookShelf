class CreateEbooks < ActiveRecord::Migration[5.2]
  def change
    create_table :ebooks do |t|
      t.references :category, foreign_key: true
      t.string :title
      t.string :author
      t.string :description
      t.decimal :price

      t.timestamps
    end
  end
end
