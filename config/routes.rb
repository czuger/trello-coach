Rails.application.routes.draw do

  get 'dailies/show'

  get 'git_summary/show'

  get 'monitoring/show'

  get 'tasks_records/show'
  # get 'tasks_records/data'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'tasks_records#show'

end
