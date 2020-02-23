class CreateOrderEbooks < ActiveRecord::Migration[5.2]
  def change
    create_table :order_ebooks do |t|
      t.references :order, foreign_key: true
      t.references :ebook, foreign_key: true

      t.timestamps
    end
  end
end
