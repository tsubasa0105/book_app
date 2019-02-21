Rails.application.routes.draw do
  devise_for :users, only: :omniauth_callbacks, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}

  scope "(:locale)" do
    resources :books
    root 'books#index'
    devise_for :users, skip: :omniauth_callbacks, controllers: {registrations: 'users/registrations'}
  end
end
