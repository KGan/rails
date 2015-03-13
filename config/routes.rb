Rails.application.routes.draw do
  root to: 'users#index'

  resources :users, except:[:edit, :update] do
    resources :subs, only: [:new]
    resources :posts, only: [:edit, :update]
  end
  resource :session, only:[:create, :new, :destroy]

  resources :subs, except: [:new] do
    resources :posts, only: [:new]
  end

  resources :posts, except: [:new, :edit, :update]

  resources :comments, only: [:create, :destroy, :update, :show]

end
