module ProfilesHelper
    class StackExchange
        include HTTParty
        base_uri 'api.stackexchange.com'

        def initialize
            super
            @options = { query: { site: "stackoverflow"}}
        end

        def find_skill name
            self.class.get("/2.3/tags/#{name}/related", @options)["items"].map{ |i| i["name"] }
        end

        def find_language name
            name.downcase!
            YAML.load_file(Rails.root + "lib/assets/languages.yml").keys.select{ |i| i.downcase.include? name }.sort_by{ |i| i.downcase.index(name) }
        end
    end
end
