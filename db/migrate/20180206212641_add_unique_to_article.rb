class AddUniqueToArticle < ActiveRecord::Migration[5.1]
  def change
    change_column :articles, :link, :string, unique: true, null: false
  end
end
