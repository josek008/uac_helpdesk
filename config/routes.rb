UacHelpdesk::Application.routes.draw do

  root :to => 'static_pages#home'

  resources :users
  resources :tickets
  resources :surveys
  resources :categories
  
  resources :sessions,  only: [:new, :create, :destroy] 
  resources :logs,      only: [:create, :destroy] 
  resources :reports,   only: [:index]

  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contact_us', to: 'static_pages#contact_us'
  
  match '/signup',  to: 'users#new'
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete

  match '/subcategories', to: 'categories#subcategories'

  match '/ticket/:id/hold',  to: 'tickets#hold', as: :ticket_on_hold
  match '/ticket/:id/close', to: 'tickets#close', as: :closing_ticket
  match '/ticket/:id/confirm_closed', to: 'tickets#confirm_closed', as: :confirm_closed
  match '/ticket/:id/reassign', to: 'tickets#reassign', as: :reassign

  match '/ticket/search/', to: 'tickets#search', as: :search

  match '/survey/:id/answer', to: 'surveys#answer', as: :answer_survey

  match '/users/:id/role', to: 'users#assign_role', as: :assign_role

  match '/users/:id/role/normal', to: 'users#be_normal', as: :user_be_normal
  match '/users/:id/role/tech', to: 'users#be_tech', as: :user_be_tech
  match '/users/:id/role/admin', to: 'users#be_admin', as: :user_be_admin

  match '/reports/by_department', to: 'reports#per_department', as: :rep_department
  match '/reports/by_tickets', to: 'reports#per_tickets', as: :rep_tickets
  match '/reports/by_tech', to: 'reports#per_tech', as: :rep_tech
  match '/reports/by_category', to: 'reports#per_category', as: :rep_category
  match '/reports/by_survey', to: 'reports#per_surveys', as: :rep_surveys

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
