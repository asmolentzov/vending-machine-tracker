require 'rails_helper'
include ActionView::Helpers::NumberHelper

# As a visitor
# When I visit a snack show page
# I see the name of that snack
#   and I see the price for that snack
#   and I see a list of locations with vending machines that carry that snack
#   and I see the average price for snacks in those vending machines
#   and I see a count of the different kinds of items in that vending machine.
# Flaming Hot Cheetos
# Price: $2.50
# Locations
# * Don's Mixed Drinks (3 kinds of snacks, average price of $2.50)
# * Turing Basement (2 kinds of snacks, average price of $3.00)
  
describe 'As a visitor to the site' do
  describe 'when I visit the snack show page' do
    it 'it should show info about that snack and the locations it is in' do
      owner = Owner.create(name: "Sam's Snacks")
      machine_1  = owner.machines.create(location: "Don's Mixed Drinks")
      machine_2  = owner.machines.create(location: "Turing Kitchen")
      machine_3  = owner.machines.create(location: "Mystery Hill")
      snack = Snack.create(name: "Cheetos", price: 2.5, machines: [machine_1, machine_2, machine_3])
      
      visit snack_path(snack)
      
      expect(page).to have_content(snack.name)
      expect(page).to have_content("Price: #{number_to_currency(snack.price)}")
      expect(page).to have_content(machine_1.location)
      expect(page).to have_content(machine_2.location)
      expect(page).to have_content(machine_3.location)
    end
    it 'should show additional info about snacks in each location' do
      owner = Owner.create(name: "Sam's Snacks")
      machine_1  = owner.machines.create(location: "Don's Mixed Drinks")
      machine_2  = owner.machines.create(location: "Turing Kitchen")
      machine_3  = owner.machines.create(location: "Mystery Hill")
      snack_1 = Snack.create(name: "Cheetos", price: 2.5, machines: [machine_1, machine_2, machine_3])
      snack_3 = Snack.create(name: "Oreos", price: 4.0, machines: [machine_3])
      snack_4 = Snack.create(name: "M & M's", price: 3.0, machines: [machine_2, machine_3])
      
      visit snack_path(snack_1)
      
      expect(page).to have_content("#{machine_1.location} (#{machine_1.snacks.count} kind of snack, average price of #{number_to_currency(machine_1.snacks.average_price)})")
      expect(page).to have_content("#{machine_2.location} (#{machine_2.snacks.count} kinds of snacks, average price of #{number_to_currency(machine_2.snacks.average_price)})")
      expect(page).to have_content("#{machine_3.location} (#{machine_3.snacks.count} kinds of snacks, average price of #{number_to_currency(machine_3.snacks.average_price)})")
      save_and_open_page
    end
  end
end