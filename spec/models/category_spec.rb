require_relative '../../models/category.rb'

describe Category do

    describe 'get all category' do

         it 'should show all category' do
            stub_client = double()
            stub_query = "SELECT * FROM categories"

            category_list = [{"id": 1, "name": "sweet"}]

            allow(Mysql2::Client).to receive(:new).and_return(stub_client)
            expect(stub_client).to receive(:query).with(stub_query).and_return(category_list)
             
            category = Category.get_all_category
            expect(category_list).not_to be_nil
         end

    end

    describe 'delete category' do

        it 'should delete category' do
            stub_client = double()
            stub_query = "DELETE FROM item_categories WHERE category_id = 1;"
            stub_query1 = "DELETE FROM categories WHERE id = 1;"

            allow(Mysql2::Client).to receive(:new).and_return(stub_client)
            expect(stub_client).to receive(:query).with(stub_query)
            expect(stub_client).to receive(:query).with(stub_query1)

            category = Category.new(1,"sweet")
            category.delete_category
        end
   end

   describe 'update category' do

        it 'should update category' do
            stub_client = double()
            stub_query = "UPDATE categories SET categories.name = 'sweet' WHERE categories.id = 1 "
            
            allow(Mysql2::Client).to receive(:new).and_return(stub_client)
            expect(stub_client).to receive(:query).with(stub_query)

            category = Category.new(1, "sweet")
            category.update_category
        end

   end 

   describe 'get category id' do

       it 'should get category by id' do
           stub_client = double()
           stub_query = "SELECT * FROM categories WHERE id = 1"

           category_list = [{"id": 1, "name": "sweet"}]

           allow(Mysql2::Client).to receive(:new).and_return(stub_client)
           expect(stub_client).to receive(:query).with(stub_query).and_return(category_list)

           category = Category.new(1, "sweet")
           category.get_category_id
       end
   end

   describe 'create category' do

        it 'should create category' do
            stub_client = double()
            stub_query = "INSERT INTO categories (name) VALUES ('sweet')"
            
            allow(Mysql2::Client).to receive(:new).and_return(stub_client)
            expect(stub_client).to receive(:query).with(stub_query)

            category = Category.new(1, "sweet")
            category.create_category
        end
   end

end