class OrderlistController < ApplicationController
    # ↓サインインしているかどうかの確認
    # before_action :move_to_signin 
    
    def top_page
    end

    def set_menu
        @menus1 = Menu.where(category: 11)
        @menus2 = Menu.where(category: 12)
        @menus3 = Menu.where(category: 13)
    end

    def alacarte
        @menus1 = Menu.where(category: 21)
        @menus2 = Menu.where(category: 22)
        @menus3 = Menu.where(category: 23)
    end

    def noodle
        @menus1 = Menu.where(category: 31)
    end
    
    def rice
        @menus1 = Menu.where(category: 41)
        # @user = current_user.orderlists
        # アソシエーションができるかどうか試してみた：できた
    end
    
    def dessert
        @menus1 = Menu.where(category: 51)
        @menus2 = Menu.where(category: 52)
    end
    
    def drink
        @menus1 = Menu.where(category: 61)
        @menus2 = Menu.where(category: 62)
    end
    
    # 検索ページ
    def search
        @menus1 = Menu.where('name LIKE(?)', "%#{params[:keyword]}%").limit(20)
    end
    
    def recommend
        # レコメンドカテゴリーごと取り出す
        category_reco1 = Recommend.where(category_reco: 1)
        category_reco2 = Recommend.where(category_reco: 2)
        category_reco3 = Recommend.where(category_reco: 3)
        
        # 空の配列を用意
        @menus1 = []
        @menus2 = []
        @menus3 = []
        
        # カテゴリーごとのmenu_idから料理名等を取り出す
        category_reco1.each do |reco|
            @menus1 << Menu.find(reco[:menu_id])
        end
        category_reco2.each do |reco|
            @menus2 << Menu.find(reco[:menu_id])
        end
        category_reco3.each do |reco|
            @menus3 << Menu.find(reco[:menu_id])
        end
    end
    
    # モーダル部分
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

    # 「カートへ」のcreate
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

            Orderlist.create(user_id: current_user.id, menu_id: orderlist_params[:menu_id], price: menu_price, number: orderlist_params[:number], state: "0")
            Orderlist.create(user_id: current_user.id, menu_id: orderlist_params[:menu_id], option_id: orderlist_params[:option_id], price: option_price, number: orderlist_params[:number], state: "0")
        else
            Orderlist.create(user_id: current_user.id, menu_id: orderlist_params[:menu_id], price: menu_price, number: orderlist_params[:number], state: "0")
        end
        
        # createのあとは新しいビューに飛ばずに、backするように設定する
        redirect_back(fallback_location: root_path)
        # flash.now[:notice] = "カートにいれました！"
    end


    private
    def orderlist_params
        params.require(:orderlist).permit(:number, :option_id, :menu_id)
    end

    # サインインしてなかったらアクセスできないようにする
    def move_to_signin
        redirect_to new_user_session_url unless user_signed_in?
    end

end
