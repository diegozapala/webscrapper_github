Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root "profiles#index"

  get    "profiles/new",        to: "profiles#new"
  post   "profiles",            to: "profiles#create"
  get    "profiles/:id/edit",   to: "profiles#edit"
  put    "profiles/:id",        to: "profiles#update"
  get    "profiles/:id",        to: "profiles#show"
  delete "profiles/:id",        to: "profiles#destroy"
  patch  "profiles/:id/rescan", to: "profiles#rescan"
end
