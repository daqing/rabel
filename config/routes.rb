Rabel::Application.routes.draw do
  root 'welcome#index'
  devise_for :users, :controllers => {:sessions => "sessions", :registrations => "registrations"}
  get 'settings' => 'users#edit'
  get 'member/:nickname' => 'users#show', :as => :member
  get 'member/:nickname/topics' => 'users#topics', :as => :member_topics
  post 'member/:nickname/follow' => 'users#follow', :as => :follow_user
  post 'member/:nickname/unfollow' => 'users#unfollow', :as => :unfollow_user
  patch 'users/update_account' => 'users#update_account', :as => :update_account
  patch 'users/update_password' => 'users#update_password', :as => :update_password
  patch 'users/update_avatar' => 'users#update_avatar', :as => :update_avatar
  get 'go/:key' => 'nodes#show', :as => :go
  get 't/:id' => 'topics#show', :as => :t
  get '/topics/:id' => redirect('/t/%{id}'), :constraints => { :id => /\d+/ }

  get 'my/topics' => 'users#my_topics', :as => :my_topics
  get 'my/following' => 'users#my_following', :as => :my_following
  get 'page/:key' => 'pages#show', :as => :page
  get 'goodbye' => 'welcome#goodbye'
  get 'captcha' => 'welcome#captcha'
  get 'sitemap' => 'welcome#sitemap'

  resources :nodes do
    resources :topics do
      member do
        get :move
        get :edit_title
        patch :update_title
      end
    end
  end
  resources :topics do
    resources :comments
    resources :bookmarks
    post :preview, :on => :collection
    patch :toggle_comments_closed
    patch :toggle_sticky
    get :new_from_home, :on => :collection
    post :create_from_home, :on => :collection
  end

  resources :comments, :bookmarks, :upyun_images, :qiniu_images

  resources :notifications do
    get :read, :on => :member
  end

  namespace :admin do
    resources :planes do
      resources :nodes
      post :sort, :on => :collection
      get :sort, :on => :collection
    end

    resources :nodes do
      post :sort, :on => :collection
      get :move, :on => :member
      patch :move_to, :on => :member
    end

    resources :users do
      member do
        patch :toggle_admin
        patch :toggle_blocked
      end
      resources :rewards
    end

    resources :pages do
      post :sort, :on => :collection
    end

    resource :site_settings
    resources :topics, :advertisements, :cloud_files, :rewards

    resources :notifications do
      delete :clear, :on => :collection
    end

    get 'appearance' => 'site_settings#appearance'

    root 'welcome_admin#index'
  end
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
  # match ':controller(/:action(/:id(.:format)))'
end
