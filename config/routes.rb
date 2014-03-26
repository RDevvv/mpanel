Gullak2::Application.routes.draw do


    resources :articles do
        resources :comments
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


    mount ResqueWeb::Engine, at: 'resque'

    namespace :merchant do
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
            resources :brands
        end
    end

    # MAIN APP ROUTES
    resources :home
    get 'outlet_listing' => 'home#outlet_listing'
    get 'abcdef12345' => 'home#outlet_listing'

    get 'ad_details/:id' => 'Merchant::ads#get_ad_details'
    match 'verify_mobile_number' => 'customers#verify_mobile_number'
    match 'check_verification_code' => 'customers#check_verification_code'
    match 'resend_verification_code' => 'customers#resend_verification_code'
    match 'update_vendor_id' => 'campaigns#update_vendor_id'
    match 'get_mobile_number/(:id)' => 'customers#get_mobile_number'
    get 'generate_campaign_copy' => 'campaigns#generate_campaign_copy'
    match 'get_campaign_details' => 'campaigns#get_campaign_details'
    match 'sms_share' => 'sms_sents#sms_share'

    get "deals/:medium/:source/:city/:location/:category/:promocode" => "home#share_listing"
    get "get_missed_call" => "missed_calls#get_missed_call"
    get "get_sms_text" => "missed_calls#get_sms_text"
    get "deals/:campaign/:medium/:city/:area/:category/:customer_id/:ad_id" => "ads#show"
    get "get_call_click/:id" => "call_button_selects#get_click"
    post "get_button_click" => "button_clicks#get_click"
    match "store_call_details" => "call_forwardings#store_call_details"
    get "get_call_forwarding" => "call_forwardings#get_customer_number"
    match "get_outlet_number" => "call_forwardings#return_outlet_number"
    match "set_outlet_number" => "call_forwardings#set_outlet_number"
    post "set_sms_data" => "sms_sents#set_sms_data"
    post "versions/:id/revert" => "versions#revert", :as => "revert_version"
    get "accounts/create"
    match "sms_chart" => "charts#sms_chart"
    match "chart_index" => "charts#chart_index"
    match "button_click_chart" => "charts#button_click_chart"
    match "outletview_offers_log" => "sms_sents#outletview_offers_log"
    match "outletview_call_log" => "call_forwardings#outletview_call_log"
    post 'create_ad_likes' => 'ad_likes#create'

    get 'location_from_ip' => 'customers#location_from_ip'
    get 'error_404' => 'error_messages#error_404'
    get 'no_results' => 'home#no_results'
    get 'location_not_found' => 'home#location_not_found'
    match 'auth/facebook/callback' => 'customers#facebook_data'
    root :to => "home#index", constraints: {subdomain: 'm'}
    root :to => "home#index", constraints: {subdomain: 'm.staging'}
    root :to => "merchant#index", constraints: {subdomain: 'admin'}
    root :to => "home#index", constraints: {domain: 'gullak.co'}
    root :to => redirect('/desktop-home.html')
    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)
    get '/:short_url' => 'campaigns#campaign_landing'#, constraints: {domain: 'gullak.co'}

    unless Rails.application.config.consider_all_requests_local
      match '*not_found', to: 'error_messages#error_404'
    end
end
