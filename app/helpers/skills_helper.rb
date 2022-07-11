module SkillsHelper
    class SkillsFinder
        include HTTParty
        base_uri 'api.stackexchange.com'

        def find name
            options = { query: { order: "desc", sort: "popular", site: "stackoverflow", inname: name}}
            self.class.get("/2.3/tags", options)["items"].map{ |i| i["name"] }.select{ |i| (i =~ /\d/) == nil }
        end
    end
end
