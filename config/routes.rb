Rails.application.routes.draw do
  devise_for :users

  root 'welcome#index'

  resources :messages, except: [:show]
  resources :feeds
  resources :stories, path: "news"
  resources :schedules, except: [:show, :edit] do
    resources :schedule_times, except: [:index, :show, :new, :edit], path: "times", as: :times
  end
end
