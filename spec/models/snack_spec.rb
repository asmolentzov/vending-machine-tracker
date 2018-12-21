require 'rails_helper'

describe Snack, type: :model do
  describe 'class methods' do
    describe '.average_price' do
      it 'should return the average price for the snacks' do
        owner = Owner.create(name: "Sam's Snacks")
        machine  = owner.machines.create(location: "Don's Mixed Drinks")
        snack_1 = machine.snacks.create(name: "Cheetos", price: 2.5)
        snack_2 = machine.snacks.create(name: "Doritos", price: 3.5)
        snack_3 = machine.snacks.create(name: "Oreos", price: 3.0)
        average = 3.0
        
        expect(Snack.average_price).to eq(average)
      end
    end
  end
end