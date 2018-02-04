class AddIndexToSources < ActiveRecord::Migration[5.1]
  def change
    add_index :sources, :rss_uri
    change_column_null :sources, :rss_uri, false
    change_column_null :sources, :title, false
    change_column_null :sources, :language, false
  end
end
