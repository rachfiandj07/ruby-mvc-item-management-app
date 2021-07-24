require_relative '../db/db_connector.rb'

class ItemCategory
    attr_reader :id, :name, :price, :category, :category_id

    def initialize(id, name, price, category=nil, category_id=nil)
        @id = id
        @name = name
        @price = price
        @category = category
        @category_id = category_id
    end

    def insert_item
        client = create_db_client
        query = client.query("INSERT INTO items (name,price) VALUES ('#{@name}', #{@price})")
        query = client.query("SET @id = LAST_INSERT_ID();")
        query = client.query("INSERT INTO item_categories (item_id,category_id) VALUES(@id, #{@category_id});")
    end

    def get_by_id
        items = Array.new
        client = create_db_client
        rawData = client.query("SELECT items.item_id, items.name as 'item_name', items.price, categories.name as 'category_name', categories.id as 'category_id' 
                                from items
                                left join item_categories on items.item_id = item_categories.item_id
                                left join categories on categories.id = item_categories.category_id
                                WHERE items.item_id=#{@id}")
        rawData.each do |data|
            items.push(ItemCategory.new(data['item_id'],data['item_name'],data['price'],data['category_name'],data['category_id']))
        end
        items
    end

    def update_by_id
        client = create_db_client
        query = client.query("UPDATE item_categories SET item_categories.category_id = #{@category_id} WHERE item_categories.item_id = #{@id};")
        query = client.query("UPDATE items SET items.name = '#{@name}', items.price = #{@price} WHERE items.item_id = #{@id};")
    end

    def get_category_details
        client = create_db_client
        categories = Array.new
        rawData = client.query("SELECT c.id AS `categories_id`, c.name AS `categories_name`, GROUP_CONCAT(i.name) AS `item_name`
                              FROM categories c
                              LEFT JOIN item_categories ic ON ic.category_id = c.id
                              LEFT JOIN items i ON i.item_id = ic.item_id
                              WHERE c.id = #{@id}")
        rawData.each do |data|
            categories.push(ItemCategory.new(data['categories_id'],data['categories_name'],price=nil,data['item_name']))
        end
        categories
    end
    
end