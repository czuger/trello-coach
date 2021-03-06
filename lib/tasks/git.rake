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

    git_data = {}
    git_amounts = {}

    credentials[:repositories_names].each do |rn|

      puts "retrieveing data for #{rn}"

      final_hash = []
      results = Octokit.get( "repos/czuger/#{rn}/stats/commit_activity" )

      # puts "results = #{results}"

      total_amount = 0

      results.each do |result|
        week = Time.at(result[:week]).to_datetime
        next if week < DateTime.new( Time.new.year )

        result[:days].each_with_index do |amount, i|
          final_hash << { 'Date': (week + i).strftime( '%F' ), 'Count': amount }
          total_amount += amount
        end
      end

      git_data[rn] = final_hash
      git_amounts[rn] = total_amount
    end

    File.open( "data/git_data.json", 'w' ) do |file|
      file.write( git_data.to_json )
    end

    File.open( "data/git_repositories_order.json", 'w' ) do |file|
      file.write( git_amounts.sort_by { |_, amount| amount }.reverse.map{ |e| e.first }.to_json )
    end
  end
end
