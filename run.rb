require 'trello'

Trello.configure do |config|
  config.developer_public_key = File.open( 'credentials/developper_key.priv' ).read
  config.member_token = File.open( 'credentials/token.priv' ).read
end

user = Trello::Member.find(File.open( 'credentials/username.priv' ).read )

todo_board = Hash[ user.boards.map{ |e| [ e.name, e ] } ][ 'TODO' ]

watched_lists = %w( Boring Urgent Fun )

Trello.client.find_many( Trello::List, "/boards/#{todo_board.id}/lists" ).each do |list|
  next unless watched_lists.include?( list.name )
  cards_count = Trello.client.find_many( Trello::Card, "/list/#{list.id}/cards" ).count

end