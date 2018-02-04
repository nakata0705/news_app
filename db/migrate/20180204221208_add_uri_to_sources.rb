class AddUriToSources < ActiveRecord::Migration[5.1]
  def change
    add_column :sources, :rss_uri, :string
  end
end
