module CustomerHelper

    def is_customer_added user_details , monday_account_id
        val = false
        cst = Customer.find_by(:email => user_details[:email],:account_id => monday_account_id)
        if cst.nil?
            val = true
        end
        val
    end

    def add_customer user_details , monday_account_id
        if  is_customer_added user_details , monday_account_id
            customer = Customer.new 
            customer.email = user_details[:email]
            customer.name = user_details[:contactname]
            customer.phone = user_details[:mobile]
            customer.account_id = monday_account_id
            customer.address = user_details[:address]
            customer.no_of_orders = 1
            customer.save
        else 
            cst = Customer.find_by(:email => user_details[:email] , :account_id => monday_account_id)
            Customer.where(:id => cst.id).update_all(:no_of_orders => cst.no_of_orders+1)
        end
        cst = Customer.find_by(:email => user_details[:email] , :account_id => monday_account_id)
        cst.id
    end
end
