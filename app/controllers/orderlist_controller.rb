class OrderlistController < ApplicationController
    def top_page
    end

    def set_menu
        @menus1 = Menu.where(category: 11)
        @menus2 = Menu.where(category: 12)
        @menus3 = Menu.where(category: 13)
    end
    
    def modal
        # パラムズのidにあったメニューを取り出す
        @menu = Menu.find(params[:id])
        @orderlist = Orderlist.new
        # 各オプションの中にものがあるかどうか
        # あったら変数に渡す
        if @menu.option1 then
            number = @menu.option1
            @option1 = Optiontable.find(number)
            @option_name1 = @option1.name_opt
        end
        if @menu.option2 then
            number = @menu.option2
            @option2 = Optiontable.find(number)
            @option_name2 = @option2.name_opt

        end
        if @menu.option3 then
            number = @menu.option3
            @option3 = Optiontable.find(number)
            @option_name3 = @option3.name_opt
        end
        
        respond_to do |format|
            format.html
            format.js
        end
    end
    
    def order_create
        # binding.pry
        # メニュー価格の呼び出し
        menu = Menu.find(orderlist_params[:menu_id])
        menu_price = menu.price

        # まだフォームを作ってない、とりあえずどんなパラムズになるかなって書いてみた。190117

        if orderlist_params[:option_id] then
            # オプション価格の呼び出し
            option = Optiontable.find(orderlist_params[:option_id])
            option_price = option.price_opt

            Orderlist.create(menu_id: orderlist_params[:menu_id], price: menu_price, number: orderlist_params[:number], state: "0")
            Orderlist.create(option_id: orderlist_params[:option_id], price: option_price, number: orderlist_params[:number], state: "0")

            # Orderlist.save(user_id: current_user.id, menu_id: params[:id], price: menu_price, number: orderlist_params[:number], state: 0)
            # Orderlist.save(user_id: current_user.id, option_id: orderlist_params[:option], price: option_price, number: orderlist_params[:number], state: 0)
        else

            # Orderlist.save(user_id: current_user.id, menu_id: params[:id], price: orderlist_params[:price], number: orderlist_params[:number], status: 0)
            Orderlist.create(menu_id: orderlist_params[:menu_id], price: menu_price, number: orderlist_params[:number], state: "0")
        end
        
        # createのあとは新しいビューに飛ばずに、backするように設定する
        redirect_back(fallback_location: root_path)
        # flash.now[:notice] = "カートにいれました！"
    end

    private
    def orderlist_params
        params.require(:orderlist).permit(:number, :option_id, :menu_id)
    end


end
