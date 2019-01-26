Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    root 'orderlist#top_page'
    # orderlistコントローラ
    get 'order/top' => 'orderlist#top_page'
    
    get 'order/set_menu' => 'orderlist#set_menu'
    
    
    get 'order/modal_test/:id' => 'orderlist#modal', as: 'order_indiv'
    post 'order/modal_order' => 'orderlist#order_create'


end
