require 'trello'
require 'colorize'

namespace :data do

  desc 'Read data from trello'
  task retrieve: :environment do

    credentials = YAML.load( File.open( 'credentials/data.yml.priv', 'r' ).read )

    # p credentials

    Trello.configure do |config|
      config.developer_public_key = credentials['developer_key']
      config.member_token = credentials['token']
    end

    counts = { todo: 0, done: 0 }

    counts.keys.each do |k|
      credentials['list_ids'][k.to_s].each do |l_id|
        puts "retrieveing data for #{l_id}"
        counts[k] += Trello::List.find( l_id ).cards.count
      end
    end

    # p counts
    stock_line = (TasksRecord.count == 0)
    TasksRecord.create!(done_count: counts[:done], todo_count: counts[:todo], stock_line: stock_line )

    checklist = Trello::Checklist.find(credentials['blender_checklist_id'])
    checklist_item = checklist.items.first
    # p checklist_item.state
    DailiesSurvey.create!(blender_task_done: checklist_item.state == 'complete' )

    checklist.update_item_state( checklist_item.id, false )

  end

  desc 'Liste all lists'
  task lists: :environment do

    credentials = YAML.load( File.open( 'credentials/data.yml.priv', 'r' ).read )

    Trello.configure do |config|
      config.developer_public_key = credentials['developer_key']
      config.member_token = credentials['token']
    end

    ced = Trello::Member.find('deadzed' )

    odd = false
    printf "%-40s %-40s %s\n", 'Board', 'List', 'List id'
    puts
    ced.boards.each do |board|
      board.lists.each do |list|
        # puts "#{board.name}/#{list.name} -> list id : #{list.id}"
        printf "%-40s %-40s %s\n".send( odd ? 'red' : 'black' ), board.name, list.name, list.id
        odd = !odd
      end
    end

  end

  desc 'Generate test data'
  task generate: :environment do

    TasksRecord.delete_all
    DailiesSurvey.delete_all

    done_count = 0
    todo_count = 10
    start_date = Date.new( 2018, 1, 1 )

    0.upto(100).each do |day|
      stock_line = (TasksRecord.count == 0)
      TasksRecord.create!( done_count: done_count, todo_count: todo_count, stock_line: stock_line, created_at: start_date+day )
      DailiesSurvey.create!(blender_task_done: rand(1 .. 2 ) == 1, created_at: start_date+day )
      done_count += rand( 0 .. 6 )
      todo_count += rand( 0 .. 10 )
    end
  end

end
