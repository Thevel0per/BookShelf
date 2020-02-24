class AddStockToEbooks < ActiveRecord::Migration[5.2]
  def change
    add_column :ebooks, :stock, :integer
  end
end
