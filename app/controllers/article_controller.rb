class ArticleController < ApplicationController
  def view
    # Extract the latest 18 items.
    @items = Article.where.not(title: nil).order(pubDate: :desc).limit(30)
    
    # Translate to Japanese
    @items.each do |item|
      if item.title_ja == nil
        print "Translating #{item.id} to Japanese" 
        item.translate_to_en
        item.translate_from_en('ja')
      end
    end
  end
end
