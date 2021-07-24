require_relative '../db/db_connector.rb'

class Item
    attr_accessor :id, :name, :price

    def initialize(id, name, price)
        @id = id
        @name = name
        @price = price
    end

    def delete_item
        client = create_db_client
        query = client.query("DELETE FROM item_categories WHERE item_id=#{@id};")
        query1 = client.query("DELETE FROM items WHERE item_id=#{@id}")
    end

    def self.get_all_items
        items = Array.new
        client = create_db_client
        rawData = client.query("SELECT * FROM items")
        rawData.each do |data|
            items.push(Item.new(data['item_id'],data['name'],data['price']))
        end
        items
    end
end