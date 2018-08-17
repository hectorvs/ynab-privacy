#
#                    Prefix Verb URI Pattern                                                                              Controller#Action
#sdfasdf  sd;flkasdf             links_index GET  /links/index(.:format)                                                                   links#index
#              privacy_show GET  /privacy/show(.:format)                                                                  privacy#show
#              privacy_edit GET  /privacy/edit(.:format)                                                                  privacy#edit
#            privacy_update GET  /privacy/update(.:format)                                                                privacy#update
#                      root GET  /                                                                                        pages#index
#                           GET  /auth/:provider/callback(.:format)                                                       sessions#create
#                   log_out GET  /log_out(.:format)                                                                       sessions#destroy
#                     users POST /users(.:format)                                                                         users#create
#                 edit_user GET  /users/:id/edit(.:format)                                                                users#edit
#                     links GET  /links(.:format)                                                                         links#index
#    ynab_budget_categories GET  /ynab/budgets/:budget_id/categories(.:format)                                            ynab/categories#index
#              ynab_budgets GET  /ynab/budgets(.:format)                                                                  ynab/budgets#index
#        rails_service_blob GET  /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
# rails_blob_representation GET  /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#        rails_disk_service GET  /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
# update_rails_disk_service PUT  /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#      rails_direct_uploads POST /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create

Rails.application.routes.draw do
  get 'links/index'
  get 'privacy/show'
  get 'privacy/edit'
  get 'privacy/update'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#index'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/log_out' => 'sessions#destroy', as: :log_out

  resources :users, only: %i[edit create show update]
  get '/links' => 'links#index', as: :links

  namespace :ynab do
    resources :budgets, only: [:index] do
      resources :categories, only: [:index]
    end
  end
end
