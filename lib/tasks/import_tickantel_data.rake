namespace :db do
  desc 'Load the parse dump database to heroku server'
  task :import_movie_data => :environment do
    TickantelScraper.new.process
  end
end