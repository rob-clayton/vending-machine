# Vending Machine

Vending Machine:
1. A terminal based "Vending Machine".
1. Returns an item:
    1. Only when enough money has been inserted.
    1. When too much money return the change.
    1. When too little money ask for more.
1. Takes an initial load:
    1. Of products.
    1. Of change.
1. Be able to reload stock:
    1. For products.
    1. For change.
1. Track the inventory changes:
    1. For products.
    1. For change.

## Design Approach
1. Effiency. Keeping the code Clean using DRY and single responsibility methodologies.
1. Readability. All code must be understandable without needing to "double check" what it does.
1. Tests. All functionality should be covered by tests.
1. Build. To be built using Test Driven Development and Object Orientated Programming.

## How to run
### Set-up:
You will need to install Ruby 2.7.2. Here is an example of how to install with rbenv:
1. Install brew: https://brew.sh/. 
1. `brew install rbenv` if you already have rbenv you may need to upgrade it `brew upgrade rbenv`.
1. To view available Ruby versions `rbenv install -l`. For MacOS: if 2.7.2 is not availble you may need to run `brew upgrade ruby-build`.
1. Install Ruby 2.7.2: `rbenv install 2.7.2`

Once Ruby is installed you need to install the gems. Here is an example of how to install with bundler:
1. `gem install bundler`
1. `bundle install`

### Running the program
This is built to be run in `irb` or `pry`. 
To start open your terminal and start either irb or pry (`irb` or `pry`.)  
Once in the console require vending_machine.rb:
```shell script
[1] pry(main)> require './vending_machine.rb'
=> true
```
Create a new vending machine:
```shell script
[2] pry(main)> vm = VendingMachine.new
=> #<VendingMachine:0x00007fe9ab8d69d0 ... >
```
All the commands can be ran this VendingMachine instance:
- help
- inventory
- balance
- purchase(item_name)

Help prints out a list of available commands:
```shell script
[3] pry(main)> vm.help
The following commands are available:
inventory - prints a table of all items
balance - returns you balance
purchase(item_name) - for example purchase('Mars')
=> nil
```

Inventory prints a table of all items:
```shell script
[4] pry(main)> vm.inventory
+----------+-------+-------+
|     Vending Machine      |
+----------+-------+-------+
| Name     | Price | Stock |
+----------+-------+-------+
| Mars     | 120   | 3     |
| Snickers | 110   | 5     |
| Twix     | 85    | 2     |
| Buttons  | 95    | 5     |
+----------+-------+-------+
=> nil
```

Balance returns a formatted balance.
```shell script
[5] pry(main)> vm.balance
=> "Balance: £2.00"
```

Purchase returns your item, your change, reduces that items stock by 1 and resets your balance.
```shell script
[6] pry(main)> vm.purchase('Mars')
Your change is: 50p, 20p, 10p
Here is your Mars!
=> nil
```


## Conclusion
During this project, I focused on the quality of the code written and the design of the application.

For design, I specifically wanted a separation of concerns. A lib directory to handle more functional or complex tasks. 
Simple Models for base object types. Controllers to interface with the Models and hold the interaction logic, and 
Presenters to control the formatting.

On code quality: I wanted to write quality code, even if it meant not all objects are met. 

With this in mind, I started on what I presumed to be the most complicated section, calculating the returned change. 
I spend quite some time making sure this is very clean, readable, and efficient. 

After dealing with the complexity, I focused on the design. I created an Item model and a CRUD style Inventory Controller, 
allowing for not only a clean interface but something that should be instantly understandable by another developer. 

A note on the InventoryController:
I did debate about using an SQLite database and storing Items in memory. This could have been achieved in the 
InventoryController, on initialise we could create a new SQLite table to store Items. Additionally, InventoryController 
could be a singleton class, allowing the Inventory Database table to be called from anywhere in the app and still have a 
single source of truth. This could have been a compromise considering we have no server or framework where each class is 
instantiated.

After creating the Model, Controller design, and completing the more complex Money class, the one thing missing was a 
way to display the data. I used a gem called terminal-table to present the Inventory and wrote some basic string 
formatting to present the money.

Now having this core functionality, time was running low. The `purchase` and `balance` methods are only written in the 
main `vending_machine.rb` for this reason. As the functionality was already created, I at least wanted to make program 
functional even if it meant piecing it together in the main file.

### Futher work
- There is no function to insert coins. With the Money class, I would verify that correct denominations are inserted, 
then append the total to the balance. To make the app workable, I have set the default amount to £2.00 when a new
machine is created.
- There is no Change tracking. The correct change is returned after a purchase, but there is not a store of how many of 
each coin is in the machine. I planned to create another Model, Controller design just as I have with Item and Inventory. 
It would have a Coin Model and a Balance Controller.
- There is no Reload option. The functionality is ready to be used in the Inventory Controller; however, I did not have 
time to write the class and check all the validations.

#### Additional ideas:
- If I had a lot more time I would create a script, that would trigger a Command Line Interface (CLI). The CLI would move 
the user from directories and would also negate the need for any user input. A GEM such as TTY Prompt would be fantastic:
https://github.com/piotrmurach/tty-prompt

