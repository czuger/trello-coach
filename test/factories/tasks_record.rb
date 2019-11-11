FactoryBot.define do

  factory :tasks_record do

    done_count {10}
    todo_count  {3}
    stock_line {false}

    created_at {Time.now()}
  end

end