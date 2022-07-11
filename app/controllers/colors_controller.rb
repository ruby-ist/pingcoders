class ColorsController < ApplicationController

    def index
        file = File.open(Rails.root + "lib/assets/colors.json")
        render json: JSON.load(file)
    end

end