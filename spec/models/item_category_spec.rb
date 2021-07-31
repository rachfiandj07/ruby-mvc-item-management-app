require_relative '../../models/item_category.rb'

describe ItemCategory do

    describe 'get category details by id' do
        
        it 'should show category details by id' do
            stub_client = double()
            stub_query = "SELECT c.id AS `categories_id`, c.name AS `categories_name`, GROUP_CONCAT(i.name) AS `item_name`
                              FROM categories c
                              LEFT JOIN item_categories ic ON ic.category_id = c.id
                              LEFT JOIN items i ON i.item_id = ic.item_id
                              WHERE c.id = 1"
            category = []

            allow(Mysql2::Client).to receive(:new).and_return(stub_client)
            expect(stub_client).to receive(:query).with(stub_query).and_return(category)

            categories = ItemCategory.new(1, "ayam", 2000)
            expect(categories.get_category_details).not_to be_nil
        end
        
    end

    describe 'update by id' do
        
        it 'should update item & category by id' do
            stub_client = double()
            stub_query = "UPDATE item_categories SET item_categories.category_id = 1 WHERE item_categories.item_id = 2;"
            stub_query1 = "UPDATE items SET items.name = 'ayam', items.price = 2000 WHERE items.item_id = 2;"

            allow(Mysql2::Client).to receive(:new).and_return(stub_client)
            expect(stub_client).to receive(:query).with(stub_query)
            expect(stub_client).to receive(:query).with(stub_query1)

            categories = ItemCategory.new(2, "ayam", 2000, "sweet", 1)
            categories.update_by_id
        end
    end

    describe 'insert item with category' do

        it 'should create item with category' do
            stub_client = double()
            stub_query = "INSERT INTO items (name,price) VALUES ('ayam', 2000)"
            stub_query1 = "SET @id = LAST_INSERT_ID();"
            stub_query2 = "INSERT INTO item_categories (item_id,category_id) VALUES(@id, 1);"

            allow(Mysql2::Client).to receive(:new).and_return(stub_client)
            expect(stub_client).to receive(:query).with(stub_query)
            expect(stub_client).to receive(:query).with(stub_query1)
            expect(stub_client).to receive(:query).with(stub_query2)

            categories = ItemCategory.new(1, "ayam", 2000, "sweet", 1)
            categories.insert_item
        end

    end

end