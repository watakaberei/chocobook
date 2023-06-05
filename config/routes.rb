Rails.application.routes.draw do

# 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

  scope module: :public do

    root to: 'homes#top'
    get '/about' => 'homes#about'

    get '/customers/my_page' => 'customers#show'
    get '/customers/information/edit' => 'customers#edit'
    patch '/customers/information/edit' => 'customers#update'
    get '/customers/unsubscribe' => 'customers#unsubscribe'
    patch '/customers/withdraw' => 'customers#withdraw'

    resources :customers do
      member do
        get :recipe_bookmarks
      end
    end

    resources :recipes, only: [:new, :index, :create, :show, :edit, :update, :destroy] do
      resources :recipe_comments, only: [:create, :destroy]
      resource :recipe_bookmarks, only: [:create, :destroy]
      get :recipe_bookmarks
    end
    get '/draft' => 'recipes#draft'
    get '/rank' => 'recipes#rank'
    get '/search' => 'recipes#search'


    resources :categories, only: [:show]
  end

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  namespace :admin do
    root to: 'homes#top'
    resources :customers, only: [:show, :edit, :update]
    
    resources :recipes

    resources :categories

    resources :recipe_comments, only: [:index, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
