Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'pages#home'
  devise_for :users, controllers: { registrations: "users/registrations", omniauth_callbacks: 'users/omniauth_callbacks' }
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  get 'dashboard', to: 'pages#dashboard'
  resources :projects, only: %i[index show] do
    resources :contributions, only: %i[create]
  end
  get 'payment', to: 'payments#payment'
  match 'csvs/:id/download' => 'csv#download', as: 'csv_download', via: [:get]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end



