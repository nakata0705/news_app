class ArticleController < ApplicationController
  def read
    # Extract the latest 18 items.
    @items = Article.where.not(title: nil).order(pubDate: :desc).limit(18)
    
    # Translate to Japanese
    @items.each do |item|
      if item.title_ja == nil
        print "Translating #{item.id} to Japanese" 
        item.title_ja = EasyTranslate.translate(item.title, from: item.title_lang, to: 'ja', model: 'nmt', key: 'AIzaSyADjgRuNoE610_YLwW8P2_rKp08eEPDqFo')
          item.save
      end
    end
  end
end
