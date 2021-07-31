require_relative '../../models/category.rb'
require_relative '../../models/item_category.rb'
require_relative '../../controllers/category_controller.rb'


describe CategoryController do
    describe 'get category' do
        it 'should show form create category with data' do
            controller = CategoryController.new
            
            allow(Category).to receive(:get_all_category).and_return([])


            categories = Category.get_all_category
            response = controller.get_category
            expected_view = ERB.new(File.read("./views/create.erb"))
            expect(response).to eq expected_view.result(binding)
        end

        it 'should show all category data' do
            controller = CategoryController.new
            
            allow(Category).to receive(:get_all_category).and_return([])


            categories = Category.get_all_category
            response = controller.all_category
            expected_view = ERB.new(File.read("./views/category.erb"))
            expect(response).to eq expected_view.result(binding)
        end
    end

    describe 'show form' do
        
        it 'should show form (view only)' do

            controller = CategoryController.new
            response = controller.create_category_form
            expected_view = ERB.new(File.read("./views/create_category.erb"))
            expect(response).to eq expected_view.result(binding)
        end

    end

    describe 'create new category' do

        it 'category should created' do
            categories = double()
            expect(categories).to receive(:create_category)
            allow(Category).to receive(:new).and_return(categories)

            controller = CategoryController.new
            params = {
                "name"=> "a",
            }
            controller.new_category(params)
        end

    end

    describe 'update category' do

        it 'category should updated' do
            categories = double()
            expect(categories).to receive(:update_category)
            allow(Category).to receive(:new).and_return(categories)

            controller = CategoryController.new
            params = {
                "name"=> "a",
            }
            controller.update_category_id(params)
        end

    end

    describe 'get category' do

        it 'should show category id' do
            cat = double()
            categories = [cat]

            allow(cat).to receive(:get_category_id).and_return(categories)
            
            allow(cat).to receive(:id).and_return(1)
            allow(cat).to receive(:name).and_return("ayam")

            allow(Category).to receive(:new).and_return(cat)
            
            controller = CategoryController.new

            response = controller.get_category_id({id: 1})
            expected_view = ERB.new(File.read("./views/update_category.erb"))
            expect(response).to eq expected_view.result(binding)
        end

        it 'should show details category id' do
            cat = double()
            categories = [cat]

            allow(cat).to receive(:get_category_details).and_return(categories)
            
            allow(cat).to receive(:id).and_return(1)
            allow(cat).to receive(:name).and_return("ayam")
            allow(cat).to receive(:price).and_return(2000)
            allow(cat).to receive(:category).and_return("sweet")

            allow(ItemCategory).to receive(:new).and_return(cat)
            
            controller = CategoryController.new

            response = controller.get_category_details_id({id: 1})
            expected_view = ERB.new(File.read("./views/detail_category.erb"))
            expect(response).to eq expected_view.result(binding)
        end

    end

    describe 'delete category' do

        it 'should delete category' do
            categories = double()
            expect(categories).to receive(:delete_category)
            allow(Category).to receive(:new).and_return(categories)

            controller = CategoryController.new
            controller.delete_category_id({id: 1})
        end

    end


end