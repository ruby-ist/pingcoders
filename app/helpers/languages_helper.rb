module LanguagesHelper
    class LanguageFinder

        def find name
            name.downcase!
            YAML.load_file(Rails.root + "lib/assets/languages.yml").keys.select{ |i| i.downcase.include? name }.sort_by{ |i| i.downcase.index(name) }.sort_by{|i| i.length }
        end

    end
end
