Rails.application.routes.draw do
  devise_for :users

  root 'welcome#index'

  resources :messages, except: [:show]
  resources :feeds
  resources :stories, path: "news"
  resources :schedules, except: [:show]
end
