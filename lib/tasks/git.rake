require 'colorize'
require 'date'

namespace :git do

  desc 'Read data from git'
  task retrieve: :environment do

    credentials = YAML.load( File.open( 'credentials/git.yml', 'r' ).read )

    # p credentials

    Octokit.configure do |c|
      c.login = credentials[:user]
      c.password = credentials[:password]
    end

    final_hash = {}

    credentials[:repositories_names].each do |rn|

      final_hash[rn] ||= []
      results = Octokit.get( "repos/czuger/#{rn}/stats/commit_activity" )

      results.each do |result|
        week = Time.at(result[:week]).to_datetime
        next if week < DateTime.new( Time.new.year )

        result[:days].each_with_index do |amount, i|
          final_hash[rn] << [week + i, amount]
        end

      end
    end

    File.open( 'data/stats.json', 'w' ) do |file|
      file.write( final_hash.to_json )
    end

  end


end
