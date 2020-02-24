class AddQuantityToUserEbooks < ActiveRecord::Migration[5.2]
  def change
    add_column :user_ebooks, :quantity, :integer, default: 0
  end
end
