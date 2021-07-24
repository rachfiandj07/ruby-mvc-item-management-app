require_relative '../db/db_connector.rb'

class Category
    attr_accessor :id, :name

    def initialize(id, name=nil)
        @id = id
        @name = name
    end

    def create_category
        client = create_db_client
        query = client.query("INSERT INTO categories (name) VALUES ('#{@name}')")
    end

    def get_category_id
        categories = Array.new
        client = create_db_client
        rawData = client.query("SELECT * FROM categories WHERE id = #{@id}")
        rawData.each do |data|
            categories.push(Category.new(data["id"],data["name"]))
        end
        categories
    end

    def update_category
        client = create_db_client
        query = client.query("UPDATE categories SET categories.name = '#{@name}' WHERE categories.id = #{@id} ")
    end

    def self.get_all_category
        categories = Array.new
        client = create_db_client
        rawData = client.query("SELECT * FROM categories")
        rawData.each do |data|
            categories.push(Category.new(data['id'],data['name']))
        end
        categories
    end

    def delete_category
        client = create_db_client
        query = client.query("DELETE FROM item_categories WHERE category_id = #{@id};")
        query = client.query("DELETE FROM categories WHERE id = #{@id};")
    end
end