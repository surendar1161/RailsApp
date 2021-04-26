module ExceptionHelper
    def catch_all_exceptions(e, custom_message=nil)
        begin
            hash = {}
            puts "exception occured"
            puts e
        rescue Exception => excep
            puts excep
        end
    end
end