class AddAbstractToEbooks < ActiveRecord::Migration[5.2]
  def change
    add_column :ebooks, :abstract, :text
    change_column :ebooks, :description, :text
  end
end
