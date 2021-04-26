class CustomerController < ApplicationController
    protect_from_forgery with: :null_session

    def index
        response = {:status => "success" ,:code => 200}
        customer_obj = Customer.where(:account_id => params[:monday_account_id])
        response[:data] = customer_obj
        render :json => response
    end

end