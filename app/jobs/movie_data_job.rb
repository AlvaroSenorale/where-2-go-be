# require 'net/http'
class MovieDataJob
  def process
    ImportMovieCinemaDataJob.new.process
    ImportMovieTheaterDataJob.new.process
  end
end

