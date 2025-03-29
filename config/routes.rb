Rails.application.routes.draw do
  # Authentication
  resource :session
  resource :registration, only: [ :new, :create ]
  resources :passwords, param: :token

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "habits#home"
  post "habits/:id/done", to: "habits#mark_done", as: :done_habit
  delete "habits/reset", to: "habits#reset_day", as: :reset_habits
  resources :habits, only: %i[index new create show destroy]
  resources :goals, only: %i[index show]
  get "settings", to: "pages#settings"
  get "timer", to: "pages#timer"
  get "style", to: "pages#style"
end
