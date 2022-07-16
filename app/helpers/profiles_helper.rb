module ProfilesHelper
    class UserFinder
        include HTTParty
        base_uri 'api.github.com'

        def find_pic(username)
            self.class.get("/users/#{username}")["avatar_url"]
        end
    end
end
