class Order < ApplicationRecord

    class Status
        PLACED = 1
        SHIPPED = 2
        OUTFORDELIVERY = 3
        RETURN = 4
        DELIVERED = 5
        CANCELLED = 6
    end
end
