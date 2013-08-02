Easyblog::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users

  resources :posts do

    resources :comments do
      member do
        #comment :mark_as_not_abusive
        get 'mark_as_not_abusive'
        get 'vote_up'
        get 'vote_down'
        #comment :vote_up
      end
    end

    member do
      post :mark_archived
    end
  end
end
