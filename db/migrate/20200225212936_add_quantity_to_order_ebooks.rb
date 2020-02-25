class AddQuantityToOrderEbooks < ActiveRecord::Migration[5.2]
  def change
    add_column :order_ebooks, :quantity, :integer
  end
end
