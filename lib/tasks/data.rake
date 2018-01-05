require 'trello'

namespace :data do

  desc 'Read data from trello'
  task retrieve: :environment do

    Trello.configure do |config|
      config.developer_public_key = File.open( 'credentials/developper_key.priv' ).read
      config.member_token = File.open( 'credentials/token.priv' ).read
    end

    user = Trello::Member.find(File.open( 'credentials/username.priv' ).read )

    todo_board = Hash[ user.boards.map{ |e| [ e.name, e ] } ][ 'TODO' ]

    todo_list = %w( Boring Fun Urgent )
    done_list = %w( Done )

    todo_count = done_count = 0

    Trello.client.find_many( Trello::List, "/boards/#{todo_board.id}/lists" ).each do |list|
      todo_count += Trello.client.find_many( Trello::Card, "/list/#{list.id}/cards" ).count if todo_list.include?( list.name )
      done_count += Trello.client.find_many( Trello::Card, "/list/#{list.id}/cards" ).count if done_list.include?( list.name )
    end

    stock_line = (TasksRecord.count == 0)
    TasksRecord.create(done_count: done_count, todo_count: todo_count, stock_line: stock_line )

  end

end
