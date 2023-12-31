Rails.application.routes.draw do
  devise_for :users

  root to: 'articles#index'
  
  resources :articles do
    collection do
      post :show_articles
      match "/edit/:id" => "articles#edit", via: [:get]
    end  
  end  

  
end
