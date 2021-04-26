class ReportController < ApplicationController
    def index 
        response = {:status => "success" ,:code => 200}
        account_id = params[:monday_account_id]
        puts params[:report]
        puts params[:report] == "category_split_current_month"
        if params[:report] == "category_split_current_month"
            report_obj = OrderProductMapping.select("categories.category_display_name ,count(order_product_mappings.category_id) as value").joins("inner join categories on order_product_mappings.category_id = categories.id").where("categories.account_id = ?",account_id).group("categories.id")
            response[:data] = report_obj
        end
        puts response
        render :json => response
    end
end
