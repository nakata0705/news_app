require 'rss'

class SourceController < ApplicationController
  def view
    @items = Source.all
  end

  def update_one_source(target_id)
    # Read RSS and save new items to DB.
    source = Source.find_by(id: target_id)
    num_new_articles = 0

    # Update
    if source != nil
      uri = source.rss_uri
      lang = source.language
      rss = nil
      begin
        rss = RSS::Parser.parse(uri)
      rescue RSS::InvalidRSSError
        rss = RSS::Parser.parse(uri, false)
      end
      
      rss.items.each do |item|
        target_guid = nil
        if item.guid && item.guid.content
          target_guid = item.guid.content
        elsif item.link
          target_guid = item.link
        end

        if target_guid != nil && Article.find_by(link: item.link) == nil && item.title != nil
          newarticle = Article.new(guid: target_guid, title: item.title, link: item.link, title_lang: lang)
          
          # If the original title language is English, set English translation.
          if lang == 'en'
            newarticle.title_en = item.title
          end

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

          # Remove unwanted zoom from Vietnam site
          if newarticle.enclosure
            newarticle.enclosure.sub!(/\/zoom\/.*?\//, '/')
          end

          if item.pubDate
            newarticle.pubDate = item.pubDate
          end
          newarticle.save
          num_new_articles = num_new_articles + 1
        end
      end
    end
    return num_new_articles;
  end

  def update
    @num_new_articles = update_one_source(params[:id].to_i)
  end

  def update_all
    @num_new_articles = 0
    sources = Source.all
    
    if sources
      sources.each do |source|
        @num_new_articles = @num_new_articles + update_one_source(source.id)
      end
    end
  end
end
