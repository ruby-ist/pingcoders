Rails.application.routes.draw do
    devise_for :users, controllers: { omniauth_callbacks: 'user/omniauth_callbacks' }

    root "profiles#index"
    resources :profiles, only: [:index, :show, :edit, :update] do
        resources :addresses, only: [:create]
        resources :numbers, only: [:create]
        resources :emails, only: [:create]
    end

    resources :languages, only: [:index, :create]
    resources :skills, only: [:index, :create]
    resources :repos, only: [:index, :create]
    resources :colors, only: [:index]
end
