class AddGuidToArticle < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :guid, :string
    add_index :articles, :guid, :unique => true
  end
end
