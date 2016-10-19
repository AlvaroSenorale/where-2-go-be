namespace :db do
  desc 'Load the parse dump database to heroku server'
  task :import_cinema_data => :environment do
    Rake::Task['db:drop'].invoke
    ImportCinemaDataJob.new.process
  end
end
