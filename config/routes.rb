Rails.application.routes.draw do
  root to: 'bands#index'

  resources :users, only: [:create, :new, :destroy]
  resource :session, only: [:create, :new, :destroy]
  delete "/session/:id/log_out_remote" => "sessions#log_out_remote", as: :log_out_remote
  delete "session/log_out_all" => "sessions#log_out_all", as: :log_out_all

  resources :bands do
    resources :albums, only:[:new]
  end
  resources :albums, except:[:new] do
    resources :tracks, only:[:new]
  end
  resources :tracks, except:[:new]
end
