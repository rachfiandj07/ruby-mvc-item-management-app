require_relative '../../controllers/item_controller.rb'
require_relative '../../models/item.rb'
require_relative '../../models/item_category.rb'
require_relative '../../models/category.rb'

describe ItemController do
    
    describe 'get items' do
        
        it 'should show with data' do
            controller = ItemController.new
            
            allow(Item).to receive(:get_all_items).and_return([])


            item = Item.get_all_items
            response = controller.get_items
            expected_view = ERB.new(File.read("./views/index.erb"))
            expect(response).to eq expected_view.result(binding)
        end

        it 'should show with details data' do
            item = double()
            items = [item]

            allow(item).to receive(:get_by_id).and_return(items)
            
            allow(item).to receive(:id).and_return(1)
            allow(item).to receive(:name).and_return("ayam")
            allow(item).to receive(:price).and_return(2000)
            allow(item).to receive(:category).and_return("sweet")

            allow(ItemCategory).to receive(:new).and_return(item)
            
            controller = ItemController.new

            response = controller.get_details_item({id: 1})
            expected_view = ERB.new(File.read("./views/detail_index.erb"))
            expect(response).to eq expected_view.result(binding)
        end

        it 'should show with details data update' do
            item = double()
            items = [item]

            allow(Category).to receive(:get_all_category).and_return([])

            allow(item).to receive(:get_by_id).and_return(items)
            allow(item).to receive(:id).and_return(1)
            allow(item).to receive(:name).and_return("ayam")
            allow(item).to receive(:price).and_return(2000)
            allow(item).to receive(:category).and_return("sweet")
            allow(item).to receive(:category_id).and_return(1)
            allow(ItemCategory).to receive(:new).and_return(item)

            controller = ItemController.new
            response = controller.get_details_item_update({id: 1})

            categories = Category.get_all_category

            expected_view = ERB.new(File.read("./views/detail_index_update.erb"))

            expect(response).to eq expected_view.result(binding)
        end

    end

    describe 'delete item' do
        
        it 'should delete item' do
            item = double()

            expect(item).to receive(:delete_item)
            allow(Item).to receive(:new).and_return(item)

            controller = ItemController.new
            controller.delete_item({id: 1})
        end

    end

    describe 'create items' do

        it 'should create item' do
            item = double()
            expect(item).to receive(:insert_item)
            allow(ItemCategory).to receive(:new).and_return(item)

            controller = ItemController.new
            params = {
                "id"=> 1,
                "name"=> "a",
                "price"=> 1000,
                "category_id"=>1
            }
            controller.create_items(params)

        end


    end

    describe 'delete items' do
        
        it 'should delete item' do
            item = double()
            expect(item).to receive(:update_by_id)
            allow(ItemCategory).to receive(:new).and_return(item)

            controller = ItemController.new
            params = {
                "id"=> 1,
                "name"=> "a",
                "price"=> 1000,
                "category_id"=>1
            }
            controller.update_items(params)

        end

    end
end