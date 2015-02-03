class AddImagePathToItem < ActiveRecord::Migration
  def change
    add_column :items, :image_path, :string
  end
end
