# frozen_string_literal: true

require './lib/catalog/importer'

desc 'manage the game catalog'

task :refresh_all do
  importer = Catalog::Importer.new
  importer.refresh_all
end

task :pull_latest_xwing_data do
  repo_url = 'git@github.com:danrs/xwing-data2.git'
  destination_folder = 'xwing-data'
  system("git clone #{repo_url} #{destination_folder}")
  puts 'hello xwing'
end
