Rails.application.routes.draw do
    devise_for :users

    root "profiles#index"
    resources :profiles

    get "find/:type", to: "profiles#find"
    post "language", to: "profiles#language", as: "language"
    post "skill", to: "profiles#skill", as: "skill"
end
