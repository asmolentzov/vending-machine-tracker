require 'rails_helper'

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
    describe 'it should show info about that snack and the locations it is in' do
      owner = Owner.create(name: "Sam's Snacks")
      machine_1  = owner.machines.create(location: "Don's Mixed Drinks")
      machine_2  = owner.machines.create(location: "Turing Kitchen")
      machine_3  = owner.machines.create(location: "Mystery Hill")
      snack = Snack.create(name: "Cheetos", price: 2.5, machines: [machine_1, machine_2, machine_3])
      
      visit snack_path(snack)
      
      expect(page).to have_content(snack.name)
      expect(page).to have_content("Price: #{snack.price}")
      expect(page).to have_content(machine_1.location)
      expect(page).to have_content(machine_2.location)
      expect(page).to have_content(machine_3.location)
    end
  end
end