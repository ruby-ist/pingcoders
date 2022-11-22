class ApplicationController < ActionController::Base
    before_action :get_notifications
    def after_sign_out_path_for(user)
        new_user_session_path
    end

    def get_notifications
        if user_signed_in?
            @notifications = current_user.notifications
        else
            @notifications = []
        end
    end
end
