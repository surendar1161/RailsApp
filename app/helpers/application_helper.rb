module ApplicationHelper

    def create_account account_id
        account = Account.new
        account.monday_account_id = account_id
        account.account_status = Account::Status::ACTIVE
        account.plan_type = Account::Plan::TRIAL
        account.save
        our_account_id = Account.find_by(:monday_account_id => account_id).id
        our_account_id
    end
end
