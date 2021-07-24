require 'sinatra'
require_relative './controllers/item_controller.rb'
require_relative './controllers/category_controller.rb'


get '/category' do
    controller = CategoryController.new
    controller.all_category
end

get '/category/new' do
    controller = CategoryController.new
    controller.create_category_form
end

get '/category/update/:id' do
    controller = CategoryController.new
    controller.get_category_id(params)
end

get '/category/:id' do
    controller = CategoryController.new
    controller.get_category_details_id(params)
end

get '/' do
    controller = ItemController.new
    controller.get_items
end

get '/items/new' do
    controller = CategoryController.new
    controller.get_category
end

get '/items/:id' do
    controller = ItemController.new
    controller.get_details_item(params)
end

get '/items/update/:id' do
    controller = ItemController.new
    controller.get_details_item_update(params)
end

post '/items/delete/:id' do
    controller = ItemController.new
    controller.delete_item(params)
    redirect '/'
end

post '/items/create' do
    controller = ItemController.new
    controller.create_items(params)
    redirect '/'
end

post '/items/update/item/:id' do
    controller = ItemController.new
    controller.update_items(params)
    redirect '/'
end

post '/category/create' do
    controller = CategoryController.new
    controller.new_category(params)
    redirect '/category'
end

post '/category/update/:id/update' do
    controller = CategoryController.new
    controller.update_category_id(params)
    redirect '/category'
end

post '/category/delete/:id' do
    controller = CategoryController.new
    controller.delete_category_id(params)
    redirect '/category'
end