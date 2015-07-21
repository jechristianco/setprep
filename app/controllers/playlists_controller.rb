class PlaylistsController < ApplicationController

  def create
    Spotify.create_playlist(request.env['omniauth.auth'], request.env['omniauth.params']["id"])
    redirect_to new_searches_path
  end

end
