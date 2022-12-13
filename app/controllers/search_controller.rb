class SearchController < ApplicationController

    def index
        @search = true
        @section = 0
    end

    def show
        data = []
        query = params[:id]
        case params[:type]
        when "Name"
            users = User.where("name "+ ENV["like"] +" ?", "%"+ User.sanitize_sql_like(query) +"%")
            data = users.map {|i| {"id": i.id, "name": i.name, "url": i.image_url || "", "tags": [] }}
        when "Language"
            users = User.all.to_a.select{ |i| i.languages.length > 0 }
            data = []
            users.each do |i|
                languages = i.languages.where("name "+ ENV["like"] +" ?", "%"+ Language.sanitize_sql_like(query) +"%" ).to_a
                if languages != []
                    data << {"id": i.id, "name": i.name, "url": i.image_url || "", "tags": languages }
                end
            end
        when "Skill"
            users = User.all.to_a.select{ |i| i.skills.length > 0 }
            data = []
            users.each do |i|
                skills = i.skills.where("name " + ENV["like"] + " ?", "%"+ Skill.sanitize_sql_like(query) +"%" ).to_a
                if skills != []
                    data << {"id": i.id, "name": i.name, "url": i.image_url || "", "tags": skills }
                end
            end
        when "Job"
            posts = Post.where("body " + ENV["like"] + " ?", "%"+ Post.sanitize_sql_like(query) + "%").to_a
            unless posts.empty?
                render posts
            else
                render inline: '<div class="no-result" style="text-align: center">No Match Found!</div>'
            end
            return
        when "Company"
            users = User.all.to_a.select{ |i| i.companies.length > 0 }
            data = []
            users.each do |i|
                companies = i.companies.where("name " + ENV["like"] + " ?", "%"+ Company.sanitize_sql_like(query) +"%" ).to_a
                if companies != []
                    data << {"id": i.id, "name": i.name, "url": i.image_url || "", "tags": companies }
                end
            end
        end
        render json: data
    end

end
