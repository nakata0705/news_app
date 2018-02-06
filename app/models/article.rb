class Article < ApplicationRecord
    validates :link, { uniqueness: true, presence: true }
    validates :title, { presence: true }
    validates :title_lang, { presence: true }
    
    def self.validate_langcode(to)
        to.downcase!
        to_google = nil
        case to
        when 'zh-cn' then
            to = 'zh_cn'
            to_google = 'zh-CN'
        when 'zh-tw' then
            to = 'zh_tw'
            to_google = 'zh-TW'
        else
            to_google = to
        end
        
        if self.attribute_names.index("title_#{to}") == nil
            raise "Invalid target language #{to}"
        end

        return to, to_google
    end

    def translate_to_en
        if self.title_en == nil
            if self.title_lang == 'en'
                self.title_en = self.title
            else
                self.title_en = EasyTranslate.translate(self.title, from: self.title_lang, to: 'en', model: 'nmt', key: 'AIzaSyADjgRuNoE610_YLwW8P2_rKp08eEPDqFo')
            end
            self.save
        end
    end

    def translate_from_en(to)
        begin
            if title_en == nil
                raise "English translation doesn't exist"
            end

            if to == nil
                raise "No target language"
            end
            
            to_db, to_google = Article.validate_langcode(to)
            
            if attribute_names.index("title_#{to_db}") == nil
                raise "Invalid target language #{to_db}"
            end

            if self["title_#{to_db}"] == nil
                to_db_title, to_google_title = Article.validate_langcode(title_lang)
                if to_db_title == to_db
                    self["title_#{to_db}"] = title
                else
                    self["title_#{to_db}"] = EasyTranslate.translate(self.title_en, from: 'en', to: to_google, model: 'nmt', key: 'AIzaSyADjgRuNoE610_YLwW8P2_rKp08eEPDqFo')
                end
                self.save
            end
        rescue => exception
            p exception
        end
    end
end
