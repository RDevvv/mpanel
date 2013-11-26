Gullak2::Application.routes.draw do

  get "accounts/create"

  mount RailsAdmin::Engine => '/g_admin', :as => 'rails_admin'

  devise_for :admin_users

  namespace :merchant do

    #devise_for :users ,:module => "devise" ,:controllers => {:registrations => "merchant/registrations"}
    get "/",:to=>"merchants#index",:as=>:merchants
    devise_for :users ,:module => "devise"
    #   # get "signup", :to => "devise/registrations#new",:as=>:merchant_signup
    #   # get "login" => "devise/sessions#new",:as=>:merchant_login
    
    # devise_scope :user do
    #   get "sign_in", :to => "devise/sessions#new"
    # end

    resources :accounts do
      member do
        get 'verified_account'
      end
      resources :account_brands 
      resources :brands
      resources :users  
    end

    resources :account_brands do
      resources :outlets
    end
  end  
  
    # root :to => "merchant/accounts#new"

    root :to => "merchant/accounts#home"
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
