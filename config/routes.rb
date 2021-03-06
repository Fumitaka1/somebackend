Rails.application.routes.draw do
  namespace :v1 do
    mount_devise_token_auth_for "User", at: "auth"
    resources :posts
    resources :comments
    resources :bookmarks
  end
end
