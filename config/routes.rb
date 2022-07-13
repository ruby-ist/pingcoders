Rails.application.routes.draw do
    devise_for :users, controllers: { omniauth_callbacks: 'user/omniauth_callbacks' }

    root "profiles#index"
    resources :profiles, only: [:index, :show, :edit, :update] do
        resources :emails, except: [:index, :show]
        resources :numbers, except: [:index, :show]
        resources :addresses, except: [:index, :show]

        resources :languages, only: [:destroy]
        resources :skills, only: [:destroy]

        resources :repos, only: [] do
            resources :likes, only: [:create, :destroy]
        end
    end

    resources :repos, only: [:index, :create, :destroy]
    resources :languages, only: [:index, :create]
    resources :skills, only: [:index, :create]
    resources :colors, only: [:index]
end
