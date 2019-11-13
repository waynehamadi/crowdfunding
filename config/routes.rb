Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'pages#home'
  devise_for :users, controllers: { registrations: "users/registrations" }
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  get 'dashboard', to: 'pages#dashboard'
  resources :projects, only: %i[index show] do
    resources :contributions, only: %i[new create]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end



