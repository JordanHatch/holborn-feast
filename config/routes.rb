HolbornFeast::Application.routes.draw do
  resources :eateries

  root :to => redirect("/eateries")
end
