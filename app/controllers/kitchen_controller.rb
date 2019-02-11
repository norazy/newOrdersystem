class KitchenController < ApplicationController
    before_action :check_notification, except: :notification
    after_action :clear_flash


    def table_kitchen
        # check_notification
        
        # binding.pry
    end
    
    def ordered_kitchen
    end
    
    def served
    end
    
    def order_change
    end
    
    def update_order
    end
    
    def notification
        @notification = Notification.all
        
        @time = []
        @notification.each do |noti|
            @time << noti.created_at.strftime("%H:%M")
        end
    end
    
    def destroy
        Notification.find(params[:id]).destroy
        redirect_back(fallback_location: root_path)

        # @notification = Notification.all
        # @time = []
        # @notification.each do |noti|
        #     @time << noti.created_at.strftime("%H:%M")
        # end
    end

private    
    def clear_flash
        flash[:alert] = nil
    end
    def check_notification

        # if Notification.exists?(:id => 1)
        if Notification.exists?
            flash[:alert] = "通知"
        end
    end
end
