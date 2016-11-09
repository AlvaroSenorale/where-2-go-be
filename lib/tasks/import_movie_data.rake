namespace :db do
  desc 'Load the parse dump database to heroku server'
  task :import_movie_data => :environment do
    MovieDataJob.new.process
  end
end
