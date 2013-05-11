Myapp::Application.routes.draw do

  get "employees/index"

  get "employees/show"

  get "employees/create"

  resources :stylist_services


  resources :wireless_providers


  resources :appointments
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :salons do
    resources :employees do 
      resources :stylist_services
    end

    resources :stylists

    resources :services
    # resources :users
  end

  # added these resources because we are using STI
  # See this link: http://stackoverflow.com/questions/5246767/sti-one-controller
  #
  resources :clients, controller: "users", type: "Client"
  #resources :stylists, controller: "users", type: "Stylist"


  root :to => 'static_pages#home'

  match '/confirm/:id/:confirmation_code', to: 'users#confirm', :as => :confirm
  match '/forgot_password', to: 'users#forgot_password'
  match '/password_reset', to: 'users#password_reset'
  match '/recover/:reset_code', to: 'users#recover', :as => :recover
  
  match '/signup',  to: 'users#new'
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete
  
  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contact',  to: 'static_pages#contact'
  match '/faq',     to: 'static_pages#faq'

  match '/select_stylist/:id', to: 'salons#select_stylist', :as => :select_stylist
  match '/get_stylists/:id', to: 'salons#get_stylists', :as => :get_stylists
  match '/get_services/:id', to: 'salons#get_services', :as => :get_services

  match '/appointments/:id/confirm' => 'appointments#confirm', :as => :confirm_appointment
  match '/appointments/:id/cancel'  => 'appointments#cancel', :as => :cancel_appointment
  
  match '/:salonname' => 'salons#find_by_name', :as => :salon_name

  # match '/salons/:salon_id/employees/:id' => 'salons#toggle_admin', :as => :toggle_admin


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
  # 

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
