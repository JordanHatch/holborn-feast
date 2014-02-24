HolbornFeast::Application.routes.draw do
  resources :eateries do

    put :recommended, to: "recommendations#update"
    delete :recommended, to: "recommendations#destroy"
  end

  get '/signin', to: "sessions#new", as: :new_session
  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/signout', to: "sessions#destroy", as: :session

  root :to => redirect("/eateries")
end
