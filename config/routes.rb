Rails.application.routes.draw do

  get 'task_records/show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'task_records#show'

end
