module ReposHelper
    class ReposFinder
        include HTTParty
        base_uri 'api.github.com'

        def find(username, query)
            options = {query: {sort: "pushed", per_page: 100}}
            data = self.class.get("/users/#{username}/repos", options).map{|i| i["name"]}
            data = data.select{ |i| i.downcase.include? query.downcase } unless query == nil
            data
        end
    end
end
