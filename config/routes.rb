Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    root 'orderlist#top_page'
    # orderlistコントローラ
    get 'order/top' => 'orderlist#top_page'

    # 各メニューページ 
    get 'order/set_menu' => 'orderlist#set_menu'
    get 'order/alacarte_menu' => 'orderlist#alacarte'
    get 'order/noodle_menu' => 'orderlist#noodle'
    get 'order/rice_menu' => 'orderlist#rice'
    get 'order/dessert_menu' => 'orderlist#dessert'
    get 'order/drink_menu' => 'orderlist#drink'
    get 'order/recommend_menu' => 'orderlist#recommend'
    get 'order/search' => 'orderlist#search'

    # 注文確認ページ
    get 'order/pre_order/:id' => 'orderlist#pre_order'
    post 'order/pre_order/:id' => 'orderlist#post_order'
    get 'order/ordered/:id' => 'orderlist#ordered'

    get 'order/modal_test/:id' => 'orderlist#modal', as: 'order_indiv'
    post 'order/modal_order' => 'orderlist#order_create'
end
