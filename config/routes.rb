Rails.application.routes.draw do
    devise_for :users, controllers: { omniauth_callbacks: 'user/omniauth_callbacks' }

    root "profiles#index"
    resources :profiles, only: [:index, :show, :edit, :update] do
        resources :emails, except: [:index, :show]
        resources :numbers, except: [:index, :show]
        resources :addresses, except: [:index, :show]
    end

    resources :languages, only: [:index, :create]
    resources :skills, only: [:index, :create]
    resources :repos, only: [:index, :create]
    resources :colors, only: [:index]
end
