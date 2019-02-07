class OrderlistController < ApplicationController
    # ↓サインインしているかどうかの確認
    # before_action :move_to_signin 
    # def test
    #     render json: Orderlist.where(user_id: current_user.id)
    # end

    def top_page
    end

    def set_menu
        @menus1 = Menu.where(category: 11)
        @menus2 = Menu.where(category: 12)
        @menus3 = Menu.where(category: 13)
        # binding.pry
    end

    def alacarte
        @menus1 = Menu.where(category: 21)
        @menus2 = Menu.where(category: 22)
        @menus3 = Menu.where(category: 23)
        # binding.pry
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
    
    # おすすめ商品
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
    # モーダル「カートへ」のcreate
    def order_create
        # メニュー価格の呼び出し
        menu = Menu.find(orderlist_params[:menu_id])
        menu_price = menu.price

        # まだフォームを作ってない、とりあえずどんなパラムズになるかなって書いてみた。190117

        if orderlist_params[:option_id] then
            # オプション価格の呼び出し
            option = Optiontable.find(orderlist_params[:option_id])
            option_price = option.price_opt

            Orderlist.create(user_id: current_user.id, menu_id: orderlist_params[:menu_id], price: menu_price, number: orderlist_params[:number], state: "0")
            # ↓ここでオプションにメニューidを持たせたないのは
            # 未確定のところで、メニューidを持ってるかどうかで条件分岐させているから
            # （オプションidで条件分岐させてもよかったんだけど。。）
            Orderlist.create(user_id: current_user.id, option_id: orderlist_params[:option_id], price: option_price, number: orderlist_params[:number], state: "0")
        else
            Orderlist.create(user_id: current_user.id, menu_id: orderlist_params[:menu_id], price: menu_price, number: orderlist_params[:number], state: "0")
        end
        
        # createのあとは新しいビューに飛ばずに、backするように設定する
        # かつ、「カートに入れた」っていうメッセージを出す
        redirect_back(fallback_location: root_path)
        # flash[:notice] = "カートにいれました！"
    end

    # 未確定注文のページ
    def pre_order
        # 現在ログインしているユーザーの状態が０のオーダーを引き出す
        preorder = Orderlist.where(user_id: params[:id]).where(state: 0)
        
        # ビューに渡す配列作成
        @preorder = []
        
        # 取り出したオーダーに対して、一つずつハッシュを作る
        # {:order_id, :number, :state, :menu_name, :option_name}　←キー
        # orderlistのテーブルにmenu_idはあるけど、
        # メニュー名のカラムがないからハッシュを作ってる
        preorder.each do |order|
            hash = {}
            hash[:order_id] = order.id
            hash[:number] = order.number
            hash[:state] = 1
            # viewに表示させるために必要↓
            if order.menu_id then
                number = order.menu_id
                menu = Menu.find(number)
                name = menu.name
                hash[:menu_name] = name
            else
                number2 = order.option_id
                option = Optiontable.find(number2)
                name2 = option.name_opt
                hash[:option_name] = name2
            end
            @preorder << hash
        end
        @orderlist = Orderlist.new
    end
    
    # 未確定のものを確定にする部分
    def post_order
        # paramsの配列を変数へ
        preorderlist = params[:orderlist]
        
        # 配列をeach文にかける
        preorderlist.each do |pre|
            
            # ↓オーダーのidを取り出す
            number = pre[":id"]
            # ↓文字列になっているため、数字にする
            number = number.to_i
            # ↓該当するidのオーダーレコードをだす
            orderlist = Orderlist.find(number)

            # ↓useridの確認
            if orderlist.user_id = current_user.id then
                # 個数の書き換え
                orderlist.number = pre[":number"]
                # 状態の書き換え
                orderlist.state = pre[":state"]
                # 上書き保存
                orderlist.save
            end
        end

        # 自分が最初に作ったパラムズに対してのコード
        # 取り出したparamsは{"id"=>["17", "18"....], "number"=>[], "state"=>[]}
        # # paramsがidごとに配列になっているので、それぞれをパラムズから取り出す
        # id = params[:orderlist][:id]
        # number = params[:orderlist][:number]
        # state = params[:orderlist][:state]
        
        # # 入っている個数を数える
        # length = id.length
       
        # # while文で一つずつ取り出して保存する
        # i = 0
        # while i <= length-1 do 
        #     order_id = id[i]
        #     order_number = number[i]
        #     order_state = state[i]
            
        #     orderlist = Orderlist.find(order_id)

        #     if orderlist.user_id = current_user.id then
        #         orderlist.number = order_number
        #         orderlist.state = order_state
        #         orderlist.save
        #     end
        # i = i + 1

        # end
        redirect_to root_path
    end

    # 注文済画面
    def ordered
        # 現在ログインしているユーザーの状態が０のオーダーを引き出す
        ordered = Orderlist.where(user_id: params[:id]).where(state: 1..3).order('state ASC')
        # binding.pry
        # ビューに渡す配列作成
        @ordered = []
        
        # 取り出したオーダーに対して、一つずつハッシュを作る
        # {:order_id, :number, :state, :menu_name, :option_name}
        ordered.each do |order|
            hash = {}
            hash[:number] = order.number
            hash[:price] = order.price
            if order.menu_id then
                number = order.menu_id
                menu = Menu.find(number)
                name = menu.name
                hash[:menu_name] = name
            else
                number2 = order.option_id
                option = Optiontable.find(number2)
                name2 = option.name_opt
                hash[:option_name] = name2
            end
            
            if order.state == 1 then
                hash[:state] = "注文済"
            elsif order.state == 2 then
                hash[:state] = "調理中"
            else
                hash[:state] = "届済み"
            end    
            
            @ordered << hash
        end

    end

    private
    def orderlist_params
        params.require(:orderlist).permit(:number, :option_id, :menu_id)
    end

    # サインインしてなかったらアクセスできないようにする
    def move_to_signin
        redirect_to new_user_session_url unless user_signed_in?
    end

    # def post_order_params
    #     # params.require(:orderlist).permit
    #     params.require(:orderlist).map{|o| o.permit([:order_id, :number, :state]) }
    # end


end
