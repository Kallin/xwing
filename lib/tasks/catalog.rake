# frozen_string_literal: true

require './lib/catalog/importer'

desc 'manage the game catalog'

desc 'reload all the game component data'
task refresh_all: :environment do
  importer = Catalog::Importer.new
  importer.refresh_all
end

desc 'grab the latest xwing data from their repo. this is used to populate our DB of game components.'
task pull_latest_xwing_data: :environment do
  repo_url = 'git@github.com:danrs/xwing-data2.git'
  destination_folder = 'xwing-data'
  system("git clone #{repo_url} #{destination_folder}")
  puts 'hello xwing'
end
