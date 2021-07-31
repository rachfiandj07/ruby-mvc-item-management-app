require_relative '../../models/item.rb'

describe Item do

    describe 'valid?' do

        context 'given valid params' do

            it 'should return true' do
                item = Item.new(1, 'ayam', 2000)

                expect(item.valid?).to eq(true)
            end
            
        end

        context 'given invalid params' do

            it 'should return false when price nil' do
                item = Item.new(1, 'ayam', nil)

                expect(item.valid?).to eq(false)
            end

            it 'should return false when name nil' do
                item = Item.new(1, nil, 2000)

                expect(item.valid?).to eq(false)
            end
            
        end
    end

    describe 'get all items' do

        it 'should show all items' do
            stub_client = double()
            stub_query = "SELECT * FROM items"

            # mock with available array
            items = [{"item_id": 1, "name": "ayam", "price": 5000}]

            # mock with empty array
            # items = []


            allow(Mysql2::Client).to receive(:new).and_return(stub_client)
            expect(stub_client).to receive(:query).with(stub_query).and_return(items)
            
            item = Item.get_all_items
            expect(item).not_to be_nil
        end

    end

    describe 'delete items' do

        it 'should delete items' do

            stub_client = double()
            stub_query = "DELETE FROM item_categories WHERE item_id=1;"
            stub_query1 = "DELETE FROM items WHERE item_id=1"

            allow(Mysql2::Client).to receive(:new).and_return(stub_client)
            expect(stub_client).to receive(:query).with(stub_query)
            expect(stub_client).to receive(:query).with(stub_query1)
            item = Item.new(1,"ayam", 2000)
            item.delete_item
        end

    end

end