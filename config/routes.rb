Rails.application.routes.draw do
  root to: "users#index"
  post 'users/upload_csv_file'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
