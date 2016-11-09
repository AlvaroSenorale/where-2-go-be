class MovieCenterController < ApplicationController

  def index
    @movies = MovieEntity.where(entity_type: 0)  
    @theater = MovieEntity.where(entity_type: 1)
  end
end
