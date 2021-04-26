class CategoryController < ApplicationController
    protect_from_forgery with: :null_session


    def index
        response = {:status => "success" ,:code => 200}
        #account_id = get_account_id params[:monday_account_id]
        cat_hash = {}
        cat_id_hash = {}
        cat_obj = Category.where(:account_id => params[:monday_account_id])
        cat_obj.each do |obj|
            cat_hash[obj.category_name] = obj.category_display_name
            cat_id_hash[obj.category_name] = obj.id 
        end

        response[:data] = cat_hash
        response[:cat_id_data] = cat_id_hash
        render :json => response
    end

    def create
        response = {:status => "success" ,:code => 200}
        category = Category.new
        location_ids = [params[:location_id]]
        category.account_id = params[:monday_account_id]
        category.category_name = params[:name]
        category.category_display_name = params[:display_name]
        category.locations = location_ids
        category.save
        # respond_to do |format|
        #     format.json  { render :json => response } # don't do msg.to_json
        # end
        render :json => response
    end

    def edit
        response = {:status => "success" ,:code => 200}
        Product.where(:category_id => params[:category_id] , :id => params[:product_id]).update_all(:quantity => params[:quantity],:price => params[:price])
        render :json => response
    end


    def get_product
        response = {:status => "success" , :code => 200}
        cat_id = Category.find_by(:category_name => params[:category_id],:account_id => params[:monday_account_id])
        unless cat_id.nil?
            prod_obj = Product.where(:category_id => cat_id.id)
        end
        response[:data] =  prod_obj
        render :json => response
    end

    def add_product
        response = {:status => "success" , :code => 200}
        cat_id = Category.find_by(:category_name => params[:category_id],:account_id => params[:monday_account_id])
        unless cat_id.nil?
            product = Product.new
            product.category_id = cat_id.id
            product.location_id = params[:location_id]
            product.price = params[:price]
            product.quantity = params[:quantity]
            product.name = params[:name]
            product.save
        end
        render :json => response
    end

    def update_product_quantity
        response = {:status => "success"}
        Product.where(:id => params[:product_id]).update_all(:quantity => params[:quantity])
        respond_to do |format|
            format.json { render json: response }
        end
    end

    def destroy 
        response = {:status => "success" , :code => 200}
        Product.where(:id => params[:product_id] , :category_id => params[:category_id]).destroy_all
        render :json => response
    end
end
