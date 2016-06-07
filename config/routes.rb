Rails.application.routes.draw do
  get 'callback' => 'callbacks#callback'
  post 'callback' => 'callbacks#callback'
end
