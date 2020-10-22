class InventoryInitialiser
  def self.default_load(inventory)
      inventory.create('Mars', 120, 3)
      inventory.create('Snickers', 110, 5)
      inventory.create('Twix', 85, 2)
      inventory.create('Buttons', 95, 5)
      inventory
  end
end
