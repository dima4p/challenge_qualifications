Rails.application.routes.draw do
  get 'qualifications/index'

  root 'qualifications#index'
end
