class AddLatitudeAndLongitudeToArticle < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :latitude, :float
    add_column :articles, :longitude, :float
    add_column :articles, :address, :string
  end
end
