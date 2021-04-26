require 'securerandom'
require 'json'
class VendorController < ApplicationController
    protect_from_forgery with: :null_session


    def index 
        response = {:status => "success" ,:code => 200}
        account_id = get_account_id params[:monday_account_id]
        vendor_obj = Vendor.where(:account_id => account_id).order("created_at")
        response[:data] = vendor_obj
        render :json => response
    end
    def create 
        response = {:status => "success" ,:code => 200}
        account_id = get_account_id params[:monday_account_id]
        vendor = Vendor.new
        vendor.name = params[:name]
        vendor.phone = params[:phone]
        vendor.account_id = account_id
        vendor.address = params[:address]
        vendor.rating = 0 
        vendor.save
        render :json => response
    end

    def edit 
        response = {:status => "success" ,:code => 200}
        vobj = Vendor.find_by(:account_id => params[:monday_account_id],:id => params[:vendor_id])
        unless vobj.nil?
            Vendor.where(:account_id => params[:monday_account_id],:id => params[:vendor_id]).update_all(:name => params[:name] ,:phone => params[:phone],:address => params[:address],:rating => params[:rating].to_i)
        end
        render :json => response
    end

    def destroy 
        response = {:status => "success" ,:code => 200}
        Vendor.where(:id => params[:vendor_id] , :account_id => params[:monday_account_id]).delete_all()
        render :json => response
    end
    def get_stocks
        response = {:status => "success", :code=> 200}
        account_id = get_account_id params[:monday_account_id]
        stock_obj = StockEntry.where(:account_id => account_id).order("updated_at")
        stock_res = {}
        stock_obj.each do |obj|
           ven_prd_obj =  VendorProductMapping.where(:stock_id => obj["stock_id"])
           product_list  = []
           ven_prd_obj.each do |prd|
             prod_name = Product.find_by(:id => prd.product_id).name
             cat_name = Category.find_by(:id => prd.category_id).category_display_name
             price  = prd.price 
             quantity = prd.quantity
             prd_hash = {"product_name" => prod_name , "category_name" => cat_name , "price" => price , "quantity" => quantity}
             product_list.push prd_hash
           end
           stock_res[obj["stock_id"]] = product_list
        end
        response["data"] = stock_obj
        response["individual_data"] = stock_res
        render :json => response
    end

    def create_stock 
        stock_id = SecureRandom.hex(12)
        response = {:status => "success", :code=> 200}
        account_id = get_account_id params[:monday_account_id]
        stock = StockEntry.new 
        stock.stock_id  = stock_id
        stock.payment_status = params[:payment_made]
        stock.account_id = account_id
        stock.total_price = params[:total_price]
        stock.vendor_id = params[:vendor_id]
        stock.save
        params[:cart_items].each do |obj|
            cat_id = Category.find_by(:category_name => obj["categoryId"]).id
            puts "dddddddddd"
            puts obj
            order_prod_map = VendorProductMapping.new
            order_prod_map.stock_id = stock_id
            order_prod_map.category_id = cat_id
            order_prod_map.product_id = obj["productId"]
            order_prod_map.price = obj["Price"]
            order_prod_map.quantity = obj["Quantity"]
            order_prod_map.save
            prod = Product.find_by(:id => obj["productId"],:category_id => cat_id)
            update_quantity = prod.quantity + obj["Quantity"].to_i
            Product.where(:id => obj["productId"] ,:category_id => cat_id).update_all(:quantity => update_quantity)
        end
        render :json => response
    end

    def edit_stock 
        response = {:status => "success", :code=> 200}
        account_id = get_account_id params[:monday_account_id]
        StockEntry.where(:stock_id => params[:stock_id] , :account_id => account_id).update_all(:payment_status => params[:payment_status],:vendor_id => params[:vendor_id],:total_price => params[:total_price])      
        render :json => response
    end

    def destroy_stock 
        response = {:status => "success", :code=> 200}
        account_id = get_account_id params[:monday_account_id]
        StockEntry.where(:stock_id => params[:stock_id],:account_id => account_id).destroy_all()
        VendorProductMapping.where(:stock_id => params[:stock_id]).destroy_all()
        render :json => response
    end
end
