require_relative '../models/item.rb'
require_relative '../models/item_category.rb'
require_relative '../models/category.rb'

class ItemController

    def get_items
        item = Item.get_all_items
        renderer = ERB.new(File.read("./views/index.erb"))
        renderer.result(binding)
    end

    def get_details_item(params)
        items = ItemCategory.new(params[:id], 1, 1).get_by_id
        renderer = ERB.new(File.read("./views/detail_index.erb"))
        renderer.result(binding)
    end

    def get_details_item_update(params)
        items = ItemCategory.new(params[:id], 1, 1).get_by_id
        categories = Category.get_all_category
        renderer = ERB.new(File.read("./views/detail_index_update.erb"))
        renderer.result(binding)
    end

    def delete_item(params)
        item = Item.new(params[:id], 1, 1)
        item.delete_item
    end

    def create_items(params)
        item = ItemCategory.new(1, params["name"],params["price"], 1, params["category_id"])
        item.insert_item
    end

    def update_items(params)
        item = ItemCategory.new(params[:id], params["name"], params["price"], 1, params["category_id"])
        item.update_by_id
    end
end