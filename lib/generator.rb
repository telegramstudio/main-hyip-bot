require 'coinbase/wallet'
client = Coinbase::Wallet::Client.new(api_key: "9cIzFKBuopI7SOo7", api_secret: "k0FRfiXKV6DjFt7ZboReQVZYo4x9ZvM9")
p client
ac = client.primary_account
p ac.addresses
#ac.create_address
#ac.update!(name: "Привет из консоли")

#API Key: Sp05iUaYh5dgurBK
#API Secret: v0Hg7qj9eo6xELFs43FDHScHqPe3vNqN 



