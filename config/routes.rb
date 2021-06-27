Rails.application.routes.draw do
  mount ActionCable.server, at: '/cable'
  root to: 'jobs_search#search'
  resources :jobs_search, only: %i[search]
end
