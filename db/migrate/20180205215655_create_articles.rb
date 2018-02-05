class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :title_lang
      t.string :link
      t.string :description
      t.string :author
      t.string :category
      t.string :enclosure
      t.datetime :pubDate
      t.string :title_en
      t.string :title_ja
      t.string :title_zh_cn
      t.string :title_vi
      t.string :title_ar

      t.timestamps
    end
    add_index :articles, :link
  end
end
