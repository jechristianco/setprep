class SearchesController < ApplicationController

  def new
    @search = Search.new(search_params)
    respond_to do |format|
      format.html { render 'new'}
    end
  end

  def create
    @search = Search.create(search_params)
    @search.execute
    respond_to do |format|
      format.json { render json: search_json, status: 200 }
    end
  end

  def show
    @search = Search.find(params[:id])
    @playlist = @search.playlist
    respond_to do |format|
      format.html
      format.json { render json: search_json, status: 200 }
    end
  end

  private

  def search_json
    Jbuilder.encode do |j|
      j.id @search.id
      j.query @search.query
      if @playlist != nil
        j.playlist do
          j.id @playlist.id
          j.warning @playlist.warning if !@playlist.warning.nil?
          j.songs @playlist.songs.order(:score).reverse do |song|
            j.score song.score
            j.performance_count song.performance_count
            j.popularity song.popularity
            j.last_performed song.last_performed
            j.name song.name
          end
        end
      end
    end
  end

  def search_params
    params.permit(:search, :query)
  end

end
