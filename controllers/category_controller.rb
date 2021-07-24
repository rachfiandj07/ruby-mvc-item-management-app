require_relative '../models/category.rb'
require_relative '../models/item_category.rb'

class CategoryController

    def get_category
        categories = Category.get_all_category
        renderer = ERB.new(File.read("./views/create.erb"))
        renderer.result(binding)
    end
    
    def all_category
        categories = Category.get_all_category
        renderer = ERB.new(File.read("./views/category.erb"))
        renderer.result(binding)
    end

    def create_category_form
        renderer = ERB.new(File.read("./views/create_category.erb"))
        renderer.result(binding)
    end

    def new_category(params)
        categories = Category.new(1, params["name"])
        categories.create_category
    end

    def get_category_id(params)
        categories = Category.new(params[:id]).get_category_id
        renderer = ERB.new(File.read("./views/update_category.erb"))
        renderer.result(binding)
    end

    def update_category_id(params)
        categories = Category.new(params[:id], params["name"])
        categories.update_category
    end

    def get_category_details_id(params)
        categories = ItemCategory.new(params[:id], 1, 1).get_category_details
        renderer = ERB.new(File.read("./views/detail_category.erb"))
        renderer.result(binding)
    end

    def delete_category_id(params)
        categories = Category.new(params[:id])
        categories.delete_category
    end
end