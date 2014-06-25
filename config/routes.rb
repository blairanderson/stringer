Rails.application.routes.draw do
  devise_for :users

  root 'welcome#index'
  resources :feeds
  resources :stories, path: "news"
end
