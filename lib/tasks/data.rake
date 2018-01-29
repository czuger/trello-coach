require 'trello'

namespace :data do

  desc 'Read data from trello'
  task retrieve: :environment do

    credentials = YAML.load( File.open( 'credentials/data.yml.priv', 'r' ).read )

    p credentials


    Trello.configure do |config|
      config.developer_public_key = credentials['developer_key']
      config.member_token = credentials['token']
    end

    user = Trello::Member.find(credentials['username'] )
    # list = Trello::List.find(credentials['list_ids']['fun'])

    counts = { todo: 0, done: 0 }

    counts.keys.each do |k|
      credentials['list_ids'][k.to_s].each do |l_id|
        counts[k] += Trello::List.find( l_id ).cards.count
      end
    end

    p counts

    # c = Trello::Card.find(credentials['blender_card_id'])

    checklist = Trello::Checklist.find(credentials['blender_checklist_id'])
    check_items = checklist.check_items
    # pp check_items
    checklist_state = checklist.items.first
    p checklist_state
    # pp check_items[0]['state']
    # pp checklist

    # cis = Trello::CheckItemState.find(credentials['blender_checklist_state_id'])
    # pp cis

    # Trello.client.find_many( Trello::List, "/boards/#{todo_board.id}/lists" ).each do |list|
    #   p list
    # end

    # check_items[0]['state'] = 'uncomplete'
    #
    # p check_items
    #
    # # p checklist.update_fields( 'checkItems' => check_items )
    #

    # TODO : the api method seem wrong. Check if can fix it
=begin
    def update_item_state(item_id, state)
      client.put(
          "/cards/#{card_id}/checklist/#{id}/checkItem/#{item_id}/state",
          value: state,
      )
    end
  should be :
    def update_item_state(item_id, state)
      client.put(
          "/cards/#{card_id}/checkItem/#{item_id}",
          value: state,
maybe : idChecklist: id # try without
      )
    end
=end

    checklist.update_item_state( checklist_state.id, 'uncomplete' )

    stock_line = (TasksRecord.count == 0)
    TasksRecord.create(done_count: done_count, todo_count: todo_count, stock_line: stock_line )

  end

end
