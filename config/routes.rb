Rails.application.routes.draw do
    devise_for :users, controllers: { omniauth_callbacks: 'user/omniauth_callbacks' }

    root "profiles#index"
    resources :profiles

    get "find/:type", to: "profiles#find"
    post "language", to: "profiles#language", as: "language"
    post "skill", to: "profiles#skill", as: "skill"
    post "project", to: "profiles#project", as: "project"
    get "colors", to: "profiles#colors", as: "colors"
    post "account", to: "profiles#account", as: "account"
end
