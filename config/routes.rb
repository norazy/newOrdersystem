Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    root 'orderlist#first'
    
    # get 'api/test' => 'orderlist#test'
    get 'firstpage' => 'orderlist#first'

    # 各メニューページ 
    get 'order/top' => 'orderlist#top_page'
    get 'order/set_menu' => 'orderlist#set_menu'
    get 'order/alacarte_menu' => 'orderlist#alacarte'
    get 'order/noodle_menu' => 'orderlist#noodle'
    get 'order/rice_menu' => 'orderlist#rice'
    get 'order/dessert_menu' => 'orderlist#dessert'
    get 'order/drink_menu' => 'orderlist#drink'
    get 'order/recommend_menu' => 'orderlist#recommend'
    get 'order/search' => 'orderlist#search'
    post 'order/cashier' => 'orderlist#call_cashier'
    post 'order/staff' => 'orderlist#call_staff'

    # 注文確認ページ
    get 'order/pre_order/:id' => 'orderlist#pre_order'
    post 'order/pre_order' => 'orderlist#post_order'
    get 'order/ordered/:id' => 'orderlist#ordered'

    get 'order/modal/:id' => 'orderlist#modal', as: 'order_indiv'
    post 'order/modal_order' => 'orderlist#order_create'
    
    # キッチン側のページ
    get 'kitchen/table' => 'kitchen#table_kitchen'
    get 'kitchen/ordered' => 'kitchen#ordered_kitchen'
    get 'kitchen/served' => 'kitchen#served'
    get 'kitchen/order_change' => 'kitchen#order_change'
    post 'kitchen/order_change' => 'kitchen#update_order'
    get 'kitchen/notification' => 'kitchen#notification'
    delete 'kitchen/notification/:id' => 'kitchen#destroy', as: 'notification_destroy'
    
end
