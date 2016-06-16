Rails.application.routes.draw do

  devise_for :customers
  namespace :admin do
    resources :inquiries, :only => [:index, :destroy, :show]
    resources :companies
    resources :products
    resources :option_images
    resources :collections
  end

  # root 'home#index'
  # get 'home/login'
  # get 'home/registration'
  get 'home/welcome'
  get 'thank_you' => 'home#thank_you'
  devise_for :vendors, :controllers => {:confirmations => 'confirmations',  registrations: "registrations"}
  devise_scope :vendor do
    patch "/confirm" => "confirmations#confirm"
    authenticated :vendor do
      root :to =>'home#index', as: :authenticated_root
    end

    unauthenticated :vendor do
      # root 'devise/sessions#new', as: :unauthenticated_root
      root :to =>'home#welcome', as: :unauthenticated_root
    end
  end

  resources :vendors, only: [:destroy, :edit, :update, :show, :index ]
  get 'new_vendor',  to: 'vendors#new_vendor'
  post 'new_vendor', to: 'vendors#create_vendor'
  resources :product_types
  namespace :admin do
    resources :categories
    resources :channels
    resources :variants
  end

  resources :messages, only: [ :create, :new ]
  resources :config_emails, only: [:new, :create, :edit, :update, :show ]
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
