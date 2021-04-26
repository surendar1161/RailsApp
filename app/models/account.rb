class Account < ApplicationRecord
    class Status
        ACTIVE = 1
        DEACTIVE = 2
    end

    class Plan
        PAID = 1
        TRIAL = 2
        FREE = 3
    end
end
