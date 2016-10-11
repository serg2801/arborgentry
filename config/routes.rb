Rails.application.routes.draw do

  # This line mounts Spree's routes at the root of your application.
  # This means, any requests to URLs such as /products, will go to Spree::ProductsController.
  # If you would like to change where this engine is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Spree relies on it being the default of "spree"
  mount Spree::Core::Engine, at: '/admin_dashboard'
  # root to: "spree/admin/orders#index"
  devise_for :customers
  namespace :admin do
    resources :inquiries, :only => [:index, :destroy, :show]
    resources :companies
    resources :products
    resources :option_images
    resources :collections
  end

  # Spree::Core::Engine.routes.prepend do
  #   # root to: "spree/admin/orders#index"
  #   # get '/about', :to => 'about#index', :as => :about
  #   # get 'orders' => 'spree/admin/orders#index'
  #   root :to =>'home#index'
  # end

  # get '/orders' => 'spree/admin/orders#index'

  # root 'home#index'
  # get 'home/login'
  # get 'home/registration'
  get 'home/welcome'
  get 'thank_you'        => 'home#thank_you'
  get 'weather'         => 'home#weather_params',  as: 'weather'
  get 'map_city_visits' => 'home#map_city_visits', as: 'map_city_visits'
  devise_for :vendors, :controllers => {:confirmations => 'confirmations',  registrations: 'registrations'}
  devise_scope :vendor do
    patch '/confirm' => 'confirmations#confirm'
    authenticated :vendor do

      #Vendors form
      constraints DomainConstraint.new('vendorstest.arborgentry.com') do

        # root :to => 'vendors#profile', as: 'vendor_root'

        get  'trade-signup',       to: 'trade_forms#new'
        post 'trade-signup',       to: 'trade_forms#create'
        get  'vendor-signup',      to: 'vendor_forms#new'
        post 'vendor-signup',      to: 'vendor_forms#create'
        get 'trade_success',       to: 'static_page#trade'
        get 'vendor_success',      to: 'static_page#vendor'

      end

      root :to =>'home#index', as: :authenticated_root
    end

    unauthenticated :vendor do
      # root 'devise/sessions#new', as: :unauthenticated_root

      #Vendors form
      constraints DomainConstraint.new('vendorstest.arborgentry.com') do

        root :to => 'static_page#form_home'

        get  'trade-signup',       to: 'trade_forms#new'
        post 'trade-signup',       to: 'trade_forms#create'
        get  'vendor-signup',      to: 'vendor_forms#new'
        post 'vendor-signup',      to: 'vendor_forms#create'

        get 'trade_success',             to: 'static_page#trade'
        get 'vendor_success',            to: 'static_page#vendor'

        get 'about',                 to: 'static_page#about'
        get 'product_categories',    to: 'static_page#product_categories'

      end

      root :to =>'home#welcome', as: :unauthenticated_root
    end
  end
  resources :vendor_forms, only: [ :index, :show, :edit, :update ]
  resources :vendor_onboarding_forms, only: [ :index, :show, :edit, :update ]
  resources :trade_forms, only: [ :index, :show ]

  get 'vendor_form_success_update',      to: 'static_page#vendor_form_update'

  get 'upload-vendor-agreement-new',     to: 'vendors#upload_vendor_agreement_new'
  post 'upload-vendor-agreement-new',    to: 'vendors#upload_vendor_agreement_create'
  get 'upload_vendor_agreement_success', to: 'static_page#upload_vendor_agreement_success'

  get  'vendor-onboarding',  to: 'vendor_onboarding_forms#new'
  post 'vendor-onboarding',  to: 'vendor_onboarding_forms#create'

  get 'vendor_onboarding_success', to: 'static_page#on_boarding'
  get 'vendor_onboarding_success_update',  to: 'static_page#on_boarding_update'


  resources :vendors,  only: [:destroy, :edit, :update, :show, :index ]
  resources :accounts, only: [:index, :new, :create ]

  get 'grant-access/:id',  to: 'vendor_forms#grant_access', as: 'grant_access'

  get  'new_vendor',                            to: 'vendors#new_vendor'
  post 'new_vendor',                            to: 'vendors#create_vendor'
  get  'vendors/:id/logged_in_as_other_vendor', to: 'vendors#logged_in_as_vendor', as: :logged_in_as_other_vendor
  get  'back_login_by_admin',                   to: 'vendors#back_login_by_admin', as: :back_login_by_admin
  get  'convert_temperature',                   to: 'vendors#convert_temperature', as: :convert_temperature

  resources :product_types
  namespace :admin do
    resources :categories
    resources :channels
    resources :variants
  end

  resources :messages, only: [ :create, :new ]
  resources :config_emails, only: [:new, :create, :edit, :update, :show ]
  
  resources :roles , only: [:new, :create, :show, :index, :destroy, :edit, :update ]

  resources :permissions, only: [:index]
  post 'save_permissions',       to: 'permissions#save'


  get '/decryption_password' => 'config_emails#decryption_password'
  get '/test_connection' => 'config_emails#test_connection'

  put 'move_to_trash',      to: 'messages#move_to_trash'
  put 'edit_starred',       to: 'messages#edit_starred'
  put 'edit_important',     to: 'messages#edit_important'
  get 'starred',            to: 'messages#starred'
  get 'important',          to: 'messages#important'
  delete 'destroy_emails',  to: 'messages#destroy_emails'
  get 'read_emails',        to: 'messages#read_emails'
  get 'inbox',              to: 'messages#inbox'
  get 'refresh_inbox',      to: 'messages#refresh_inbox'
  get 'trash',              to: 'messages#trash'
  get 'write_emails',       to: 'messages#write_emails'
  get 'show_message_read',  to: 'messages#show_message_read'
  get 'show_message_write', to: 'messages#show_message_write'
  post 'message_reply_to',  to: 'messages#message_reply_to'


  #Charts
  get 'flot_charts',     to: 'static_page#flot_charts'
  get 'morris_charts',   to: 'static_page#morris_charts'
  get 'chart_js',        to: 'static_page#chart_js'
  get 'other_charts',    to: 'static_page#other_charts'

  #Forms
  get 'basic_forms',     to: 'static_page#basic_forms'
  get 'advanced_forms',  to: 'static_page#advanced_forms'
  get 'form_layouts',    to: 'static_page#form_layouts'
  get 'form_wizard',     to: 'static_page#form_wizard'
  get 'form_validation', to: 'static_page#form_validation'
  get 'code_editor',     to: 'static_page#code_editor'

  #Tables
  get 'basic_tables',    to: 'static_page#basic_tables'
  get 'data_tables',     to: 'static_page#data_tables'
  get 'editable_tables', to: 'static_page#editable_tables'
  get 'ajax_tables',     to: 'static_page#ajax_tables'
  get 'pricing_tables',  to: 'static_page#pricing_tables'

  #Ui Elements
  get 'icons',         to: 'static_page#icons'
  get 'typography',    to: 'static_page#typography'
  get 'tabs',          to: 'static_page#tabs'
  get 'accordions',    to: 'static_page#accordions'
  get 'buttons',       to: 'static_page#buttons'
  get 'notifications', to: 'static_page#notifications'
  get 'modals',        to: 'static_page#modals'
  get 'sliders',       to: 'static_page#sliders'
  get 'progressbar',   to: 'static_page#progressbar'
  get 'lists',         to: 'static_page#lists'
  get 'grid',          to: 'static_page#grid'
  get 'other',         to: 'static_page#other'


  get 'portlets',      to: 'static_page#portlets'

  #Maps
  get 'google_maps',      to: 'static_page#google_maps'
  get 'vector_maps',      to: 'static_page#vector_maps'

  #Pages
  get 'login',         to: 'static_page#login'
  get 'lock_screen',   to: 'static_page#lock_screen'
  get 'register',      to: 'static_page#register'
  get 'lost_password', to: 'static_page#lost_password'
  get 'user_profile',  to: 'static_page#user_profile'
  get 'calendar',      to: 'static_page#calendar'
  get 'time_line',     to: 'static_page#time_line'
  get 'gallery',       to: 'static_page#gallery'
  get 'invoice',       to: 'static_page#invoice'
  get 'blank_page',    to: 'static_page#blank_page'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
