class DeliveryController < ApplicationController
    protect_from_forgery with: :null_session
    def index 
        response = {:status => "success" ,:code => 200}
        account_id = get_account_id params[:monday_account_id]
        delivery_obj = DeliveryAgency.where(:account_id => account_id)
        response[:data] = delivery_obj
        render :json => response
    end
    def create
        response = {:status => "success" ,:code => 200}
        account_id = get_account_id params[:monday_account_id]
        deliveryagency = DeliveryAgency.new
        deliveryagency.agency_name = params[:name]
        deliveryagency.account_id = account_id
        deliveryagency.address = params[:address]
        deliveryagency.phone = params[:phone]
        deliveryagency.location =  params[:location]
        deliveryagency.is_active = true
        deliveryagency.rating = 0 
        deliveryagency.save
        render :json => response
    end


    def create_agent
        response = {:status => "success" ,:code => 200}
        deliveryagent = Deliveryagent.new
        deliveryagent.agency_id = params[:agency_id]
        deliveryagent.agent_name = params[:name]
        deliveryagent.phone = params[:phone]
        deliveryagent.is_active = true
        deliveryagent.rating = 0
        deliveryagent.save
        render :json => response
    end

    def get_agents
        response = {:status => "success" ,:code => 200}
        delivery_agent_obj = Deliveryagent.where(:agency_id => params[:agency_id])
        response[:data] = delivery_agent_obj
        render :json => response
    end

    def get_all_agents
        response = {:status => "success" ,:code => 200}
        account_id = get_account_id params[:monday_account_id]
        if account_id
            deliver_agency = DeliveryAgency.where(:account_id => account_id).pluck(:id)
            delivery_agent_obj = Deliveryagent.where(:agency_id => deliver_agency)
        end
        response[:data] = delivery_agent_obj
        render :json => response
    end

    def edit 
        response = {:status => "success" , :code => 200}
        account_id = get_account_id params[:monday_account_id]
        DeliveryAgency.where(:account_id => account_id , :id => params[:agency_id]).update_all(:agency_name => params[:name],:address => params[:address],:phone => params[:phone],:is_active => params[:is_active],:rating => params[:rating])
        render :json => response
    end

    def destroy
        response = {:status => "success" , :code => 200}
        account_id = get_account_id params[:monday_account_id]
        DeliveryAgency.where(:account_id => account_id,:id => params[:id]).destroy_all()
        Deliveryagent.where(:agency_id => params[:id]).destroy_all()
        render :json => response
    end

    def edit_agent
        response = {:status => "success" , :code => 200}
        account_id = get_account_id params[:monday_account_id]
        Deliveryagent.where(:id => params[:agent_id]).update_all(:agent_name => params[:name],:phone => params[:phone],:is_active => params[:is_active],:rating => params[:rating])
        render :json => response
    end
end
