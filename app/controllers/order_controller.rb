require 'securerandom'
require 'json'
include CustomerHelper
class OrderController < ApplicationController

    def index 
        response = {:status => "success" ,:code => 200}
        order_obj = Order.where(:account_id => params[:monday_account_id]).order("created_at desc")
        prod_list = {}
        cust_ids = order_obj.pluck(:customer_id)
        cust_obj = Customer.where(:id => cust_ids)
        if order_obj.length > 0 
            order_obj.each do |obj|
                prod_items = OrderProductMapping.where(:order_id => obj.order_id)
                temp_prod = []
                prod_items.each do |prd|
                    prod_name = Product.find_by(:id => prd.product_id).name
                    cat_name = Category.find_by(:id => prd.category_id).category_display_name
                    prd = JSON.parse(prd.to_json)
                    prd["cat_name"] = cat_name
                    prd["prod_name"] = prod_name
                    temp_prod.push prd
                end
                prod_list[obj.order_id] = temp_prod
            end
        end
        response[:data] = order_obj
        response[:prod_items] = prod_list
        response[:cust_obj] = cust_obj
        render :json => response
    end
    def create 
        response = {:status => "success" ,:code => 200}
        user_details = params[:user_details]
        puts user_details.class
        order_id = SecureRandom.alphanumeric(10)
        cust_id = add_customer params[:user_details] , params[:monday_account_id]
        order = Order.new
        order.account_id = params[:monday_account_id]
        order.order_id = order_id
        order.total_price = params[:total_price]
        order.status = Order::Status::PLACED
        order.customer_id = cust_id
        order.payment_done = params[:payment_done] 
        delivery_obj = Deliveryagent.order(:total_orders).limit(1)[0]
        d_id = delivery_obj.id
        total_orders = delivery_obj.total_orders + 1
        Deliveryagent.where(:id => d_id).update_all(:total_orders => total_orders)
        order.delivery_person_id = d_id
        order.order_date = params[:user_details]["date-picker"]
        order.save
        #check if customer add is already there or not 
        #entry in order_category_mappings
        params[:cart_items].each do |obj|
            puts obj
            cat_id = Category.find_by(:category_name => obj["categoryId"]).id
            order_prod_map = OrderProductMapping.new
            order_prod_map.order_id = order_id
            order_prod_map.category_id = cat_id
            order_prod_map.product_id = obj["productId"]
            order_prod_map.price = obj["Price"]
            order_prod_map.quantity = obj["Quantity"]
            order_prod_map.save
            prod = Product.find_by(:id => obj["productId"],:category_id => cat_id)
            update_quantity = prod.quantity - obj["Quantity"]
            Product.where(:id => obj["productId"] ,:category_id => cat_id).update_all(:quantity => update_quantity)
        end
        render :json => response
    end
    def edit
        response = {:status => "success" ,:code => 200}
        Order.where(:order_id => params[:order_id],:account_id => params[:monday_account_id]).update_all(:total_price => params[:total_price] , :payment_done => params[:payment_done] , :status => params[:status],:delivery_person_id => params[:delivery_person_id])
        render :json => response
    end

    def destroy
        response = {:status => "success" ,:code => 200}
        Order.where(:order_id => params[:order_id] , :account_id => params[:monday_account_id]).destroy_all
        OrderProductMapping.where(:order_id => params[:order_id]).destroy_all
        render :json => response
    end
end
