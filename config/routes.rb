Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :customers do
        post 'subscriptions', to: 'customer_subscriptions#create'
        # resources :subscriptions, only: [:show]
        get 'subscriptions', to: 'customer_subscriptions#show'
      end
    end
  end
end
