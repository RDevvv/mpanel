Gullak2::Application.routes.draw do

  resources :campaigns


  resources :incentives


  resources :sms_sents
  resources :ads
  resources :call_forwardings
  resources :customer_sessions
  resources :button_clicks
  resources :address_button_selects
  resources :call_button_selects
  resources :customers

  get "deals/:campaign/:medium/:city/:area/:category/:customer_id/:ad_id" => "ads#show"
  get "get_call_click/:id" => "call_button_selects#get_click"
  post "get_button_click" => "button_clicks#get_click"
  get "get_call_forwarding" => "call_forwardings#get_customer_number"
  get "set_call_forwarding" => "call_forwardings#return_outlet_number"
  post "set_sms_data" => "sms_sents#set_sms_data"

  post "versions/:id/revert" => "versions#revert", :as => "revert_version"
  get "accounts/create"

  #match '/:id' => "shortener/shortened_urls#show"

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
      collection do
        post "add_brands"
        get 'populate_areas'
      end
      member do
        get 'verified_account'
      end
      resources :account_brands do
        collection do
          post "add_brands"
        end
        resources :outlets do
          collection do
            get 'upload_outlets'
            get 'download_outlet_template'
            post 'import'
            post 'import_record'
            get 'populate_areas'
          end
          member do
            post 'toggle_active'
            post 'toggle_verify'
            post 'toggle_active_index'
          end
        end
        resources :keywords
        resources :ads do
          member do
            post 'toggle_active'
            post 'toggle_exclusive'
          end
          resources :ad_promocodes do
            collection do
              post 'add_single_code'
              post 'add_multiple_code'
            end
          end
          resources  :ad_groups,:only=>[:show,:destroy] do
            member do
              post 'toggle_active'
              get 'delete_outlet'
              get 'more_promocodes'
              get 'more_outlets'
              post 'add_more_promocodes'
              post 'add_more_outlets'
              get 'add_all_outlets'
            end  
          end
        end
      end
      resources :brands
      resources :users
    end

  end  


  # MAIN APP ROUTES
    resources :home
    match 'outlet_listing' => 'home#outlet_listing'
    match 'outlet_search' => 'home#outlet_search'
    match 'verify_mobile_number' => 'customers#verify_mobile_number'
    match 'check_verification_code' => 'customers#check_verification_code'
    match 'hot_picks' => 'home#hot_picks'
    match 'brand_listing/:brand_id' => 'home#brand_listing'
    match 'map_listing' => 'home#map_listing'
    match 'refered_listing/deals/:city/:area_name/:category_name/:refere_id' => 'home#refered_listing'
    match 'individual_outlet/(:id)' => 'home#individual_outlet'

    root :to => "home#index"
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
