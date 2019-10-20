Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      get '/profile', to: 'users#show'
      post'/profile/new', to: 'users#create'
      patch '/profile/edit', to: 'users#update'
    end
  end
end
