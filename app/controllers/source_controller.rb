require 'rss'

class SourceController < ApplicationController
  def view
    @items = Source.all
  end

  def update
    # Read RSS and save new items to DB.
    source = Source.find_by(id: params[:id].to_i)
    if source != nil
      uri = source.rss_uri
      lang = source.language
      rss = nil
      begin
        rss = RSS::Parser.parse(uri)
      rescue RSS::InvalidRSSError
        rss = RSS::Parser.parse(uri, false)
      end
      @num_new_articles = 0

      rss.items.each do |item|
        guid = nil
        if item.guid && item.guid.content
          guid = item.guid.content
        elsif item.link
          guid = item.link
        end

        if guid != nil && Article.find_by(guid: guid) == nil && item.title != nil
          newarticle = Article.new(guid: guid, title: item.title, link: item.link, title_lang: lang)
          if item.description
            newarticle.description = item.description
          end
          
          if item.enclosure && item.enclosure.url
            newarticle.enclosure = item.enclosure.url
          elsif item.description
            # extract the first <img> tag for enclosure
            desc = Nokogiri::HTML.parse(item.description, nil, nil)
            img = desc.css('img').first
            if img
              newarticle.enclosure = img.attributes['src']
            end
          end

          if item.pubDate
            newarticle.pubDate = item.pubDate
          end
          newarticle.save
          @num_new_articles = @num_new_articles + 1
        end
      end
    end
  end
end
