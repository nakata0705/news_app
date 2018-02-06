class AddTitleFrToArticle < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :title_fr, :string
  end
end
