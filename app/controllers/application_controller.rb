require 'json'
include ApplicationHelper
include ExceptionHelper
class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session
    def check_account_exists
        return true
    end
    def get_account_id monday_account_id
        begin
            account_id = Account.find_by(:monday_account_id => monday_account_id)        
            unless account_id.nil?
                account_id = account_id.id 
            else
                account_id = create_account monday_account_id
            end
            account_id    
        rescue Exception => e 
            catch_all_exceptions e
        end
    end
end