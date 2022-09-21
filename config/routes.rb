Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      post 'subscriptions', to: 'subscriptions#create'
      get 'subscriptions', to: 'subscriptions#show'
    end
  end
end
