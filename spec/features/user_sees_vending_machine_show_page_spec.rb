require 'rails_helper'

# As a visitor
# When I visit a vending machine show page
# I also see an average price for all of the snacks in that machine

describe 'As a visitor to the app' do
  describe 'when I visit the vending machine show page' do
    it 'should show all the snacks in the machine' do
      owner = Owner.create(name: "Sam's Snacks")
      machine  = owner.machines.create(location: "Don's Mixed Drinks")
      snack_1 = machine.snacks.create(name: "Cheetos", price: 2.5)
      snack_2 = machine.snacks.create(name: "Doritos", price: 3.5)
      snack_3 = machine.snacks.create(name: "Oreos", price: 3.0)
      
      visit machine_path(machine)
      
      within "#snack-#{snack_1.id}" do
        expect(page).to have_content("#{snack_1.name}: $#{snack_1.price}")
      end
      within "#snack-#{snack_2.id}" do
        expect(page).to have_content("#{snack_2.name}: $#{snack_2.price}")
      end
      within "#snack-#{snack_3.id}" do
        expect(page).to have_content("#{snack_3.name}: $#{snack_3.price}")
      end
    end
    it 'should show average price for all snacks in the machine' do
      owner = Owner.create(name: "Sam's Snacks")
      machine  = owner.machines.create(location: "Don's Mixed Drinks")
      snack_1 = machine.snacks.create(name: "Cheetos", price: 2.5)
      snack_2 = machine.snacks.create(name: "Doritos", price: 3.5)
      snack_3 = machine.snacks.create(name: "Oreos", price: 3.0)
      
      visit machine_path(machine)
      
      expect(page).to have_content("Average Price: #{machine.snacks.average_price}")
    end
  end
end