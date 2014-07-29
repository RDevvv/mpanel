class CalculateInactive
    @queue = :calculate_inactive
    def self.perform()
        Customer.calculate_inactive
    end
end
