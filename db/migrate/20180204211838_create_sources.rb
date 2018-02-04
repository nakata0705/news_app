class CreateSources < ActiveRecord::Migration[5.1]
  def change
    create_table :sources do |t|
      t.string :title
      t.string :link
      t.string :description
      t.string :language
      t.string :copyright
      t.string :managingEditor
      t.string :webMaster
      t.datetime :pubDate
      t.datetime :lastBuildDate
      t.string :category
      t.string :generator
      t.string :docs
      t.string :cloud
      t.integer :ttl
      t.string :image
      t.string :rating
      t.string :textInput
      t.integer :skipHours
      t.integer :skipDays

      t.timestamps
    end
  end
end
