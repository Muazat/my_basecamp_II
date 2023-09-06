Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'users/registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"


  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end
  devise_scope :user do
      delete '/users/sign_out', :to => 'devise/sessions#destroy'
  end


  resources :projects do
    resources :project_members
    resources :discussions do
      resources :opinions
    end
  end



  get '/allusers', to: "home#getUsers", as: "allUser"

    delete '/deleteuser/:id', to: 'home#destroy', as: "deleteUser"

    post '/changeRole/:id', to: "home#updateRole", as: "changeRole"

    patch '/attach/:id', to: "projects#attach", as: "attach"

    get '/projects/:project_id/member', to: "project_members#member", as: "member"

    get '/projects/:project_id/download/:attachment_id', to: 'projects#download_attachment', as: 'download'
    #get 'errors/not_found'
    #get 'errors/internal_server_error'

    get '*path', to: 'errors#not_found'
end
