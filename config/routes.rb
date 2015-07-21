Rails.application.routes.draw do
  root to: 'searches#new'
  get '/searches', to: 'searches#new', as: "new_searches"
  post '/searches', to: 'searches#create'
  get '/searches/:id', to: 'searches#show'
  get '/auth/spotify/callback', to: 'playlists#create'
  get '/search_suggestions', to: 'search_suggestions#index'
end
