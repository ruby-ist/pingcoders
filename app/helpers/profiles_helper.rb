module ProfilesHelper
    class StackExchange
        include HTTParty
        base_uri 'api.stackexchange.com'

        def initialize
            super
        end

        def find_skill name
            options = { query: { order: "desc", sort: "popular", site: "stackoverflow", inname: name}}
            self.class.get("/2.3/tags", options)["items"].map{ |i| i["name"] }.select{ |i| (i =~ /\d/) == nil }
        end

        def find_language name
            name.downcase!
            YAML.load_file(Rails.root + "lib/assets/languages.yml").keys.select{ |i| i.downcase.include? name }.sort_by{ |i| i.downcase.index(name) }
        end
    end
end