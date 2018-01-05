Rails.application.routes.draw do

  get 'tasks_records/show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'tasks_records#show'

end
