Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], as: :finish_signup

  root 'welcome#index'

  resources :messages, except: [:show]
  resources :feeds
  resources :stories, path: "news"
  resources :schedules, except: [:show, :edit] do
    resources :schedule_times, except: [:index, :show, :new, :edit], path: "times", as: :times
  end
  resource :user_time_zone, only: [:edit, :update], path: "user-time-zone"

end
