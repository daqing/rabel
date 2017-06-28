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
  get 't/:id' => 'topics#show', :as => :t
  get 'topics/:id' => redirect('/t/%{id}'), :constraints => { :id => /\d+/ }

  get 'my/topics' => 'users#my_topics', :as => :my_topics
  get 'my/following' => 'users#my_following', :as => :my_following
  get 'page/:key' => 'pages#show', :as => :page
  get 'goodbye' => 'welcome#goodbye'
  get 'captcha' => 'welcome#captcha'
  get 'sitemap' => 'welcome#sitemap'

  patch 'upyun_images' => 'upyun_images#create'

  resources :channels do
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
    resources :nav_links do
      post :sort, :on => :collection
    end

    resources :planes do
      resources :nodes
      post :sort, :on => :collection
      get :sort, :on => :collection
    end

    resources :channels do
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
end
