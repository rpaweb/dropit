Rails.application.routes.draw do
  resources :posts do
    resources :comments, except: [:index, :show]
    collection do
      get   :bulk
      post  :upload
    end
  end

  resources :profiles,  except: :index
  resources :follows,   only: [:create, :destroy]
  
  devise_for :users, controllers: {
    omniauth_callbacks: 'omniauth',
    registrations: 'users/registrations'
  }
  
  root to: "posts#index"
end