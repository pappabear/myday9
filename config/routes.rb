Rails.application.routes.draw do

  get    '/help',    to: 'static_pages#help'
  get    '/home',    to: 'static_pages#home'
  get    '/about',   to: 'static_pages#about'
  get    '/contact', to: 'static_pages#contact'
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users 
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]

  resources :todos
  get '/today',                       to: 'todos#today'
  get '/tomorrow',                    to: 'todos#tomorrow'
  get '/someday',                     to: 'todos#someday'
  put '/todos/mark_complete/:id',     to: 'todos#mark_complete', as: 'mark_complete'
  put '/todos/mark_incomplete/:id',   to: 'todos#mark_incomplete', as: 'mark_incomplete'
  put '/todos/move_to_tomorrow/:id',  to: 'todos#move_to_tomorrow'
  put '/todos/skip/:id',              to: 'todos#skip',  as: 'todo_skip'
  post '/todos/set_due_date/:id',     to: 'todos#set_due_date'
  post '/todos/sort',                 to: 'todos#sort'

  root   'static_pages#home'

end