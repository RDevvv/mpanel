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
    get 'outlet_search' => 'home#outlet_search'
    get 'map_search' => 'home#map_search'
    get 'hot_picks' => 'home#hot_picks'

    get 'ad_details/:id' => 'Merchant::ads#get_ad_details'
    match 'verify_mobile_number' => 'customers#verify_mobile_number'
    match 'check_verification_code' => 'customers#check_verification_code'
    match 'resend_verification_code' => 'customers#resend_verification_code'
    match 'update_vendor_id' => 'campaigns#update_vendor_id'
    match 'brand_listing/:brand_id' => 'home#brand_listing'
    match 'map_listing' => 'home#map_listing'
    match 'refered_listing/deals/:city/:area_name/:category_name/:refere_id' => 'home#refered_listing'
    match 'individual_outlet/(:id)' => 'home#individual_outlet'
    match 'get_mobile_number/(:id)' => 'customers#get_mobile_number'
    match 'deals/:id/:source/:city/:area/:category/:ad_promocode_outlet_id' => 'campaigns#facebook_share'
    get '/generate_campaign_copy' => 'campaigns#generate_campaign_copy'
    match 'get_campaign_details' => 'campaigns#get_campaign_details'
    match 'sms_share' => 'sms_sents#sms_share'

    get "admin_panel" => "home#admin_panel"
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

    get 'no_results' => 'home#no_results'
    match 'auth/facebook/callback' => 'customers#facebook_data'
    root :to => "home#index", constraints: {subdomain: 'm'||'m.staging'}
    root :to => redirect('/desktop-home.html')
    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)
    get '/:short_url' => 'campaigns#campaign_landing'
end
