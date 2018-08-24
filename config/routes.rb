# == Route Map
#
#                    Prefix Verb   URI Pattern                                                                              Controller#Action
#               cards_index GET    /cards/index(.:format)                                                                   cards#index
#              privacy_show GET    /privacy/show(.:format)                                                                  privacy#show
#              privacy_edit GET    /privacy/edit(.:format)                                                                  privacy#edit
#            privacy_update GET    /privacy/update(.:format)                                                                privacy#update
#                      root GET    /                                                                                        pages#index
#            privacy_policy GET    /privacy_policy(.:format)                                                                pages#privacy_policy
#                           GET    /auth/:provider/callback(.:format)                                                       sessions#create
#                   log_out GET    /log_out(.:format)                                                                       sessions#destroy
#            category_links GET    /category_links(.:format)                                                                pages#category_links
#                     users POST   /users(.:format)                                                                         users#create
#                 edit_user GET    /users/:id/edit(.:format)                                                                users#edit
#                      user GET    /users/:id(.:format)                                                                     users#show
#                           PATCH  /users/:id(.:format)                                                                     users#update
#                           PUT    /users/:id(.:format)                                                                     users#update
#                     links GET    /links(.:format)                                                                         links#index
#                           POST   /links(.:format)                                                                         links#create
#                      link DELETE /links/:id(.:format)                                                                     links#destroy
#    ynab_budget_categories GET    /ynab/budgets/:budget_id/categories(.:format)                                            ynab/categories#index
#      ynab_budget_accounts GET    /ynab/budgets/:budget_id/accounts(.:format)                                              ynab/accounts#index
#              ynab_budgets GET    /ynab/budgets(.:format)                                                                  ynab/budgets#index
#             privacy_cards GET    /privacy/cards(.:format)                                                                 privacy/cards#index
#      privacy_transactions POST   /privacy/transactions(.:format)                                                          privacy/transactions#receive
#        rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
# rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#        rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
# update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#      rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create

Rails.application.routes.draw do
  get 'cards/index'
  get 'privacy/show'
  get 'privacy/edit'
  get 'privacy/update'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#index'
  get '/privacy_policy' => 'pages#privacy_policy'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/log_out' => 'sessions#destroy', as: :log_out
  get '/category_links' => 'pages#category_links', as: :category_links

  resources :users, only: %i[edit create show update]
  resources :links, only: %i[index create destroy]

  namespace :ynab do
    resources :budgets, only: [:index] do
      resources :categories, only: [:index]
      resources :accounts, only: [:index]
    end
  end

  namespace :privacy do
    resources :cards, only: [:index]
    post '/transactions' => 'transactions#receive', as: :transactions
  end
end
