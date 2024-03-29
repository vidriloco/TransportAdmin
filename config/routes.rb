TransportAdder::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.
  resources :transports do
    resources :lines
    resources :docking_stations
  end
    
  resources :visualizations, :only => [:index]  
  
  resources :docking_stations, :except => [:edit, :update, :show]
  resources :stations
  
  resources :ways, :only => [:destroy]
  
  resources :segments
  
  resources :lines do
    resources :stations
    resources :connections
    resources :segments
    resources :ways, :only => [:create]
  end
  
  resources :vehicles
  
  resources :connections
  
  post "/traversals/:line_id/generate_automatic" => "traversals#generate_automatic", :as => :traversal_generate_automatic
  delete "/traversals/:line_id/destroy_automatic" => "traversals#destroy_automatic", :as => :traversal_destroy_automatic
  
  resources :traversals
  
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
  root :to => 'transports#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
