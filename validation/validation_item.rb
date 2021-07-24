require_relative '../models/item.rb'

class ValidationItem < Item

    def initialize(id, name, price)
        super(id, name, price)
    end

    def valid_item?
        return false if @name.nil?
        return false if @price.is_a? String
    end
end