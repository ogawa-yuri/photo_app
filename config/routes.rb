Rails.application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  resources :users do
  get :favorites, on: :collection
  end


  resources :photos do
    resource :favorites, only: [:create, :destroy]
    collection do
      post :confirm
    end
  end
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
