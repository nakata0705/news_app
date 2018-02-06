class ArticleController < ApplicationController
  def view
    begin
      # Identify the correct lang code
      @lang_db, @lang_google = Article.validate_langcode(params[:lang])
      # Extract the latest 18 items.
      @items = Article.where.not(title: nil).order(pubDate: :desc).limit(30)
      
      # Translate to specified language
      @items.each do |item|
        item.translate_to_en
        item.translate_from_en(lang_google)
      end
    rescue => exception      
    end
  end
end
