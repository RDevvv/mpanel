Gullak2::Application.routes.draw do
  match 'facebook_verification' => 'social_media#facebook_verification'

  get 'articles/:blog_url' => 'articles#show'
  get 'newsletters/:created_at' => 'newsletters#show'
  resources :articles do
    resources :article_comments
  end
  resources :customer_feedbacks
  resources :nested_comments
  resources :leads
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
  resources :pages
  resources :newsfeeds
  resources :customer_keywords

  namespace :merchant do
    resources :products do
      resources :product_comments
      resources :product_likes
    end

    #devise_for :users ,:module => "devise" ,:controllers => {:registrations => "merchant/registrations"}
    get "/",:to=>"merchants#index",:as=>:merchants

    match "add_user" => "users#add_user"
    devise_for :users ,:module => "devise"
    #   # get "signup", :to => "devise/registrations#new",:as=>:merchant_signup
    #   # get "login" => "devise/sessions#new",:as=>:merchant_login

    resources :users
    match 'select_outlet' => 'outlets#select_outlet'
    match "outletview_edit" => 'outlets#outletview_edit'
    match 'get_area' => 'outlets#get_area'
    match 'get_address' => 'outlets#get_address'
    match 'outlet_update/:id' => 'outlets#outlet_update'
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
            match "outlet_key"

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
      resources :brands do
        resources :facebook_posts
        resources :tweets
        resources :products
      end
    end
  end

  # MAIN APP ROUTES
  get 'outlet_listing' => 'home#outlet_listing'


  get 'ad_details/:id' => 'Merchant::ads#get_ad_details'
  match 'check_verification_code' => 'customers#check_verification_code'
  match 'resend_verification_code' => 'customers#resend_verification_code'
  match 'update_vendor_id' => 'campaigns#update_vendor_id'
  match 'get_mobile_number/(:id)' => 'customers#get_mobile_number'
  match 'get_profile' => 'customers#show'
  post  'notification_toggle' => 'customers#notification_toggle'
  get 'generate_campaign_copy' => 'campaigns#generate_campaign_copy'
  match 'get_campaign_details' => 'campaigns#get_campaign_details'
  match 'sms_share' => 'sms_sents#sms_share'

  get "get_missed_call" => "missed_calls#get_missed_call"
  get "get_sms_text" => "missed_calls#get_sms_text"
  get "deals/:campaign/:medium/:city/:area/:category/:customer_id/:ad_id" => "ads#show"
  get "get_call_click/:id" => "call_button_selects#get_click"
  match "get_button_click" => "button_clicks#get_click"
  match "store_call_details" => "call_forwardings#store_call_details"
  get "get_call_forwarding" => "call_forwardings#get_customer_number"
  match "get_outlet_number" => "call_forwardings#return_outlet_number"
  match "set_outlet_number" => "call_forwardings#set_outlet_number"
  match "set_sms_data" => "sms_sents#set_sms_data"
  match "sweepstakes_set_sms_data" => "sms_sents#sweepstakes_set_sms_data"
  match 'check_app_cookies' => 'home#check_app_cookies'
  post "versions/:id/revert" => "versions#revert", :as => "revert_version"
  get "accounts/create"
  match "outletview_offers_log" => "sms_sents#outletview_offers_log"
  match "outletview_call_log" => "call_forwardings#outletview_call_log"
  post 'create_ad_likes' => 'ad_likes#create'
  get 'individual_outlet' => 'merchant::outlets#show'
  get 'get_keywords' => 'merchant::keywords#get_keywords'
  get 'get_customer_keywords' => 'merchant::keywords#get_customer_keywords'

  get 'no_results' => 'home#no_results'
  get 'location_not_found' => 'home#location_not_found'

  get 'fetch_gcm_id' => 'native_notifications#fetch_gcm_id'
  post 'set_gcm_id' => 'native_notifications#set_gcm_id'
  match 'get_customer_coordinates' => 'native_notifications#get_customer_coordinates'
  get 'individual_product' => 'Merchant::products#show'
  get 'get_products_by_outlet' => 'Merchant::products#get_products_by_outlet'
  post 'save_comment' => 'Merchant::ProductComments#create'
  post 'save_like' => 'Merchant::ProductLikes#create'

  if Rails.env.development?
    root :to => "home#index"
  else
    root :to => "home#index", constraints: {subdomain: 'm'}
  end
  root :to => "home#index", constraints: {subdomain: 'm.staging'}
  root :to => "home#index", constraints: {subdomain: 'api'}
  root :to => "merchant#index", constraints: {subdomain: 'admin'}
  root :to => "home#index", constraints: {domain: 'gullak.co'}
  root :to => redirect('/home.html')

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  authenticate :admin_user do
    mount ResqueWeb::Engine, at: '/admin/resque'
    match "/admin/sms_chart" => "charts#sms_chart"
    match "/admin/chart_index" => "charts#chart_index"
    match "/admin/button_click_chart" => "charts#button_click_chart"
  end
  get '/:short_url' => 'campaigns#campaign_landing'#, constraints: {domain: 'gullak.co'}
  ResqueWeb::Engine.eager_load!
end
